  //Example instantiation for system 'DE0_Nano_SOPC'
  DE0_Nano_SOPC DE0_Nano_SOPC_inst
    (
      .SPI_CLK_from_the_adc_spi_read        (SPI_CLK_from_the_adc_spi_read),
      .SPI_CS_n_from_the_adc_spi_read       (SPI_CS_n_from_the_adc_spi_read),
      .SPI_CS_n_from_the_gsensor_spi        (SPI_CS_n_from_the_gsensor_spi),
      .SPI_IN_to_the_adc_spi_read           (SPI_IN_to_the_adc_spi_read),
      .SPI_OUT_from_the_adc_spi_read        (SPI_OUT_from_the_adc_spi_read),
      .SPI_SCLK_from_the_gsensor_spi        (SPI_SCLK_from_the_gsensor_spi),
      .SPI_SDIO_to_and_from_the_gsensor_spi (SPI_SDIO_to_and_from_the_gsensor_spi),
      .altpll_adc                           (altpll_adc),
      .altpll_io                            (altpll_io),
      .altpll_sdram                         (altpll_sdram),
      .altpll_sys                           (altpll_sys),
      .altpll_sys_c3_out                    (altpll_sys_c3_out),
      .bidir_port_to_and_from_the_i2c_sda   (bidir_port_to_and_from_the_i2c_sda),
      .clk_50                               (clk_50),
      .data0_to_the_epcs                    (data0_to_the_epcs),
      .dclk_from_the_epcs                   (dclk_from_the_epcs),
      .in_port_to_the_g_sensor_int          (in_port_to_the_g_sensor_int),
      .in_port_to_the_key                   (in_port_to_the_key),
      .in_port_to_the_sw                    (in_port_to_the_sw),
      .locked_from_the_altpll_sys           (locked_from_the_altpll_sys),
      .out_port_from_the_i2c_scl            (out_port_from_the_i2c_scl),
      .out_port_from_the_led                (out_port_from_the_led),
      .out_port_from_the_select_i2c_clk     (out_port_from_the_select_i2c_clk),
      .phasedone_from_the_altpll_sys        (phasedone_from_the_altpll_sys),
      .reset_n                              (reset_n),
      .sce_from_the_epcs                    (sce_from_the_epcs),
      .sdo_from_the_epcs                    (sdo_from_the_epcs),
      .zs_addr_from_the_sdram               (zs_addr_from_the_sdram),
      .zs_ba_from_the_sdram                 (zs_ba_from_the_sdram),
      .zs_cas_n_from_the_sdram              (zs_cas_n_from_the_sdram),
      .zs_cke_from_the_sdram                (zs_cke_from_the_sdram),
      .zs_cs_n_from_the_sdram               (zs_cs_n_from_the_sdram),
      .zs_dq_to_and_from_the_sdram          (zs_dq_to_and_from_the_sdram),
      .zs_dqm_from_the_sdram                (zs_dqm_from_the_sdram),
      .zs_ras_n_from_the_sdram              (zs_ras_n_from_the_sdram),
      .zs_we_n_from_the_sdram               (zs_we_n_from_the_sdram)
    );

