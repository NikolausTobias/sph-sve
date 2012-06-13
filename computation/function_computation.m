function function_computation(time, computation, boundary, sph, visualization, hObject, handles)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%INITZIALISATION
[domain, boundary_upper_particles_number_particles, boundary_lower_particles_number_particles] = function_boundary_initialization(boundary);

particles_number_outflow_lower = 0;
particles_number_reflect_upper = 0;
particles_number_inflow = 0;

% figure(1)
% plot(domain(1,:),domain(4,:),'bo');
% figure(2)
%-------------------------------------------------------------------------



for t = time.start:time.increment:time.end
    
    %set time
    time.t = t;
    set(handles.textTimeCurrent, 'String', num2str(t));
    %-------------------------------------------------------------------------
    
    
    %number particles domain
    set(handles.textNumberParticles, 'String', num2str(length(domain(1,:)) - boundary_upper_particles_number_particles - boundary_lower_particles_number_particles)); 
    %-------------------------------------------------------------------------
    
    
    %boundary inflow
    
    particles_number_inflow_before = length(domain(1,:));
    
    if boundary.inflow.intervall_input_count == boundary.inflow.intervall_input
        domain = [domain(:,1:boundary_upper_particles_number_particles), function_boundary_inflow(time, boundary), domain(:,boundary_upper_particles_number_particles+1:end)];
        boundary.inflow.intervall_input_count = 0;
    end

    boundary.inflow.intervall_input_count = boundary.inflow.intervall_input_count+1;
    
    particles_number_inflow_after = length(domain(1,:));
    %-------------------------------------------------------------------------
    
    %number particles inflow
    particles_number_inflow = particles_number_inflow + (particles_number_inflow_after - particles_number_inflow_before);
    set(handles.textTotalInflow, 'String', num2str(particles_number_inflow));
    %-------------------------------------------------------------------------
    
    
    %sort
    domain = sortrows(domain',1)';
    %-------------------------------------------------------------------------
    
    
    %STEP 1
    %cross-sectional area approximation
    %count through particle i
    
    domain4 = zeros(size(domain,2),1);
    domain3 = zeros(size(domain,2),1);
    
    parfor i = 1:length(domain(1,:))
        if (domain(end,i) == 1)
            %-------------------------------------------------------------------------
            [particle_i_area_current_computed, particle_i_area_derivation_current_computed] = function_approximation_area(domain, i, boundary, sph);
%             domain(3,i) = particle_i_area_current_computed;
%             domain(4,i) = particle_i_area_derivation_current_computed;
            domain3(i) = particle_i_area_current_computed;
            domain4(i) = particle_i_area_derivation_current_computed;
%             %-------------------------------------------------------------------------
        end
    end

    domain(3,:) = domain3;
    domain(4,:) = domain4;
    %-------------------------------------------------------------------------
    
    
    %STEP 2
    %compute start-velocity
    %count through particle i
    
    domain(5,:) = ones(size(domain,2),1)*boundary.I_S;
    
    domain7 = zeros(size(domain,2),1);
    
    parfor i = 1:length(domain(1,:))
        if (domain(end,i) == 1)
            %-------------------------------------------------------------------------
            %there is an error in function_approximation_I_S!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
            %particle_i_I_S_current_computed = function_approximation_I_S(domain, i, boundary, sph)
            %domain(5,i) = particle_i_I_S_current_computed;
            %domain(5,i) = boundary.I_S;
            %-------------------------------------------------------------------------
            %-------------------------------------------------------------------------
            particle_i_velocity_next_computed = function_computation_acceleration_integration(domain, i, time, boundary, sph);
            %domain(7,i) = particle_i_velocity_next_computed;
            domain7(i) = particle_i_velocity_next_computed;
            %-------------------------------------------------------------------------
            %-------------------------------------------------------------------------
        end
    end
    
    domain(7,:) = domain7;
    %-------------------------------------------------------------------------
    
    
    %STEP 3
    
    particle_velocity_stop_iteration = zeros(1,length(domain(1,:)));
    
    %iterate velocity
    for m = 1:computation.velocity_iteration_number
    
    domain7 = zeros(size(domain,2),1);
    %count through particle i    
    parfor i = 1:length(domain(1,:))
        if (domain(end,i) == 1 && particle_velocity_stop_iteration(i) == 0)

            %-------------------------------------------------------------------------
            particle_i_velocity_next_computed = function_computation_acceleration_integration(domain, i, time, boundary, sph);
            %-------------------------------------------------------------------------
            
%             if (abs(particle_i_velocity_next_computed - domain(7,i)) < computation.velocity_iteration_truncation_error)
%                 particle_velocity_stop_iteration(i) = 1;
%                 %msgbox('Truncation Error was not reached!','Velocity Iteration','warn')
%             end
            
            %-------------------------------------------------------------------------
            %domain(7,i) = particle_i_velocity_next_computed;
            domain7(i) = particle_i_velocity_next_computed;
            %particle_i_velocity_next_computed
            %-------------------------------------------------------------------------
            
%             if (m == computation.velocity_iteration_number)
%                 %msgbox('Truncation Error was not reached!','Velocity Iteration','warn')
%                 set(handles.textError, 'String', 'velocity truncation error was not reached!');
%             end
            
        end
    end
    
    domain(7,:) = domain7;
    
    end
    %-------------------------------------------------------------------------
    
    
    %STEP 4 - velocity integration
    %count through particle i - compute new particle position
    
    domain1 = domain(1,:);
    
    parfor i = 1:length(domain(1,:))
        if (domain(end,i) == 1)  
            
            particle_i_velocity_new_computed = domain(7,i);
            particle_i_position_current = domain(1,i);
            
            particle_i_position_new_computed = particle_i_position_current + particle_i_velocity_new_computed*time.increment;
            %domain(1,i) = particle_i_position_new_computed;
            domain1(i) = particle_i_position_new_computed;
        end
    end
    
    
    domain(1,:) = domain1';
    %-------------------------------------------------------------------------
    
    
    %sort
    domain = sortrows(domain',1)';
    %-------------------------------------------------------------------------
    

    %boundary outflow lower
    [domain, particles_number_outflow_lower] = function_boundary_outflow_lower(domain, handles, boundary.general.channel_end, boundary_lower_particles_number_particles, particles_number_outflow_lower);
    %-------------------------------------------------------------------------
    
    
    %boundary outflow upper - reflect particles
    [domain, particles_number_reflect_upper] = function_boundary_reflect_upper(domain, handles, particles_number_reflect_upper);
    %-------------------------------------------------------------------------
    
    
    %visualization
    function_plot(domain, visualization.plot_axis, handles);
    %-------------------------------------------------------------------------
    
    %stop
    guidata(hObject,handles);  % Update the GUI data
    
    if handles.stop == 1
        return
    end
    
end

end