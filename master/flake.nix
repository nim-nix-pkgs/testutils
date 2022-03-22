{
  description = ''A unittest framework'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-testutils-master.flake = false;
  inputs.src-testutils-master.owner = "status-im";
  inputs.src-testutils-master.ref   = "master";
  inputs.src-testutils-master.repo  = "nim-testutils";
  inputs.src-testutils-master.type  = "github";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-testutils-master"];
  in lib.mkRefOutput {
    inherit self nixpkgs ;
    src  = deps."src-testutils-master";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  };
}