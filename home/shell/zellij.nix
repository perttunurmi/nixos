{...}: {
  programs.zellij = {
    enable = true;
    enableBashIntegration = false;
    attachExistingSession = false;
  };
}
