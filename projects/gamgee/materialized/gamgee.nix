{ system
  , compiler
  , flags
  , pkgs
  , hsPkgs
  , pkgconfPkgs
  , errorHandler
  , config
  , ... }:
  ({
    flags = {};
    package = {
      specVersion = "1.12";
      identifier = { name = "gamgee"; version = "1.2.1"; };
      license = "MPL-2.0";
      copyright = "2018 Raghu Kaippully";
      maintainer = "rkaippully@gmail.com";
      author = "Raghu Kaippully";
      homepage = "https://github.com/rkaippully/gamgee#readme";
      url = "";
      synopsis = "Tool for generating TOTP MFA tokens.";
      description = "Tool for generating TOTP MFA tokens. Please see the README on GitHub at <https://github.com/rkaippully/gamgee#readme>";
      buildType = "Simple";
      isLocal = true;
      detailLevel = "FullDetails";
      licenseFiles = [ "LICENSE" ];
      dataDir = "";
      dataFiles = [];
      extraSrcFiles = [
        "ChangeLog.md"
        "README.md"
        "test/data/golden/getOTPTest.txt"
        ];
      extraTmpFiles = [];
      extraDocFiles = [];
      };
    components = {
      "library" = {
        depends = [
          (hsPkgs."aeson" or (errorHandler.buildDepError "aeson"))
          (hsPkgs."base" or (errorHandler.buildDepError "base"))
          (hsPkgs."base64-bytestring" or (errorHandler.buildDepError "base64-bytestring"))
          (hsPkgs."bytestring" or (errorHandler.buildDepError "bytestring"))
          (hsPkgs."cryptonite" or (errorHandler.buildDepError "cryptonite"))
          (hsPkgs."memory" or (errorHandler.buildDepError "memory"))
          (hsPkgs."polysemy" or (errorHandler.buildDepError "polysemy"))
          (hsPkgs."relude" or (errorHandler.buildDepError "relude"))
          (hsPkgs."safe-exceptions" or (errorHandler.buildDepError "safe-exceptions"))
          (hsPkgs."text" or (errorHandler.buildDepError "text"))
          (hsPkgs."time" or (errorHandler.buildDepError "time"))
          ];
        buildable = true;
        modules = [
          "Paths_gamgee"
          "Gamgee/Operation"
          "Gamgee/Token"
          "Gamgee/Effects"
          "Gamgee/Effects/Error"
          "Gamgee/Effects/Crypto"
          "Gamgee/Effects/CryptoRandom"
          "Gamgee/Effects/SecretInput"
          "Gamgee/Effects/TOTP"
          "Gamgee/Effects/JSONStore"
          "Gamgee/Effects/ByteStore"
          ];
        hsSourceDirs = [ "src" ];
        };
      exes = {
        "gamgee" = {
          depends = [
            (hsPkgs."Hclip" or (errorHandler.buildDepError "Hclip"))
            (hsPkgs."aeson" or (errorHandler.buildDepError "aeson"))
            (hsPkgs."base" or (errorHandler.buildDepError "base"))
            (hsPkgs."directory" or (errorHandler.buildDepError "directory"))
            (hsPkgs."filepath" or (errorHandler.buildDepError "filepath"))
            (hsPkgs."gamgee" or (errorHandler.buildDepError "gamgee"))
            (hsPkgs."optparse-applicative" or (errorHandler.buildDepError "optparse-applicative"))
            (hsPkgs."polysemy" or (errorHandler.buildDepError "polysemy"))
            (hsPkgs."relude" or (errorHandler.buildDepError "relude"))
            (hsPkgs."safe-exceptions" or (errorHandler.buildDepError "safe-exceptions"))
            (hsPkgs."text" or (errorHandler.buildDepError "text"))
            (hsPkgs."time" or (errorHandler.buildDepError "time"))
            (hsPkgs."unix" or (errorHandler.buildDepError "unix"))
            ];
          buildable = true;
          modules = [
            "Gamgee/Program/CommandLine"
            "Gamgee/Program/Effects"
            "Paths_gamgee"
            ];
          hsSourceDirs = [ "app" ];
          mainPath = [ "Main.hs" ];
          };
        };
      tests = {
        "gamgee-test" = {
          depends = [
            (hsPkgs."QuickCheck" or (errorHandler.buildDepError "QuickCheck"))
            (hsPkgs."aeson" or (errorHandler.buildDepError "aeson"))
            (hsPkgs."base" or (errorHandler.buildDepError "base"))
            (hsPkgs."bytestring" or (errorHandler.buildDepError "bytestring"))
            (hsPkgs."cryptonite" or (errorHandler.buildDepError "cryptonite"))
            (hsPkgs."filepath" or (errorHandler.buildDepError "filepath"))
            (hsPkgs."gamgee" or (errorHandler.buildDepError "gamgee"))
            (hsPkgs."memory" or (errorHandler.buildDepError "memory"))
            (hsPkgs."polysemy" or (errorHandler.buildDepError "polysemy"))
            (hsPkgs."quickcheck-instances" or (errorHandler.buildDepError "quickcheck-instances"))
            (hsPkgs."relude" or (errorHandler.buildDepError "relude"))
            (hsPkgs."tasty" or (errorHandler.buildDepError "tasty"))
            (hsPkgs."tasty-golden" or (errorHandler.buildDepError "tasty-golden"))
            (hsPkgs."tasty-quickcheck" or (errorHandler.buildDepError "tasty-quickcheck"))
            (hsPkgs."text" or (errorHandler.buildDepError "text"))
            (hsPkgs."time" or (errorHandler.buildDepError "time"))
            ];
          buildable = true;
          modules = [
            "Gamgee/Test/Effects"
            "Gamgee/Test/Golden"
            "Gamgee/Test/Operation"
            "Gamgee/Test/Property"
            "Paths_gamgee"
            ];
          hsSourceDirs = [ "test" ];
          mainPath = [ "Main.hs" ];
          };
        };
      };
    } // rec {
    src = (pkgs.lib).mkDefault ./.;
    }) // { cabal-generator = "hpack"; }