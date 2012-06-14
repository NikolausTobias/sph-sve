function particle_i_area = function_approximation_area(domain, i, sph_smoothing_length)
%FUNCTION_PARTICLE_FIND_NEIGHBOURS Summary of this function goes here
%   Detailed explanation goes here

%initialization
particle_i_area = 0;
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
        %-------------------------------------------------------------------------        
        sph_kernel_poly = function_sph_kernel_poly(particle_distance, sph_smoothing_length);
        %-------------------------------------------------------------------------
        particle_i_area = particle_i_area + particle_j_volume*sph_kernel_poly;
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
        %-------------------------------------------------------------------------        
        sph_kernel_poly = function_sph_kernel_poly(particle_distance, sph_smoothing_length);
        %-------------------------------------------------------------------------
        particle_i_area = particle_i_area + particle_j_volume*sph_kernel_poly;
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

