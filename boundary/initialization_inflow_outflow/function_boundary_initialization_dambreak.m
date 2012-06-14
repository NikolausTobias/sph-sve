function domain_initialization = function_boundary_initialization_dambreak(boundary)
%FUNCTION_BOUNDARY_INITIALIZATION Summary of this function goes here
%   Detailed explanation goes here

fluid_height1 = 1.5;
fluid_height2 = 0.5;

particle_upper_interval = boundary.general.particle_volume/(fluid_height1*boundary.general.channel_width);
particle_lower_interval = boundary.general.particle_volume/(fluid_height2*boundary.general.channel_width);
number_particles_upper_initial = (boundary.general.channel_end/2)/particle_upper_interval + 1 - 1;
number_particles_lower_initial = (boundary.general.channel_end/2)/particle_lower_interval + 1 - 1;

particle = [    0
                boundary.general.particle_volume
                0
                0
                0
                0
                0
                0       
                1];  %1 -> moving!

domain_upper = particle;


particle_upper_delta =  zeros([length(particle),1]);
particle_upper_delta(1) = particle_upper_interval;

for m = 2:number_particles_upper_initial
    domain_upper(:,end+1) = domain_upper(:,end) + particle_upper_delta;
end


particle = [    domain_upper(1,end)
                boundary.general.particle_volume
                0
                0
                0
                0
                0
                0       
                1];  %1 -> moving!
            
domain_lower = particle;

particle_lower_delta =  zeros([length(particle),1]);
particle_lower_delta(1) = particle_lower_interval;

for m = 2:number_particles_lower_initial
    domain_lower(:,end+1) = domain_lower(:,end) + particle_lower_delta;
end

domain_initialization =  [domain_upper, domain_lower];

end