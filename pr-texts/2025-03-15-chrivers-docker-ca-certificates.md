### 2025-03-13: `chrivers/docker-ca-certificates` + `chrivers/dockerfile-update`

This fixes the docker build process for Bifrost, which was accidentally broken
during the rush of recent, big merges coming in.

 - Add missing `libssl-dev` package for compile step
 - Add missing `libssl3` package for runtime container
 - Add missing bind mounts for building bifrost
 - Upgrade rust version for build container
 - Add missing `ca-certificates` package, to make hue api version checking
   function correctly again.

With all these checks, the docker release of Bifrost should be back in a good
state.
