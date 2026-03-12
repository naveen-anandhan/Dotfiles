return {
  "sphamba/smear-cursor.nvim",
  opts = {
    cursor_color = "#E6CDFA",
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
    stiffness = 0.5,
    trailing_stiffness = 0.2,
    trailing_exponent = 5,
    damping = 0.6,
  },
}
