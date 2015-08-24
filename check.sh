#!/bin/sh
qmmm_fe_dir=/scratch/yl66/trunk/qchem-amber/pmf_B9b/scan_again/fe
head=GCN5
if [ -e toredo.sh ]; then
  rm toredo.sh
fi
qmmm_md_dir=$(readlink -m .)
src_dir=$(readlink -m src)
pbs_dir=$(readlink -m pbs)
pbs_template=$(readlink -m qchem_pbs.template)
epilogue_template=$(readlink -m epilogue.template)

for dir in $qmmm_fe_dir/RC_*; do
    rc=$(echo $dir | sed -e s"#$qmmm_fe_dir/RC_##")

    ## Need to change the range of larger force constant according to the potential profile.
    force=$(echo $rc | awk '{ if ($1 > -0.40 && $1< 0.60 ) print 60.0; else print 40.0; }')

    cd $qmmm_md_dir
    rc_window=RC_$rc
    cd $rc_window
    if [ -e md-4.log ]; then
      xx=`grep "failed to start" md-4.log | awk '{print $4}'`
      if [ ! -z $xx ]; then
        if [ "$xx" = "failed" ]; then
          tail -n 2 md-4.log
          pwd
          rm md-?.log
          echo $rc >> ../toredo.sh
          #rm md-?.log
        fi
      fi
    fi
done

exit
