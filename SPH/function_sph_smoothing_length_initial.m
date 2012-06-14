function sph_smoothing_length_initial = function_sph_smoothing_length_initial(domain, i, sph)
%FUNCTION_SPH_SMOOTHING_LENGTH Summary of this function goes here
%   Detailed explanation goes here

particle_i_volume = domain(2,i);
particle_i_area = domain(3,i);


sph.sigma = 1.3;

if particle_i_area > 0
    sph_smoothing_length_initial = sph.sigma*particle_i_volume/particle_i_area;
    
elseif particle_i_area == 0
    sph_smoothing_length_initial = 2;
else
    error('Negative crossectional-area!')
end

end

