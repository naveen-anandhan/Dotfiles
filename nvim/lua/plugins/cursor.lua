return {
  {
    "sphamba/smear-cursor.nvim",
    opts = {
      cursor_color = "#ff4000", -- Fiery orange/red spark color

      particles_enabled = true, -- Enable particle spark trail
      particles_max_num = 1000, -- Maximum active particles
      particles_per_second = 500,
      particles_per_length = 50,
      particle_max_lifetime = 800, -- Keep sparks visible for 800ms

      min_distance_emit_particles = 0, -- Emit sparks on every single movement
      particles_over_text = true, -- Allow sparks to float over text

      particle_gravity = -50, -- Sparks float upwards like fire embers
      particle_velocity_from_cursor = 0.5,
      particle_max_initial_velocity = 20,
      particle_spread = 1.0,
      particle_damping = 0.1,

      gradient_exponent = 0,
      gamma = 1,
      never_draw_over_target = true,
      hide_target_hack = true,

      stiffness = 0.5,
      trailing_stiffness = 0.2,
      trailing_exponent = 5,
      damping = 0.6,
    },
  },
}
