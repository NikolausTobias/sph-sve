function z = function_boundary_z_elevation(x)
%FUNCTION_BOUNDARY_Z_ELEVATION Summary of this function goes here
%   Detailed explanation goes here
if x < 0
    k = -1;
    z = x.*k;
else x >= 0
    k = -0.005;
    z = x.*k;
end

end

