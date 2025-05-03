# emacs.d
My set of common Emacs configuration files.

## Goal
To have a sharp axe wherever I happen to set up shop.

## Organization

Use `require-package` to ensure the presence of known set of desired packages.

`init.el` contain basic configuration and logic to bootstrap the rest of the configuration.

Per-module and personal configuration code is kept in `elisp`.


Local, installation-specific code lives in `elisp/mdc-local.el`. This file is not required to exist, so only needs to be created if needed.

External dependencies, such as packages loaded through package system, repositories cloned from GitHub, etc., are put in an outside directory, `~/lib/emacs/` to minimize interaction with revision control.

## License
Copyright © 2025 Michael Cornelius

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
