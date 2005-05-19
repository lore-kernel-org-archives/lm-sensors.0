From: grant_lkml@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:52 +0000
Subject: RFC: test results for adm9240 auto fan clock divider
Message-Id: <u2l6615hof5r7s4u44gslcaseabv44kbmn@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Greetings,

Jean Delvare and myself have been working on an algorithm for 
automatically setting fan clock divider, to solve the issue of users 
not being able to read their fan speed.  Being a newcomer I too had 
this problem and took some time to pick up what the requirements 
needed to be.

These results obtained from adm9240 driver, which is just about 
ready for yet another posting :)  Something has to 'give' when user 
enters silly minimum fan limit, yesterday I finally appreciated this 
aspect and today I fix driver and provide these test results.

Notice fan limits above a certain point are pulled back? that is due 
to the adjustment required to bring the system back to a point where 
it can give the user fan speed measurements.  In this case, the test 
box has a fan needing a minimum fan clock divide by four.  So on very 
high limit settings, it requires two measurement cycles to 'repair' 
the fan clock divider.

Requirements:

automatic fan clock divider
````````````````````````````
    * User sets 0 to fan_min limit
      - low speed alarm is disabled
      - fan clock divider not changed
      - auto fan clock adjuster disabled
    * User sets fan_min limit too low
      - low speed alarm is enabled
      - fan clock divider set to max
      - fan_min set to register value 254 which corresponds 
	to 664 rpm on adm9240
      - low speed alarm will be asserted if fan speed is 
	less than minimum measurable speed
      - auto fan clock adjuster disabled (by virtue fan_div = max)
    * User sets reasonable fan speed
      - low speed alarm is enabled
      - fan clock divider set to suit fan_min
      - auto fan clock adjuster enabled
    * User sets unreasonably high low fan speed limit
      - resolution of the low speed limit may be reduced
      - alarm will be asserted
      - fan speed may be displayed as zero until the auto fan 
	clock divider adjuster brings fan speed clock divider 
	back into chip measurement range, this will occur 
	within a few measurement cycles.

results
````````
Grant's auto fan_div tester...

   fan_min   fan rpm   fan_min   fan rpm   alarm
       set    retry       read      read   state
  --------   -------  --------  --------   -----
       400                 664      1577
       500                 664      1591
       600                 664      1591
       652                 664      1591
       654                 664      1577
       657                 664      1577
       659                 664      1577
       662                 664      1577
       664                 664      1577
       667                 666      1577
       870                 869      1577
       874                 874      1591
       879                 878      1577
       884                 883      1591
       888                 888      1577
      1303                1298      1577
      1308                1308      1591
      1313                1308      1591
      1318                1318      1577
      1324                1318      1591
      1329                1328      1577
      1334                1328      1577
      1740                1739      1591   alarm
      1749                1739      1577   alarm
      1758                1757      1569   alarm
      1767                1767      1577   alarm
      1776                1776      1584   alarm
      2606                2596      1584   alarm
      2616                2616      1577   alarm
      2626                2616      1584   alarm
      2637                2636      1577   alarm
      2647                2636      1569   alarm
      2657                2657      1577   alarm
      2668                2657      1577   alarm
      3479                3479      1584   alarm
      3497                3479      1584   alarm
      3516    *           3515      1577   alarm
      3534    *           3515      1584   alarm
      3553    *           3552      1591   alarm
      5212    *           5192      1584   alarm
      5233    *           5192      1577   alarm
      5253    *           5273      1584   alarm
      5273    *           5273      1577   alarm
      5294    *           5273      1577   alarm
      5315    *           5273      1577   alarm
      5336    *           5357      1577   alarm
      6959    *           6887      1577   alarm
      6995    **          7031      1584   alarm
      7031    **          7031      1584   alarm
      7068    **          7031      1577   alarm
      7105    **          7031      1577   alarm
     10000    **          9926      1577   alarm
     25000    **         24107      1577   alarm
     50000    **         48214      1584   alarm
    100000    **         84375      1584   alarm
    250000    **        168750      1584   alarm
    500000    **        337500      1591   alarm
   1000000    **        337500      1584   alarm
   2500000    **        337500      1591   alarm
   5000000    **        337500      1584   alarm
  10000000    **        337500      1577   alarm

