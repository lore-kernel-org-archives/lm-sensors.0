From: Jelle de Jong <jelledejong@powercraft.nl>
Date: Sun, 04 Jul 2010 20:47:05 +0000
Subject: Re: [lm-sensors] fan control based on hard-drive temperatures
Message-Id: <4C30F349.5040801@powercraft.nl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------000006000907030709020702"
List-Id: <lm-sensors.vger.kernel.org>
References: <4C3099F1.5030703@powercraft.nl>
In-Reply-To: <4C3099F1.5030703@powercraft.nl>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------000006000907030709020702
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Guenter,

On 04-07-10 17:51, Guenter Roeck wrote:
> It might be possible to trick fancontrol into using temperature output
> from a regular file, though I am not sure. Others may know better.
> 
> If that works, you could write a little script to run in the background 
> which keeps reading temperature values from the hard drives and writes
> the average (or maybe better max ?) into that file, where fancontrol
> would pick it up from there.

It seems to work! I created and tested a little bash program that
integrates with fancontrol. Would be great if somebody reviews the
attachment.

Thanks in advance,

With kind regards,

Jelle de Jong
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iJwEAQECAAYFAkww80YACgkQ1WclBW9j5HmDtwQAnK0CZ61PzjkErdCqyBlUTrS3
QhGNRlZ72WXDpmZxlDmHUYH1bZbv4c+OXETSpXxfJI5xNMqX8u8r+QXfFP/Tr4vY
VHJO1uDH/agG/uFrbAyr0VzSyF95mXSlJwbU70+x43gqqfyH/9GfAR6EwfKJBoTH
pH3gDbjHncxtqRO3vj8=
=pxSU
-----END PGP SIGNATURE-----

--------------000006000907030709020702
Content-Type: text/plain;
 name="setup-melany-fancontrol.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="setup-melany-fancontrol.txt"

#!/bin/bash

# Company:  PowerCraft Technology
# Author:   Copyright Jelle de Jong <jelledejong@powercraft.nl>
# Note:     Please send me an email if you enhanced the document
# Date:     2010-07-04
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
# Version:  0.0.2
# Date:     2010-07-04

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

DISKS="[abcdefghijklmnop]"

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
    for value in $(hddtemp -n /dev/sd$DISKS 2>/dev/null)
    do
        temperature="${value//[!0-9]}"
        ((summation+=$temperature))
        ((count+=1))
        if [ $temperature -gt $maximum ]; then
            maximum=$temperature
        fi
        average=$(echo "scale=1; $summation / $count" | bc)
        if [ $DEGUG = 1 ]; then
            echo $summation
            echo $maximum
            echo $average
            echo $count
            echo "-----"
        fi
    done
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

--------------000006000907030709020702
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------000006000907030709020702--
