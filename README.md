# NWXPKGS

This repository serves my collection of custom Nix expressions, akin to what is done in `nixpkgs`. It includes a `default` overlay that exposes all custom packages, facilitating their integration into other projects.

## Usage

### Setting Up

1. Fork this repository.
2. Begin adding packages to the `pkgs/by-name` directory. Follow the
   same approach as adding packages in `nixpkgs`. Similar to [RFC140], packages
   added in this directory will be automatically discovered.
   - Create a new directory for each package.
   - Inside each directory, create a `package.nix` file.
3. Optionally, you can add packages directly to the `pkgs/` directory and
   manually update the bindings in the `imports/pkgs-all.nix` file.

### Integrating Your Repository as an Overlay

To use this repository as an overlay in another project, follow these steps:

1. **Add the Repository as an Input**:

   Add the following to your `nix` file to include this repository as an input:

   ```nix
   inputs = {
       nwxpkgs.url = "github:nwhirschfeld/nwxpkgs/release";
   };
   ```

2. **Include the Overlay in `pkgs`**:

   When constructing `pkgs`, include the overlay as follows:

   ```nix
   pkgs = import inputs.nixpkgs {
     overlays = [
       inputs.nwxpkgs.overlays.default
     ];
   };
   ```

3. **Use NWXPKGS Packages**:

   Access the packages in your project like this:

   ```nix
   buildInputs = [ pkgs.example1 pkgs.example2 ];
   ```

[RFC140]: https://github.com/NixOS/rfcs/pull/140