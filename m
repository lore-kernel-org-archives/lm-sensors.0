From: Jelle de Jong <jelledejong@powercraft.nl>
Date: Mon, 05 Jul 2010 06:45:10 +0000
Subject: Re: [lm-sensors] fan control based on hard-drive temperatures
Message-Id: <4C317F76.5080003@powercraft.nl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------070304080001060502070900"
List-Id: <lm-sensors.vger.kernel.org>
References: <4C3099F1.5030703@powercraft.nl>
In-Reply-To: <4C3099F1.5030703@powercraft.nl>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------070304080001060502070900
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi Guenter,

On 04-07-10 23:26, Guenter Roeck wrote:
>> This looks like it might be quite useful for others as well. Wonder
>> if it would make sense to integrate it info fancontrol and/or
>> pwmconfig. Couple of minor comments inline.

Thanks for the feedback. I would love to see fancontrol be enhanced with
the feature to use the hddtemp average or maximum.

I attached a new version making hddtemp use all harddisk instead of a
specified list. (can still be specified) I also moved the calculation of
the avarage temperuture outside the main loop when not running in debug
mode. This should make the shell scrip slightly faster.

> That isn't really a documentation, but an installation shell script.=20
> Not that I care much, it is just odd to have such a script with an
> ending of .txt. Is that common nowadays or just your personal touch?

The installation document was .txt the script inside was bash both had
different licenses and styles, it is more personal touch. I share a lot
of this stuff, so it is my standard format.

> "average=3D$(($summation / $count))" would probably be sufficient
> here. For a "final" code version, it would be sufficient to
> calculate the average after the loop. But then you would have to
> check for $count =3D=3D 0, so I am not sure if it would be worth it.

We need support for a floating number not a integer. The average
temperature can become 39.9 degrees. And with your suggestion this would
be rounded in 39, this is not the fan control I need, the shell command
I choice makes the average of 39.9 possible.

> "echo $(($average * 1000))" seems to work as well and would be a bit
> simpler. What is the "/1" for, anyway ? bc doesn't seem to need it.

The scale of a multiplication is min(a+b,max(scale,a,b)), where a and b
are the scales of the factors. (and 46.5 has a scale of 1, so the above
expression becomes min(0+1,max(0,1,0))=3Dmin(1,1)=3D1. So witouth the /1
part bc returns 46500.0 instead of the needed 46500 for fancontrol.
Adding the /1 over the results makes bc return 46500 and this can be
used by fancontrol (notice the support for the extra precision because
of the earlier use of bc)

> Also, you are loosing precision because average is calculated (and
> rounded down) first. You could avoid that with "echo $(($average *
> 1000 / $count))" if you check for the $count=3D=3D0 case. But then that
> doesn't really make much of a difference, so I am not sure if it
> would be worth it either.

I don't see any precession loss. There would be precession loss with the
previous suggestions, maybe I am seeing it wrong :D

> Might be better to add a startup script in /etc/init.d and/or
> /etc/rc*.d and make sure it runs before fancontrol is started.

True, but I am not going to maintain a starup script, when there is a
useful excising starup script for fan control.

If somebody want they can pick it up and integrate it with fancontrol,
as long I don=92t lose temperature precession or the possibility to use
the maximum or average.

With kind regards,

Jelle de Jong

--------------070304080001060502070900
Content-Type: text/plain;
 name="setup-melany-fancontrol.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="setup-melany-fancontrol.txt"

# Company:  PowerCraft Technology
# Author:   Copyright Jelle de Jong <jelledejong@powercraft.nl>
# Note:     Please send me an email if you enhanced the document
# Date:     2010-07-04 / 2010-07-05
# License:  CC-BY-SA

# This document is free documentation; you can redistribute it and/or
# modify it under the terms of the Creative Commons Attribution Share
# Alike as published by the Creative Commons Foundation; either version
# 3.0 of the License, or (at your option) any later version.
#
# This document is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# Creative Commons BY-SA License for more details.
#
# http://creativecommons.org/licenses/by-sa/

#-----------------------------------------------------------------------

apt-get install bc hddtemp file fancontrol

#-----------------------------------------------------------------------

