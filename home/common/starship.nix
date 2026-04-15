{
  config,
  wsl,
  ...
}:
{
  home.sessionVariables.STARSHIP_CACHE = "${config.xdg.cacheHome}/starship";

  programs.starship = {
    enable = true;
    settings = {
      # scan_timeout = 50;
      # command_timeout = 500;
      # character = {
      #   success_symbol = "[を](bold green)";
      #   error_symbol = "[ㄪ](bold red)";
      # };

      # format = "$username$hostname$directory$git_branch$git_state$git_status$cmd_duration$line_break$python$character";
      # format = "$username$hostname$localip$shlvl$singularity$kubernetes$directory$vcsh$fossil_branch$fossil_metrics$git_branch$git_commit$git_state$git_metrics$git_status$hg_branch$hg_state$pijul_channel$docker_context$package$c$cmake$cobol$daml$dart$deno$dotnet$elixir$elm$erlang$fennel$fortran$gleam$golang$guix_shell$haskell$haxe$helm$java$julia$kotlin$gradle$lua$nim$nodejs$ocaml$opa$perl$php$pulumi$purescript$python$quarto$raku$rlang$red$ruby$rust$scala$solidity$swift$terraform$typst$vlang$vagrant$zig$buf$nix_shell$conda$meson$spack$memory_usage$aws$gcloud$openstack$azure$nats$direnv$env_var$mise$crystal$custom$sudo$cmd_duration$line_break$jobs$battery$time$status$os$container$netns$shell$character";

      git_status = {
        deleted = "✗";
        modified = "✶";
        staged = "✓";
        stashed = "≡";
        ahead = "^";
        behind = "v";
      };

      nix_shell = {
        symbol = " ";
        heuristic = true;
      };

      kotlin = {
        format = "";
      };

      scala = {
        format = "";
      };
    };
  };
}
