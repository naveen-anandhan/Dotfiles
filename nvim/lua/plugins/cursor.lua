return {
  {
    "sphamba/smear-cursor.nvim",
    opts = {
      cursor_color = "#E6CDFA",

      particles_enabled = true,
      particles_max_num = 200,

      particles_per_second = 100,
      particles_per_length = 25,
      particle_max_lifetime = 200,

      min_distance_emit_particles = 2, -- prevents smoke over text

      particle_gravity = -60,
      particle_velocity_from_cursor = 0.8,
      particle_max_initial_velocity = 10,
      particle_spread = 0.5,
      particle_damping = 0.1,

      gradient_exponent = 0,
      gamma = 1,
      never_draw_over_target = true,
      hide_target_hack = false,

      stiffness = 0.5,
      trailing_stiffness = 0.2,
      trailing_exponent = 5,
      damping = 0.2,
    },
  },
}
