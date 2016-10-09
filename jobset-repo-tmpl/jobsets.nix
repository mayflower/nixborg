{ nixpkgs ? <nixpkgs>, declInput ? {} }:

let
  pkgs = import nixpkgs {};
  prs = builtins.fromJSON (builtins.readFile ./prs.json);
  fileContents = with pkgs.lib; ''
    cat > $out <<EOF
    {
      ${concatStringsSep "," (map (name: ''
        "${name}": {
            "enabled": 1,
            "hidden": 0,
            "description": "",
            "nixexprinput": "nixpkgs",
            "nixexprpath": "pkgs/top-level/release.nix",
            "checkinterval": 60,
            "schedulingshares": 42,
            "enableemail": false,
            "emailoverride": "",
            "keepnr": 1,
            "inputs": {
              "nixpkgs": { "type": "git", "value": "git://github.com/nixos/nixpkgs-pr ${name}", "emailresponsible": false },
              "supportedSystems": { "type": "nix", "value": "[ \"x86_64-linux\" \"x86_64-darwin\" ]", "emailresponsible": false }
            }
        }
      '') prs)}
    }
    EOF
  '';
in {
  jobsets = pkgs.runCommand "spec.json" {} fileContents;
}
