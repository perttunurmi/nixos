_: {
  programs.sioyek = {
    enable = true;

    bindings = {
      "quit" = "qqqqqqqqqqqqqqqqqqqqqqqqq";
    };

    config = {
      "embed_annotations" = "1";
      "should_launch_new_window" = "1";
      "should_launch_new_instance" = "1";

      "font_size" = "20";
      "status_bar_font_size" = "20";

      "super_fast_search" = "1";
      "case_sensitive_search" = "0";

      startup_commands = [
      ];
    };
  };
}
