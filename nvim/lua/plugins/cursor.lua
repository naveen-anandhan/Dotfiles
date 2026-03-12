return {
  "sphamba/smear-cursor.nvim",
  opts = {
    cursor_color = "#E6CDFA",
<<<<<<< HEAD
    particles_enabled = true,
    particles_max_num = 1200,

    -- Emission Settings
    particles_per_second = 1000,
    particles_per_length = 50,
    particle_max_lifetime = 1200,
    min_distance_emit_particles = 0,

    -- Fire Physics
    particle_gravity = -60,
    particle_velocity_from_cursor = 0.8,
    particle_max_initial_velocity = 20,
    particle_spread = 1.2,
    particle_damping = 0.1,

    -- Aesthetics
    gradient_exponent = 0,
    gamma = 1,
    never_draw_over_target = true,
    hide_target_hack = true,

    -- Movement Dynamics


    -- Reduce particles so text is visible
    particles_enabled = true,
    particles_max_num = 250,

    -- Emission
    particles_per_second = 120,
    particles_per_length = 8,
    particle_max_lifetime = 500,
    min_distance_emit_particles = 1,

    -- Fire physics
    particle_gravity = -40,
    particle_velocity_from_cursor = 0.6,
    particle_max_initial_velocity = 12,
    particle_spread = 0.8,
    particle_damping = 0.2,

    -- Visual fixes
    gradient_exponent = 1,
    gamma = 1,
    never_draw_over_target = true,
    hide_target_hack = false,

    -- Cursor movement
>>>>>>> 521bc55 (Added vim-tmux-navigator plugin and updated tmux config)
    stiffness = 0.5,
    trailing_stiffness = 0.2,
    trailing_exponent = 5,
    damping = 0.6,
  },
}
