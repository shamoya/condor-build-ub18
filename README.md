# condor-build-ub18

Dockerfile for building and running all-in-one htcondor (single machine manager, submitter and executer) on top of Ubuntu18 LTS.
It builds HTCondor latest stable version from source with a basic set of features enabled (see complete list in Dockerfile).
Then it deploys the binaries using the htcondor configure script with minor modification to the location of configuration files.
Can mainly be used for developing and code inspection, or when wanting to simulate a HTcondor Cluster in a simple way.
