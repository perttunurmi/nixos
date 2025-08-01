{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    throttled
  ];

  services.throttled = {
    enable = true;
    extraConfig = ''
      [GENERAL]
      # !!! Configured for my T480s !!!
      # Enable or disable the script execution
      Enabled: True
      # SYSFS path for checking if the system is running on AC power
      Sysfs_Power_Path: /sys/class/power_supply/AC*/online
      # Auto reload config on changes
      Autoreload: True

      ## Settings to apply while connected to Battery power
      [BATTERY]
      # Update the registers every this many seconds
      Update_Rate_s: 30
      # Max package power for time window #1
      PL1_Tdp_W: 29
      # Time window #1 duration
      PL1_Duration_s: 28
      # Max package power for time window #2
      PL2_Tdp_W: 44
      # Time window #2 duration
      PL2_Duration_S: 0.002
      # Max allowed temperature before throttling
      Trip_Temp_C: 85
      # Set cTDP to normal=0, down=1 or up=2 (EXPERIMENTAL)
      cTDP: 0
      # Disable BDPROCHOT (EXPERIMENTAL)
      Disable_BDPROCHOT: False

      ## Settings to apply while connected to AC power
      [AC]
      # Update the registers every this many seconds
      Update_Rate_s: 5
      # Max package power for time window #1
      PL1_Tdp_W: 44
      # Time window #1 duration
      PL1_Duration_s: 28
      # Max package power for time window #2
      PL2_Tdp_W: 44
      # Time window #2 duration
      PL2_Duration_S: 0.002
      # Max allowed temperature before throttling
      Trip_Temp_C: 95
      # Set HWP energy performance hints to 'performance' on high load (EXPERIMENTAL)
      # Uncomment only if you really want to use it
      # HWP_Mode: False
      # Set cTDP to normal=0, down=1 or up=2 (EXPERIMENTAL)
      cTDP: 0
      # Disable BDPROCHOT (EXPERIMENTAL)
      Disable_BDPROCHOT: False

      # All voltage values are expressed in mV and *MUST* be negative (i.e. undervolt)!
      [UNDERVOLT.BATTERY]
      # CPU core voltage offset (mV)
      CORE: -100
      # Integrated GPU voltage offset (mV)
      GPU: -85
      # CPU cache voltage offset (mV)
      CACHE: -100
      # System Agent voltage offset (mV)
      UNCORE: -85
      # Analog I/O voltage offset (mV)
      ANALOGIO: 0

      # All voltage values are expressed in mV and *MUST* be negative (i.e. undervolt)!
      [UNDERVOLT.AC]
      # CPU core voltage offset (mV)
      CORE: -100
      # Integrated GPU voltage offset (mV)
      GPU: -85
      # CPU cache voltage offset (mV)
      CACHE: -100
      # System Agent voltage offset (mV)
      UNCORE: -85
      # Analog I/O voltage offset (mV)
      ANALOGIO: 0

      # [ICCMAX.AC]
      # # CPU core max current (A)
      # CORE:
      # # Integrated GPU max current (A)
      # GPU:
      # # CPU cache max current (A)
      # CACHE:

      # [ICCMAX.BATTERY]
      # # CPU core max current (A)
      # CORE:
      # # Integrated GPU max current (A)
      # GPU:
      # # CPU cache max current (A)
      # CACHE:
    '';
  };
}
