# To learn more about how to use Nix to configure your environment
# see: https://developers.google.com/idx/guides/customize-idx-env

{ pkgs, ... }: {
  # Which nixpkgs channel to use.
  channel = "stable-24.05";

  # Use https://search.nixos.org/packages to find packages
  packages = [
    pkgs.jdk17
    pkgs.gradle
  ];

  # Sets environment variables in the workspace
  env = {
    JAVA_HOME = "${pkgs.jdk17}";
  };

  idx = {
    # Search for the extensions you want on https://open-vsx.org/ and use "publisher.id"
    extensions = [
      "vscjava.vscode-java-pack"
      "mathiasfrohlich.Kotlin"
    ];

    # Enable previews and configure how to run your app
    previews = {
      enable = true;
      previews = {
        android = {
          command = ["./gradlew" ":app:assembleDebug"];
          manager = "android";
        };
      };
    };

    # Workspace lifecycle hooks
    workspace = {
      # Runs when a workspace is first created
      onCreate = {
        chmod-gradlew = "chmod +x ./gradlew";
      };
      # Runs when the workspace is (re)started
      onStart = {};
    };
  };
}
