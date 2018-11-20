# Notes from ED runs

All runs started with `qsub ~/ED_Tropics/runs/qsub_BCI_pecan.sh`

## BCI.o9650689

### `~/ED_Tropics/inputs/BCI/ED2IN_pecan`

```
   !---------------------------------------------------------------------------------------!
   !     Start of simulation. Information must be given in UTC time.                       !
   !---------------------------------------------------------------------------------------!
   NL%IMONTHA = 1
   NL%IDATEA = 1
   NL%IYEARA = 2003
   NL%ITIMEA = 0
   !---------------------------------------------------------------------------------------!

   !---------------------------------------------------------------------------------------!
   !     End of simulation. Information must be given in UTC time.                         !
   !---------------------------------------------------------------------------------------!
   NL%IMONTHZ = 12
   NL%IDATEZ = 31
   NL%IYEARZ = 2016
   NL%ITIMEZ = 0
   !---------------------------------------------------------------------------------------!
```

### cat ~/ED_Tropics/runs/logs/BCI.o9650689 | tail -40

```
 - Simulating:   07/20/2003 00:00:00 UTC
 - Simulating:   07/21/2003 00:00:00 UTC
 - Simulating:   07/22/2003 00:00:00 UTC
 - Simulating:   07/23/2003 00:00:00 UTC
 - Simulating:   07/24/2003 00:00:00 UTC
 - Simulating:   07/25/2003 00:00:00 UTC
 - Simulating:   07/26/2003 00:00:00 UTC
 - Simulating:   07/27/2003 00:00:00 UTC
 - Simulating:   07/28/2003 00:00:00 UTC
 - Simulating:   07/29/2003 00:00:00 UTC
 - Simulating:   07/30/2003 00:00:00 UTC
 - Simulating:   07/31/2003 00:00:00 UTC
 - Simulating:   08/01/2003 00:00:00 UTC
 - Simulating:   08/02/2003 00:00:00 UTC
 - Simulating:   08/03/2003 00:00:00 UTC
 - Simulating:   08/04/2003 00:00:00 UTC
 - Simulating:   08/05/2003 00:00:00 UTC
 - Simulating:   08/06/2003 00:00:00 UTC

Program received signal 8 (SIGFPE): Floating-point exception.

Backtrace for this error:
  + /lib64/libc.so.6(+0x32570) [0x2ae79b489570]
  + function __radiate_driver_module_MOD_sfcrad_ed.omp_fn.0 (0xADED90)
    at line 767 of file radiate_driver.f90
  + function __radiate_driver_module_MOD_sfcrad_ed (0xAB0751)
    at line 407 of file radiate_driver.f90
  + function __radiate_driver_module_MOD_radiate_driver (0xAB288F)
    at line 160 of file radiate_driver.f90
  + function ed_model_ (0x511FAF)
    at line 259 of file ed_model.F90
  + function ed_driver_ (0x427A88)
    at line 309 of file ed_driver.F90
  + in the main program
    at line 288 of file edmain.F90
  + /lib64/libc.so.6(__libc_start_main+0x100) [0x2ae79b475d20]
** Warning: a core dump was requested, but the core sizelimit
**          is currently zero.

/var/spool/sge/scc-dd4/job_scripts/9650689: line 14: 54348 Quit                    ./ed_2.1-opt -f /projectnb/dietzelab/ecowdery/ED_Tropics/inputs/BCI/ED2IN_pecan
```

### Notes

It has been suggested to me that this could be a met problem. I think I'll try running starting with 2004, see if that works and also plot the met for 2003 (starting probably with radiation.)

### `~/ED_Tropics/inputs/BCI/ED2IN_pecan`

Only thing I changed was the start date to 2004.

```
   !---------------------------------------------------------------------------------------!
   !     Start of simulation. Information must be given in UTC time.                       !
   !---------------------------------------------------------------------------------------!
   NL%IMONTHA = 1
   NL%IDATEA = 1
   NL%IYEARA = 2004
   NL%ITIMEA = 0
   !---------------------------------------------------------------------------------------!

   !---------------------------------------------------------------------------------------!
   !     End of simulation. Information must be given in UTC time.                         !
   !---------------------------------------------------------------------------------------!
   NL%IMONTHZ = 12
   NL%IDATEZ = 31
   NL%IYEARZ = 2016
   NL%ITIMEZ = 0
   !---------------------------------------------------------------------------------------!
