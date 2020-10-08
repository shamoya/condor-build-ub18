####################
##
## Test Condor command file
##
####################
universe	= vanilla
executable	= sh_loop.sh
output		= sh_loop_$(Process).out
error		= sh_loop_$(Process).err
log		    = sh_loop.log
arguments	= 600
accounting_group = A.a
accounting_group_user = amit
should_transfer_files   = IF_NEEDED
when_to_transfer_output = ON_EXIT
queue 300