The asterisks show how many extra measurement cycles the test program 
had to wait for non-zero fan speed rpm reading.

/var/log/debug
```````````````
 adm9240 0-002d: fan1 low limit set fan speed 1196	<<= set limits
 adm9240 0-002d: fan1 clock divider changed from 4 to 8
 adm9240 0-002d: fan2 low limit set disabled
 adm9240 0-002d: fan1 low limit set minimum 664		<<= start test
 adm9240 0-002d: fan1 low limit set fan speed 666
 adm9240 0-002d: fan1 low limit set fan speed 869
 adm9240 0-002d: fan1 low limit set fan speed 874
 adm9240 0-002d: fan1 low limit set fan speed 878
 adm9240 0-002d: fan1 low limit set fan speed 883
 adm9240 0-002d: fan1 low limit set fan speed 888
 adm9240 0-002d: fan1 low limit set fan speed 1298
 adm9240 0-002d: fan1 low limit set fan speed 1308
 adm9240 0-002d: fan1 low limit set fan speed 1308
 adm9240 0-002d: fan1 low limit set fan speed 1318
 adm9240 0-002d: fan1 low limit set fan speed 1318
 adm9240 0-002d: fan1 low limit set fan speed 1328
 adm9240 0-002d: fan1 low limit set fan speed 1328
 adm9240 0-002d: fan1 low limit set fan speed 1739
 adm9240 0-002d: fan1 low limit set fan speed 1739
 adm9240 0-002d: fan1 low limit set fan speed 1757
 adm9240 0-002d: fan1 clock divider changed from 8 to 4
 adm9240 0-002d: fan1 low limit set fan speed 1767
 adm9240 0-002d: fan1 low limit set fan speed 1776
 adm9240 0-002d: fan1 low limit set fan speed 2596
 adm9240 0-002d: fan1 low limit set fan speed 2616
 adm9240 0-002d: fan1 low limit set fan speed 2616
 adm9240 0-002d: fan1 low limit set fan speed 2636
 adm9240 0-002d: fan1 low limit set fan speed 2636
 adm9240 0-002d: fan1 low limit set fan speed 2657
 adm9240 0-002d: fan1 low limit set fan speed 2657
 adm9240 0-002d: fan1 low limit set fan speed 3479
 adm9240 0-002d: fan1 low limit set fan speed 3479
 adm9240 0-002d: fan1 low limit set fan speed 3515
 adm9240 0-002d: fan1 clock divider changed from 4 to 2
 adm9240 0-002d: fan1 clock divider changed from 2 to 4 <<= driver adjusts so 
 adm9240 0-002d: fan1 low limit set fan speed 3534		fan speed can 
 adm9240 0-002d: fan1 clock divider changed from 4 to 2		be displayed
 adm9240 0-002d: fan1 clock divider changed from 2 to 4
 adm9240 0-002d: fan1 low limit set fan speed 3552
 adm9240 0-002d: fan1 clock divider changed from 4 to 2
 adm9240 0-002d: fan1 clock divider changed from 2 to 4
 adm9240 0-002d: fan1 low limit set fan speed 5192
 adm9240 0-002d: fan1 clock divider changed from 4 to 2
 adm9240 0-002d: fan1 clock divider changed from 2 to 4
 adm9240 0-002d: fan1 low limit set fan speed 5232
 adm9240 0-002d: fan1 clock divider changed from 4 to 2
 adm9240 0-002d: fan1 clock divider changed from 2 to 4
 adm9240 0-002d: fan1 low limit set fan speed 5273
 adm9240 0-002d: fan1 clock divider changed from 4 to 2
 adm9240 0-002d: fan1 clock divider changed from 2 to 4
 adm9240 0-002d: fan1 low limit set fan speed 5273
 adm9240 0-002d: fan1 clock divider changed from 4 to 2
 adm9240 0-002d: fan1 clock divider changed from 2 to 4
 adm9240 0-002d: fan1 low limit set fan speed 5273
 adm9240 0-002d: fan1 clock divider changed from 4 to 2
 adm9240 0-002d: fan1 clock divider changed from 2 to 4
 adm9240 0-002d: fan1 low limit set fan speed 5314
 adm9240 0-002d: fan1 clock divider changed from 4 to 2
 adm9240 0-002d: fan1 clock divider changed from 2 to 4
 adm9240 0-002d: fan1 low limit set fan speed 5357
 adm9240 0-002d: fan1 clock divider changed from 4 to 2
 adm9240 0-002d: fan1 clock divider changed from 2 to 4
 adm9240 0-002d: fan1 low limit set fan speed 6958
 adm9240 0-002d: fan1 clock divider changed from 4 to 2
 adm9240 0-002d: fan1 clock divider changed from 2 to 4
 adm9240 0-002d: fan1 low limit set fan speed 7031
 adm9240 0-002d: fan1 clock divider changed from 4 to 1
 adm9240 0-002d: fan1 clock divider changed from 1 to 2 <<= driver bumps fan 
 adm9240 0-002d: fan1 clock divider changed from 2 to 4		clock divider 
 adm9240 0-002d: fan1 low limit set fan speed 7031		twice now
 adm9240 0-002d: fan1 clock divider changed from 4 to 1
 adm9240 0-002d: fan1 clock divider changed from 1 to 2
 adm9240 0-002d: fan1 clock divider changed from 2 to 4
 adm9240 0-002d: fan1 low limit set fan speed 7068
 adm9240 0-002d: fan1 clock divider changed from 4 to 1
 adm9240 0-002d: fan1 clock divider changed from 1 to 2
 adm9240 0-002d: fan1 clock divider changed from 2 to 4
 adm9240 0-002d: fan1 low limit set fan speed 7105
 adm9240 0-002d: fan1 clock divider changed from 4 to 1
 adm9240 0-002d: fan1 clock divider changed from 1 to 2
 adm9240 0-002d: fan1 clock divider changed from 2 to 4
 adm9240 0-002d: fan1 low limit set fan speed 10000
 adm9240 0-002d: fan1 clock divider changed from 4 to 1
 adm9240 0-002d: fan1 clock divider changed from 1 to 2
 adm9240 0-002d: fan1 clock divider changed from 2 to 4
 adm9240 0-002d: fan1 low limit set fan speed 25000
 adm9240 0-002d: fan1 clock divider changed from 4 to 1
 adm9240 0-002d: fan1 clock divider changed from 1 to 2
 adm9240 0-002d: fan1 clock divider changed from 2 to 4
 adm9240 0-002d: fan1 low limit set fan speed 50000
 adm9240 0-002d: fan1 clock divider changed from 4 to 1
 adm9240 0-002d: fan1 clock divider changed from 1 to 2
 adm9240 0-002d: fan1 clock divider changed from 2 to 4
 adm9240 0-002d: fan1 low limit set fan speed 103846
 adm9240 0-002d: fan1 clock divider changed from 4 to 1
 adm9240 0-002d: fan1 clock divider changed from 1 to 2
 adm9240 0-002d: fan1 clock divider changed from 2 to 4
 adm9240 0-002d: fan1 low limit set fan speed 270000
 adm9240 0-002d: fan1 clock divider changed from 4 to 1
 adm9240 0-002d: fan1 clock divider changed from 1 to 2
 adm9240 0-002d: fan1 clock divider changed from 2 to 4
 adm9240 0-002d: fan1 low limit set fan speed 675000
 adm9240 0-002d: fan1 clock divider changed from 4 to 1
 adm9240 0-002d: fan1 clock divider changed from 1 to 2
 adm9240 0-002d: fan1 clock divider changed from 2 to 4
 adm9240 0-002d: fan1 low limit set fan speed 1350000
 adm9240 0-002d: fan1 clock divider changed from 4 to 1
 adm9240 0-002d: fan1 clock divider changed from 1 to 2
 adm9240 0-002d: fan1 clock divider changed from 2 to 4
 adm9240 0-002d: fan1 low limit set fan speed 1350000
 adm9240 0-002d: fan1 clock divider changed from 4 to 1
 adm9240 0-002d: fan1 clock divider changed from 1 to 2
 adm9240 0-002d: fan1 clock divider changed from 2 to 4
 adm9240 0-002d: fan1 low limit set fan speed 1350000
 adm9240 0-002d: fan1 clock divider changed from 4 to 1
 adm9240 0-002d: fan1 clock divider changed from 1 to 2
 adm9240 0-002d: fan1 clock divider changed from 2 to 4
 adm9240 0-002d: fan1 low limit set fan speed 1350000
 adm9240 0-002d: fan1 clock divider changed from 4 to 1
 adm9240 0-002d: fan1 clock divider changed from 1 to 2
 adm9240 0-002d: fan1 clock divider changed from 2 to 4

test script
````````````
We have one list of interesting register values that are converted 
to corresponding rpm values, plus another list to test response to 
extremes.  

peetoo:0-002d$ cat /usr/local/bin/zx-test-fan-div
#!/bin/bash
#
# test auto fan clock divider algorithm
#
# Copyright (C) 2005 Grant Coady <gcoady@gmail.com>
#
# GPLv2 per linux/COPYING by reference
#
almpath="/sys/bus/i2c/devices/0-002d/alarms"
minpath="/sys/bus/i2c/devices/0-002d/fan1_min"
fanpath="/sys/bus/i2c/devices/0-002d/fan1_input"

# values are register equivalents for interesting points:
values=(190 191 192 193 194 253 254 255 256 257 258 259)
skip_values=0
if [ "$1" = 's' ]; then
        skip_values=1
fi

function test_two ()
{
        local y=0
        if [ $skip_values -eq 0 ]; then
                for fan_div in 1 2 4 8; do
                        while [ $y -lt 12 ]; do
                                fan_limit=$(( (1350000\
                                + ($fan_div * ${values[${y}]}) / 2)\
                                / ($fan_div * ${values[${y}]}) ))
                                echo -e "$fan_limit" >> "$TMPFILE"
                                (( y++ ))
                        done
                        y=0
                done
        fi

        while read fan_limit rest; do
                echo -e "$fan_limit" >> "$TMPFILE"
        done<<-EOF
             400
             500
             600
           10000
           25000
           50000
          100000
          250000
          500000
         1000000
         2500000
         5000000
        10000000
EOF
        sort -n < "$TMPFILE" | uniq > "$TMPFILE.sort"

        # now we can perform test and display some answers

        echo "   fan_min   fan rpm   fan_min   fan rpm   alarm"
        echo "       set    retry       read      read   state"
        echo "  --------   -------  --------  --------   -----"
        while read fan_limit rest; do
                printf "%10d" $fan_limit
                echo $fan_limit > "$minpath"
                retry=4
                sleep 1
                read fan_rpm < "$fanpath"
                echo -e "    \c"
                while [ $fan_rpm -eq 0 -a $retry -gt 0 ]; do
                        echo -e "*\c"
                        sleep 2
                        read fan_rpm < "$fanpath"
                        (( retry-- ))
                done
                while [ $retry -gt 0 ]; do
                        echo -e " \c"
                        (( retry-- ))
                done
                echo -e "  \c"
                read fan_lmt < "$minpath"
                printf "%10d" $fan_lmt
                printf "%10d" $fan_rpm
                read alarms < "$almpath"
                alarms=$(( alarms & 64 ))
                if [ $alarms -gt 0 ]; then
                        echo -e "   alarm\c"
                fi
                echo
                sleep 1
        done < "$TMPFILE.sort"
}
TMPFILE=$(mktemp -t xyz.XXXXXX)
echo -e "\nGrant's auto fan_div tester...\n"
test_two
rm -f $TMPFILE
rm -f $TMPFILE.sort
exit
#end

Read to the end?  Green elephant stamp :o)

Cheers,
Grant.
