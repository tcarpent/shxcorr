function [ quats_m ] = SO3SamplingUsingHopf( resolution )

% ==============================================================================
% Generates a sampling grid for SO(3), using Hopf fibration sampling
%
% quats_m : unit quaternions
% ==============================================================================


% security clipping
actualResolution = min( max( resolution, 1 ), 7 );

psiPoints_v = makeGridS1( actualResolution );

assert( isempty( psiPoints_v ) == false );

nSide     = 2^actualResolution;
numPixels = nside2npix( nSide );

% initiates the array for the pixel number -> (x,y) mapping
[ pix2x, pix2y ] = mk_pix2xy();

healpixPoints_m = zeros( numPixels, 2 );
for ii = 0 : (numPixels-1)
    
    [ theta, phi ] = pix2ang_nest( nSide, ii, pix2x, pix2y );

    healpixPoints_m( ii+1, : ) = [ theta phi ];
end

S3Points = zeros( numPixels * length( psiPoints_v ), 3 );
index = 1;
for ii = 1 : numPixels
    for jj = 1 : length( psiPoints_v )
        temp = [ healpixPoints_m(ii,1) healpixPoints_m(ii,2) psiPoints_v(jj) ];
        S3Points( index, : ) = temp;
        index = index + 1;
    end
end

quats_m = zeros( size( S3Points, 1 ), 4 );
for ii = 1 : size( S3Points, 1 )
    quats_m( ii, : ) = hopf2quat( S3Points( ii, : ) );
end

end

%%
function [ quat_v ] = hopf2quat( pt_v )
halpPt0 = pt_v(1) / 2.0;
halpPt2 = pt_v(3) / 2.0;

x4 = sin( halpPt0 ) * sin( pt_v(2) + halpPt2 );
x1 = cos( halpPt0 ) * cos( halpPt2 );
x2 = cos( halpPt0 ) * sin( halpPt2 );
x3 = sin( halpPt0 ) * cos( pt_v(2) + halpPt2 );

w = x4;
x = x1;
y = x2;
z = x3;

quat_v = [ x y z w ];

% curious, no ?
[ z2, y, z1 ] = QuaternionToEulerZYZ( quat_v );
quat_v = EulerZYZToQuaternion( z1, y, z2 );

end

%%
function psiPoints_v = makeGridS1( resolution )

grids = 6;
numPoints = 2^resolution * grids;
interval = (2*pi) / numPoints;

psiPoints_v = zeros( 1, numPoints );
for ii = 1 : numPoints
    psiPoints_v(ii) = numPoints + (ii-1) * interval;
end

end

%%
function npix = nside2npix( nside )
    npix = 12 * nside * nside;
end

%%
function [ theta, phi ] = pix2ang_nest( nside, ipix, pix2x, pix2y )

ns_max = 8192;
jrll = [ 2, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4 ];
jpll = [ 1, 3, 5, 7, 0, 2, 4, 6, 1, 3, 5, 7 ];

if( nside < 1 || nside > ns_max )
    assert( false );
end

npix = nside2npix( nside );
if( ipix < 0 || ipix > npix-1 )   
    assert( false );
end

fn    = 1.0 * nside;
fact1 = 1.0 / (3.0*fn*fn);
fact2 = 2.0 / (3.0*fn);
nl4   = ( 4 * nside );

% finds the face, and the number in the face
npface = ( nside * nside );

face_num = floor( ipix / npface ); % face number in {0,11}
assert( 0 <= face_num && face_num <= 11 );

ipf = fmod( ipix, npface ); % pixel number in the face {0,npface-1}

% finds the x,y on the face (starting from the lowest corner)
% from the pixel number
ip_low   = fmod( ipf, 1024 );        % content of the last 10 bits
ip_trunc = ipf / 1024;               % truncation of the last 10 bits
ip_med   = fmod( ip_trunc, 1024 );   % content of the next 10 bits
ip_hi    = floor( ip_trunc / 1024 ); % content of the high weight 10 bits

ix = floor( 1024 * pix2x( ip_hi+1 ) + 32 * pix2x( ip_med+1 ) + pix2x( ip_low+1 ) );
iy = floor( 1024 * pix2y( ip_hi+1 ) + 32 * pix2y( ip_med+1 ) + pix2y( ip_low+1 ) );

% transforms this in (horizontal, vertical) coordinates
jrt = ( ix + iy ); % 'vertical' in {0,2*(nside-1)}
jpt = ( ix - iy ); % 'horizontal' in {-nside+1,nside-1}

% computes the z coordinate on the sphere
jr =  ( jrll( face_num + 1 ) * nside - jrt - 1 );
nr = nside; % equatorial region (the most frequent)
z  = (2 * nside - jr) * fact2;
kshift = fmod( jr - nside, 2 );
if jr < nside
    % north pole region
    nr = jr;
    z = 1.0 - nr*nr*fact1;
    kshift = 0;
else
    if jr > 3 * nside
        % then south pole region
        nr = nl4 - jr;
        z = -1.0 + nr * nr * fact1;
        kshift = 0;
    end
end

assert( isnan( z ) == false );
    
theta = acos( z );

% computes the phi coordinate on the sphere, in [0,2Pi]

jp = ( jpll( face_num+1 ) * nr + jpt + 1 + kshift ) / 2;
    
if jp > nl4 
    jp = jp - nl4; 
end
if jp < 1 
    jp = jp + nl4; 
end
    
phi = (jp - (kshift+1) * 0.5) * ((pi/2) / nr);

assert( isnan( theta ) == false );
assert( isnan( phi ) == false );

end

%%
function [ pix2x, pix2y ] = mk_pix2xy()
pix2x = zeros( 1, 1024 );
pix2y = zeros( 1, 1024 );
for kpix = 0 : 1023
    jpix = kpix;
    IX = 0;
    IY = 0;
    IP = 1 ; %              ! bit position (in x and y)
    while( jpix ~= 0 )

        % ! go through all the bits
        ID = fmod( jpix, 2 ); %  ! bit value (in kpix), goes in ix
        jpix = jpix / 2;
        IX = ID * IP + IX;

        ID = fmod( jpix, 2 ); %  ! bit value (in kpix), goes in iy
        jpix = jpix / 2;
        IY = ID * IP + IY;

        IP = 2 * IP; %         ! next bit (in x and y)
    end

    pix2x( kpix+1 ) = IX; %     ! in 0,31
    pix2y( kpix+1 ) = IY; %     ! in 0,31
end
end

%%
function m = fmod(a, b)

% Where the mod function returns a value in region [0, b), this
% function returns a value in the region [-b, b), with a negative
% value only when a is negative.

if a == 0
    m = 0;
else
    m = mod(a, b) + (b*(sign(a) - 1)/2);
end

m = floor( m );

end
