# Getting Started

1.    Clone this branch: https://github.com/ljflores/ceph/tree/JoshSalomon-wip-prim-balance-score
2.    Install dependencies (details here: https://github.com/ceph/ceph/#readme)
3.    `cd ceph/build`
5.    `ninja vstart`
6.    `ninja osdmaptool`
7.    Run `setup_vstart.sh` from the build directory
8.    Run `demo_1.sh` from the build directory once the cluster settles (wait for `HEALTH_OK`)
9.    `../src/stop.sh`
10.   Run `setup_vstart.sh` from the build directory
11.   Run `demo_2.sh` from the build directory once the cluster settles (wait for `HEALTH_OK`)
