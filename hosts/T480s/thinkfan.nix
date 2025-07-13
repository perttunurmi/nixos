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
        55
      ]
      [
        1
        48
        60
      ]
      [
        2
        50
        61
      ]
      [
        3
        52
        63
      ]
      [
        6
        56
        65
      ]
      [
        7
        60
        85
      ]
      [
        "level auto"
        80
        32767
      ]
    ];
  };
}
