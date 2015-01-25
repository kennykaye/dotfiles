#!/bin/bash
#
#   upt - show just the system uptime, days, hours, and minutes

boot=$(sysctl kern.boottime | awk '{print $5}' | sed "s/,//")
now=$(date +%s)
diff=$(($now-$boot))

days=$(($diff/86400));
diff=$(($diff-($days*86400)))
hours=$(($diff/3600))
diff=$(($diff-($hours*3600)))
minutes=$(($diff/60))
seconds=$(($diff-($minutes*60)))

if [ $days = 0 ]; then
  echo '↓↑ '$hours'h '$minutes'm'
else
  echo '↓↑ '$days'd '$hours'h'
fi
