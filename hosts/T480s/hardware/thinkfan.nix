{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    thinkfan
  ];

  services.thinkfan = {
    enable = true;

    fans = [
      {
        query = "/proc/acpi/ibm/fan";
        type = "tpacpi";
      }
    ];

    sensors = [
      {
        query = "/proc/acpi/ibm/thermal";
        type = "tpacpi";
      }
    ];

    levels = [
      [
        0
        0
        40
      ]
      [
        1
        40
        50
      ]
      [
        2
        50
        65
      ]
      [
        3
        65
        70
      ]
      [
        4
        70
        80
      ]
      [
        5
        80
        85
      ]
      [
        6
        85
        90
      ]
      [
        7
        90
        95
      ]
      [
        "level auto"
        95
        32767
      ]
    ];
  };
}
