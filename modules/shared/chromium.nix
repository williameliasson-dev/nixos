{ pkgs, ... }: {
  programs.chromium = {
    enable = true;
    package = pkgs.ungoogled-chromium;
    extensions = [
      # chromium store
      {
        id = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa";
        crxPath = "/tmp/Chromium.Web.Store.crx";
        version = "1.4.0";
      }
      # ublock origin
      {
        id = "cjpalhdlnbpafiamejdnhcphjbkeiagm";
      }
      # lastpass
      {
        id = "hdokiejnpimakedhajhdlcegeplioahd";
      }
      # privacy badger
      {
        id = "pkehgijcmpdhfbdbbnkijodmdjhbjlgp";
      }
      # vimium
      {
        id = "dbepggeogbaibhgnhhndojpepiihcmeb";
      }
    ];
  };
}
