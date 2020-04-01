# condor-build-ub18

Dockerfile for building and running all-in-one htcondor (single machine manager, submitter and executer) on top of Ubuntu18 LTS.
It builds HTCondor latest stable version 8-8-7 from source with all the default features.
Then it deploys the binaries using the htcondor configure script with minor modification to the location of configuration files.
Can mainly be used for developing and code inspection.