echo '#!/bin/bash -e

# Company:  PowerCraft Technology
# Author:   Copyright Jelle de Jong <jelledejong@powercraft.nl>
# Note:     Please send me an email if you enhanced the script
# Version:  0.0.4
# Date:     2010-07-04 / 2010-07-05

# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
# MA 02110-1301, USA.

PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/bin/

LC_ALL=C

# set -x
# exec 2>>/var/log/pct-fancontrol-hddtemp.log
# date=$(date)

DISKS="/dev/sd[a-z]"

# located in /var/lib/ so it will be there for fancontrol during boot
LOCATION=/var/lib/pct-fancontrol-hddtemp
FILE_MAX="$LOCATION"/pct-fancontrol-hddtemp-maximum
FILE_AVG="$LOCATION"/pct-fancontrol-hddtemp-average

DEGUG=0

[[ -e $LOCATION ]] || mkdir "$LOCATION"

while true
    do
    temperature=0
    summation=0
    maximum=0
    average=0
    count=0
    for value in $(hddtemp -n $DISKS 2>/dev/null)
    do
        temperature="${value//[!0-9]}"
        ((summation+=$temperature))
        ((count+=1))
        if [ $temperature -gt $maximum ]; then
            maximum=$temperature
        fi
        if [ $DEGUG = 1 ]; then
            average=$(echo "scale=1; $summation / $count" | bc)
            echo $summation
            echo $maximum
            echo $average
            echo $count
            echo "-----"
        fi
    done
    average=$(echo "scale=1; $summation / $count" | bc)
    # fancontrol output format
    echo "($maximum * 1000)/1" | bc > "$FILE_MAX"
    echo "($average * 1000)/1" | bc > "$FILE_AVG"
    sleep 45
done

exit' | tee /usr/local/bin/pct-fancontrol-hddtemp

chown root:root /usr/local/bin/pct-fancontrol-hddtemp
chmod 755 /usr/local/bin/pct-fancontrol-hddtemp
ls -hal /usr/local/bin/pct-fancontrol-hddtemp
cat /usr/local/bin/pct-fancontrol-hddtemp

#-----------------------------------------------------------------------

bash -x /usr/local/bin/pct-fancontrol-hddtemp
/usr/local/bin/pct-fancontrol-hddtemp &
cat /var/lib/pct-fancontrol-hddtemp/pct-fancontrol-hddtemp-maximum
cat /var/lib/pct-fancontrol-hddtemp/pct-fancontrol-hddtemp-average
cat /var/lib/pct-fancontrol-hddtemp/*

watch cat /var/lib/pct-fancontrol-hddtemp/*

#-----------------------------------------------------------------------

vim /etc/fancontrol
    INTERVAL=10
    DEVPATH=hwmon0=devices/platform/it87.552
    DEVNAME=hwmon0=it8720
    FCTEMPS=hwmon0/device/pwm2=/var/lib/pct-fancontrol-hddtemp/pct-fancontrol-hddtemp-maximum hwmon0/device/pwm1=hwmon0/device/temp2_input
    FCFANS=hwmon0/device/pwm2=hwmon0/device/fan2_input hwmon0/device/pwm1=hwmon0/device/fan1_input
    MINTEMP=hwmon0/device/pwm2=41 hwmon0/device/pwm1=35
    MAXTEMP=hwmon0/device/pwm2=51 hwmon0/device/pwm1=55
    MINSTART=hwmon0/device/pwm2=58 hwmon0/device/pwm1=70
    MINSTOP=hwmon0/device/pwm2=58 hwmon0/device/pwm1=66

/etc/init.d/fancontrol restart

#-----------------------------------------------------------------------

/etc/init.d/fancontrol stop

whereis fancontrol
file /usr/sbin/fancontrol

bash -x /usr/sbin/fancontrol

#-----------------------------------------------------------------------

vim /etc/rc.local
    /usr/local/bin/pct-fancontrol-hddtemp

cat /etc/rc.local

#-----------------------------------------------------------------------

ps aux | grep fancontrol

#-----------------------------------------------------------------------

--------------070304080001060502070900
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------070304080001060502070900--
