%COMPUTATION
time.start = 0;             %s
time.increment = str2num(get(handles.editTimeIncrement,'string'));      %s
time.end = str2num(get(handles.editTimeEnd,'string'));              %s

computation.velocity_iteration_number = str2num(get(handles.editNumberIterations,'string'));
computation.velocity_iteration_truncation_error = str2num(get(handles.editResidual,'string')); %m/s not implemented yet!
%-------------------------------------------------------------------------


%GENERAL
boundary.general.particle_volume = str2num(get(handles.editParticleVolume,'string'));         %
boundary.general.channel_end = str2num(get(handles.editChannelEnd,'string'));              %m
boundary.general.channel_width = str2num(get(handles.editChannelWidth,'string'));             %m
%-------------------------------------------------------------------------


%INITIALIZATION
boundary.initialization.fluid_height = str2num(get(handles.editInitialFluidHeight,'string'));     %m - function_boundary_initial_fluid_height     only for rectangular channels!!!!!!
boundary.upper_particles.length = 1;            %m
boundary.upper_particles.fluid_height = 1;    %m
boundary.lower_particles.length = 1;            %m
boundary.lower_particles.fluid_height = 1;    %m
%-------------------------------------------------------------------------


%INFLOW
boundary.inflow.inflow = str2num(get(handles.editInflowRate,'string'));                     %m�/s
boundary.inflow.range = str2num(get(handles.editInflowRange,'string'));                      %m
boundary.inflow.particle_velocity = str2num(get(handles.editInflowVelocity,'string'));          %m/s
boundary.inflow.intervall_input = str2num(get(handles.editInflowInterval,'string'));           %each 10nd timestep inflowparticles are released
boundary.inflow.intervall_input_count = 0;
%-------------------------------------------------------------------------


%FRICTION
boundary.friction.k_st = str2num(get(handles.editStrickler,'string'));                    %constant friction across the channel!!!!!!!

% 20 bis 40 f�r nat�rliche Gerinne
% 45 bis 50 Bruchsteine, alter Beton
% 50 bis 60 Beton
% 80 bis .. Glatter Beton
% 90 bis .. Glatte Holzgerinne
% 100 bis .. PVC
%-------------------------------------------------------------------------


%Z-ELEVATION
%boundary.z_elevation.slope = 0.001;   %has to be positive!!      %function_boundary_z_elevation
boundary.I_S = str2num(get(handles.editIS,'string'));
%-------------------------------------------------------------------------

%SPH
%sph.smoothing_length = 1;     %m
sph.kappa = str2num(get(handles.editSPHKappa,'string'));
%-------------------------------------------------------------------------


%visualization
visualization.plot_axis = [     -boundary.upper_particles.length, boundary.general.channel_end+5, 0, 4
                                -boundary.upper_particles.length, boundary.general.channel_end+5, -5, +5];
visualization.q = 0;
%-------------------------------------------------------------------------
