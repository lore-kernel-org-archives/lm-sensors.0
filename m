From: grant_lkml@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:54 +0000
Subject: Notes: automatic fan clock divider selection in adm9240
Message-Id: <f44j61djq4p9mu300ackiiq416v1oumq5d@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <fnlj51d1h4t37846bt741scmr7bj8s17b2@4ax.com>
In-Reply-To: <fnlj51d1h4t37846bt741scmr7bj8s17b2@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Khali, All,
On Mon, 11 Apr 2005 09:37:18 +0200 (CEST), "Jean Delvare" <khali@linux-fr.org> wrote:

>> Working on tweaking adm9240 driver, just finished documenting a method
>> for automatic fan clock divider control in the driver.  Code suggested
>> by Jean Delvare, implemented and tweaked for correct behaviour in the
>> face of unreasonable user input.
>
>I am all in favor of this (obviously). Could you please detail what kind
>of changes you did on top of my original w83627ehf code? If it sounds
>good I'll backport to my driver.

the rules are (correct me if I got it wrong again):

1. user sets fan speed limit to zero
	disable low fan speed alarm, no touch fan_div

2. user set fan speed limit too low to measure
	set fan_min to 254 * div_max, set fan_div to div_max (8 in my case)

	enable low speed alarm, an alarm will be reported when fan 
	speed drops below measurable range

3. otherwise
	select fan clock divider to suit new low fan speed limit
	enable low fan speed alarm

	the fan speed measurement code will adjust fan clock divider to 
	ensure the fan speed will be reported, an adjustment in fan clock 
	divider will also adjust fan low speed limit point, but not to 0.
	
point 2 is different and allows driver to report fan speed alarm 
while fan speed is too slow to measure

point 3 changes: stop fan_div going one step too far, forcing fan_min 
to be > 0 as zero is an error state that should not happen (potential 
for div/0).

Please let me know if you want me to update lm87.c again, or any driver 
you can test.  Once you okay the algorithm I can start on other drivers.

Current test generator and older results here:
  http://scatter.mine.nu/hwmon/auto-fan-div/zx-test-fan-div


Yesterday and this morning I separated error sources in auto fan 
clock divider operation: 

* An error in setting fan minimum limit due to rounding large 
  numbers to register size with discrete fan clock dividers.

  This is set a fan minimum speed limit, then read it back to 
  check computation and rounding errors.

* An error introduced when auto fan clock divider adjusts 
  fan_min to keep fan speed reporting.  The system trades 
  off minimum speed limit setpoint accuracy for being able 
  to always display fan speed.


Implications for user-space
````````````````````````````
Fan readings should be retried when zero is reported, auto fan 
clock divider operation is in response to reading the fan speed.

Auto fan clock divider adjustment (as currently implemented) 
can only change fan clock divider one step per read.

adm9240 driver has a 1.75s measurement cycle to accommodate 
sleep 2 in scripts :)

Example shell script for retry on zero fan speed:

#!/bin/bash
#
# demonstration: reading fan speed from adm9240
#
# Copyright (C) 2005 Grant Coady <gcoady@gmail.com>
#
# GPLv2 per linux/COPYING by reference
#
devpath="/sys/bus/i2c/devices/0-002d"
#
case $1 in
        1) fanpath="$devpath/fan1_input";;
        2) fanpath="$devpath/fan2_input";;
        *) echo -e "\n\tUsage: $0 <fan_number>\n"; exit 1;;
esac

retry=1
retry_max=3

echo -e "\n\tReading $fanpath"
read fan_rpm < "$fanpath"

while [ $fan_rpm -eq 0 -a $retry -le $retry_max ]; do
        echo -e "\twait for retry $retry"
        sleep 2
        read fan_rpm < "$fanpath"
        (( retry++ ))
done
echo -e "\tFan $1 rpm = $fan_rpm\n"
#end

Okay, there it is, and in writing this closing note on auto fan div 
I realise the current algorithm has one drawback, the requirement for 
the retries in order to get a fan speed reading under some conditions. 

Considering some chips have seven fan clock divider values, waiting 
up to a quarter minute for valid fan speed indication is a little 
too much?

--Grant.
