function particle_i_velocity_derivation = function_approximation_velocity_derivation(domain, i)
%FUNCTION_PARTICLE_FIND_NEIGHBOURS Summary of this function goes here
%   Detailed explanation goes here

%sph
sph_smoothing_length = domain(8,i);
%-------------------------------------------------------------------------

%initialization
particle_i_velocity_derivation = 0;
%-------------------------------------------------------------------------

%search above

%-------------------------------------------------------------------------
signum = 1;
%-------------------------------------------------------------------------

j = i+1;

if (j <= length(domain(1,:)))

    particle_distance =  abs(domain(1,i) - domain(1,j));

    while particle_distance < sph_smoothing_length

        %-------------------------------------------------------------------------
        %-------------------------------------------------------------------------
        particle_j_volume = domain(2,j);
        particle_j_area = domain(3,j);
        particle_j_velocity = domain(7,i);
        %-------------------------------------------------------------------------        
        sph_kernel_poly_derivation = function_sph_kernel_poly_derivation(particle_distance, sph_smoothing_length);
        %-------------------------------------------------------------------------
        particle_i_velocity_derivation = particle_i_velocity_derivation + particle_j_volume*particle_j_velocity/particle_j_area*signum*sph_kernel_poly_derivation;
        %-------------------------------------------------------------------------
        %-------------------------------------------------------------------------
        
        j = j+1;

        if (j > length(domain(1,:)))
            break
        end
        particle_distance =  abs(domain(1,i) - domain(1,j));
    end
end

%search beneath

%-------------------------------------------------------------------------
signum = -1;
%-------------------------------------------------------------------------

j = i-1;

if (j >= 1)
    particle_distance =  abs(domain(1,i) - domain(1,j));

    while particle_distance < sph_smoothing_length

        %-------------------------------------------------------------------------
        %-------------------------------------------------------------------------
        particle_j_volume = domain(2,j);
        particle_j_area = domain(3,j);
        particle_j_velocity = domain(7,i);
        %-------------------------------------------------------------------------        
        sph_kernel_poly_derivation = function_sph_kernel_poly_derivation(particle_distance, sph_smoothing_length);
        %-------------------------------------------------------------------------
        particle_i_velocity_derivation = particle_i_velocity_derivation + particle_j_volume*particle_j_velocity/particle_j_area*signum*sph_kernel_poly_derivation;
        %-------------------------------------------------------------------------
        %-------------------------------------------------------------------------

        j = j-1;

        if (j < 1)
            break
        end

        particle_distance =  abs(domain(1,i) - domain(1,j));
    end
end

end

