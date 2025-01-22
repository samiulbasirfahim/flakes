{ pkgs, inputs, ... }: {

  # home.persistence."/nix/persist/home/rxen".directories = [
  #   ".mozilla"
  # ];


  programs.firefox = {
    enable = true;
    policies = {
      DisableAppUpdate = true;
      DNSOverHTTPS = { Enabled = false; Locked = true; };
      Bookmarks = [ ];
      DisableMasterPasswordCreation = true;
      DisableFeedbackCommands = true;
      DisableFirefoxAccounts = true;
      DisableFirefoxStudies = true;
      DisableForgetButton = true;
      DisableFormHistory = true;
      DisablePocket = true;
      DisableProfileImport = true;
      DisableProfileRefresh = true;
      DisableTelemetry = true;
      DontCheckDefaultBrowser = true;
      EnableTrackingProtection = { Value = true; Locked = true; };
      NoDefaultBookmarks = true;
      OfferToSaveLogins = false;
      Homepage = { URL = "about:blank"; StartPage = "previous-session"; Locked = true; };
      PopupBlocking = { Default = true; Locked = true; };
      FlashPlugin = { Default = false; Locked = true; };
      OverrideFirstRunPage = "";
      OverridePostUpdatePage = "";
      Proxy = { Mode = "none"; Locked = true; };
      RequestedLocales = [ "en-US.UTF-8" ];
    };
    profiles.rxen = {
      name = "rxen";
      isDefault = true;

      extraConfig = builtins.readFile "${inputs.hardened-firefox}/user.js";
      search = {
        engines = {
          "Bing".metaData.hidden = true;
          "Amazon".metaData.hidden = true;
          "Amazon.com".metaData.hidden = true;
          "eBay".metaData.hidden = true;
          "Google".metaData.hidden = true;
          "Wikipedia (en)".metaData.hidden = true;
          "DuckDuckGo".metaData.alias = "@d";
        };
        force = true;
        default = "DuckDuckGo";
        order = [ "DuckDuckGo" ];
      };
      userChrome = builtins.readFile (./userChrome.css);
      userContent = builtins.readFile (./userContent.css);
      settings = {
        "browser.in-content.dark-mode" = true;
        "privacy.clearOnShutdown_v2.historyFormDataAndDownloads" = false;
        "privacy.resistFingerprinting.letterboxing" = false;
        "webgl.disabled" = false;
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "browser.tabs.inTitlebar" = "0";
        "media.ffmpeg.vaapi.enabled" = true;
        "extensions.autoDisableScopes" = 0;
        permissions = {
          "default.desktop-notification" = false;
        };
      };
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        ublock-origin
        pywalfox
        vimium-c


        (buildFirefoxXpiAddon rec {
          pname = "competitive-companion";
          version = "2.58.0";
          addonId = "{74e326aa-c645-4495-9287-b6febc5565a7}";
          url = "https://addons.mozilla.org/firefox/downloads/file/4412528/competitive_companion-${version}.xpi";
          sha256 = "sha256-jmhyzKBjumf0NRBnYlbuZRMII4NePFtauQRZ6Mn3Vu0=";
          meta = { };
        })

        (buildFirefoxXpiAddon rec {
          pname = "authenticator";
          version = "8.0.2";
          addonId = "authenticator@mymindstorm";
          url = "https://addons.mozilla.org/firefox/downloads/file/4353166/auth_helper-${version}.xpi";
          sha256 = "sha256-26uRlHI330yFl/6hsA3OBc9/rqJ3Ij8sUQkPkUiBKmI=";
          meta = { };
        })
      ];
    };
  };
  home = {
    sessionVariables = {
      MOZ_DISABLE_CONTENT_SANDBOX = 1;
    };
  };
}
