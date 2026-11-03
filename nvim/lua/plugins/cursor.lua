return {
  {
    "sphamba/smear-cursor.nvim",
    opts = {
      cursor_color = "#E6CDFA", -- Your original pastel purple color

      particles_enabled = true, -- Enable particle trail effect
      particles_over_text = false, -- NEVER cover or hide words/letters!
      never_draw_over_target = true, -- Never draw over the character at the cursor
      hide_target_hack = false, -- Keep normal text cursor completely visible

      min_distance_emit_particles = 1, -- Don't smoke over immediate letter being edited
      particles_max_num = 300, -- Maximum particles
      particles_per_second = 200,
      particles_per_length = 30,
      particle_max_lifetime = 350, -- Smooth duration without lingering

      particle_gravity = -50, -- Sparks float upwards
      particle_velocity_from_cursor = 0.8,
      particle_max_initial_velocity = 12,
      particle_spread = 0.6,
      particle_damping = 0.1,

      gradient_exponent = 0,
      gamma = 1,

      stiffness = 0.5,
      trailing_stiffness = 0.2,
      trailing_exponent = 5,
      damping = 0.2,
    },
  },
}
