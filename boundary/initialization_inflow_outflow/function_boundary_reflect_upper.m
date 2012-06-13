function [domain, particles_number_reflect_upper] = function_boundary_reflect_upper(domain, handles, particles_number_reflect_upper)
%FUNCTION_BOUNDARY_OUTFLOW Summary of this function goes here
%   Detailed explanation goes here


m = 1;

while (domain(1,m) < 0 && domain(end,m) == 1)
    domain(1,m) = abs(domain(1,m));
    m = m + 1;
end

particles_number_reflect_upper = particles_number_reflect_upper + (m - 1);
set(handles.textOutUpper, 'String', num2str(particles_number_reflect_upper));

domain = sortrows(domain',1)';

end