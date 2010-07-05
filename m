From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 05 Jul 2010 15:06:23 +0000
Subject: Re: [lm-sensors] fan control based on hard-drive temperatures
Message-Id: <20100705150623.GB25711@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4C3099F1.5030703@powercraft.nl>
In-Reply-To: <4C3099F1.5030703@powercraft.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Mon, Jul 05, 2010 at 02:45:10AM -0400, Jelle de Jong wrote:
> Hi Guenter,
>=20
> On 04-07-10 23:26, Guenter Roeck wrote:
> >> This looks like it might be quite useful for others as well. Wonder
> >> if it would make sense to integrate it info fancontrol and/or
> >> pwmconfig. Couple of minor comments inline.
>=20
> Thanks for the feedback. I would love to see fancontrol be enhanced with
> the feature to use the hddtemp average or maximum.
>=20
> I attached a new version making hddtemp use all harddisk instead of a
> specified list. (can still be specified) I also moved the calculation of
> the avarage temperuture outside the main loop when not running in debug
> mode. This should make the shell scrip slightly faster.
>=20
> > That isn't really a documentation, but an installation shell script.=20
> > Not that I care much, it is just odd to have such a script with an
> > ending of .txt. Is that common nowadays or just your personal touch?
>=20
> The installation document was .txt the script inside was bash both had
> different licenses and styles, it is more personal touch. I share a lot
> of this stuff, so it is my standard format.
>=20
> > "average=3D$(($summation / $count))" would probably be sufficient
> > here. For a "final" code version, it would be sufficient to
> > calculate the average after the loop. But then you would have to
> > check for $count =3D 0, so I am not sure if it would be worth it.
>=20
> We need support for a floating number not a integer. The average
> temperature can become 39.9 degrees. And with your suggestion this would
> be rounded in 39, this is not the fan control I need, the shell command
> I choice makes the average of 39.9 possible.
>=20
Ok, understood.

> > "echo $(($average * 1000))" seems to work as well and would be a bit
> > simpler. What is the "/1" for, anyway ? bc doesn't seem to need it.
>=20
> The scale of a multiplication is min(a+b,max(scale,a,b)), where a and b
> are the scales of the factors. (and 46.5 has a scale of 1, so the above
> expression becomes min(0+1,max(0,1,0))=3Dmin(1,1)=3D1. So witouth the /1
> part bc returns 46500.0 instead of the needed 46500 for fancontrol.
> Adding the /1 over the results makes bc return 46500 and this can be
> used by fancontrol (notice the support for the extra precision because
> of the earlier use of bc)

Ok, thanks for the clarification.

>=20
> > Also, you are loosing precision because average is calculated (and
> > rounded down) first. You could avoid that with "echo $(($average *
> > 1000 / $count))" if you check for the $count=3D0 case. But then that
> > doesn't really make much of a difference, so I am not sure if it
> > would be worth it either.
>=20
> I don't see any precession loss. There would be precession loss with the
> previous suggestions, maybe I am seeing it wrong :D
>=20
You are right ...

Thanks,
Guenter

> > Might be better to add a startup script in /etc/init.d and/or
> > /etc/rc*.d and make sure it runs before fancontrol is started.
>=20
> True, but I am not going to maintain a starup script, when there is a
> useful excising starup script for fan control.
>=20
> If somebody want they can pick it up and integrate it with fancontrol,
> as long I don=E2=80=99t lose temperature precession or the possibility to=
 use
> the maximum or average.
>=20
> With kind regards,
>=20
> Jelle de Jong

> # Company:  PowerCraft Technology
> # Author:   Copyright Jelle de Jong <jelledejong@powercraft.nl>
> # Note:     Please send me an email if you enhanced the document
> # Date:     2010-07-04 / 2010-07-05
> # License:  CC-BY-SA
>=20
> # This document is free documentation; you can redistribute it and/or
> # modify it under the terms of the Creative Commons Attribution Share
> # Alike as published by the Creative Commons Foundation; either version
> # 3.0 of the License, or (at your option) any later version.
> #
> # This document is distributed in the hope that it will be useful,
> # but WITHOUT ANY WARRANTY; without even the implied warranty of
> # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> # Creative Commons BY-SA License for more details.
> #
> # http://creativecommons.org/licenses/by-sa/
>=20
> #-----------------------------------------------------------------------
>=20
> apt-get install bc hddtemp file fancontrol
>=20
> #-----------------------------------------------------------------------
>=20
> echo '#!/bin/bash -e
>=20
> # Company:  PowerCraft Technology
> # Author:   Copyright Jelle de Jong <jelledejong@powercraft.nl>
> # Note:     Please send me an email if you enhanced the script
> # Version:  0.0.4
> # Date:     2010-07-04 / 2010-07-05
>=20
> # This program is free software; you can redistribute it and/or modify
> # it under the terms of the GNU General Public License as published by
> # the Free Software Foundation; either version 3 of the License, or
> # (at your option) any later version.
> #
> # This program is distributed in the hope that it will be useful,
> # but WITHOUT ANY WARRANTY; without even the implied warranty of
> # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> # GNU General Public License for more details.
> #
> # You should have received a copy of the GNU General Public License
> # along with this program; if not, write to the Free Software
> # Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
> # MA 02110-1301, USA.
>=20
> PATH=3D/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/bin/
>=20
> LC_ALL=3DC
>=20
> # set -x
> # exec 2>>/var/log/pct-fancontrol-hddtemp.log
> # date=3D$(date)
>=20
> DISKS=3D"/dev/sd[a-z]"
>=20
> # located in /var/lib/ so it will be there for fancontrol during boot
> LOCATION=3D/var/lib/pct-fancontrol-hddtemp
> FILE_MAX=3D"$LOCATION"/pct-fancontrol-hddtemp-maximum
> FILE_AVG=3D"$LOCATION"/pct-fancontrol-hddtemp-average
>=20
> DEGUG=3D0
>=20
> [[ -e $LOCATION ]] || mkdir "$LOCATION"
>=20
> while true
>     do
>     temperature=3D0
>     summation=3D0
>     maximum=3D0
>     average=3D0
>     count=3D0
>     for value in $(hddtemp -n $DISKS 2>/dev/null)
>     do
>         temperature=3D"${value//[!0-9]}"
>         ((summation+=3D$temperature))
>         ((count+=3D1))
>         if [ $temperature -gt $maximum ]; then
>             maximum=3D$temperature
>         fi
>         if [ $DEGUG =3D 1 ]; then
>             average=3D$(echo "scale=3D1; $summation / $count" | bc)
>             echo $summation
>             echo $maximum
>             echo $average
>             echo $count
>             echo "-----"
>         fi
>     done
>     average=3D$(echo "scale=3D1; $summation / $count" | bc)
>     # fancontrol output format
>     echo "($maximum * 1000)/1" | bc > "$FILE_MAX"
>     echo "($average * 1000)/1" | bc > "$FILE_AVG"
>     sleep 45
> done
>=20
> exit' | tee /usr/local/bin/pct-fancontrol-hddtemp
>=20
> chown root:root /usr/local/bin/pct-fancontrol-hddtemp
> chmod 755 /usr/local/bin/pct-fancontrol-hddtemp
> ls -hal /usr/local/bin/pct-fancontrol-hddtemp
> cat /usr/local/bin/pct-fancontrol-hddtemp
>=20
> #-----------------------------------------------------------------------
>=20
> bash -x /usr/local/bin/pct-fancontrol-hddtemp
> /usr/local/bin/pct-fancontrol-hddtemp &
> cat /var/lib/pct-fancontrol-hddtemp/pct-fancontrol-hddtemp-maximum
> cat /var/lib/pct-fancontrol-hddtemp/pct-fancontrol-hddtemp-average
> cat /var/lib/pct-fancontrol-hddtemp/*
>=20
> watch cat /var/lib/pct-fancontrol-hddtemp/*
>=20
> #-----------------------------------------------------------------------
>=20
> vim /etc/fancontrol
>     INTERVAL=10
>     DEVPATH=3Dhwmon0=DEvices/platform/it87.552
>     DEVNAME=3Dhwmon0=3Dit8720
>     FCTEMPS=3Dhwmon0/device/pwm2=3D/var/lib/pct-fancontrol-hddtemp/pct-fa=
ncontrol-hddtemp-maximum hwmon0/device/pwm1=3Dhwmon0/device/temp2_input
>     FCFANS=3Dhwmon0/device/pwm2=3Dhwmon0/device/fan2_input hwmon0/device/=
pwm1=3Dhwmon0/device/fan1_input
>     MINTEMP=3Dhwmon0/device/pwm2A hwmon0/device/pwm15
>     MAXTEMP=3Dhwmon0/device/pwm2Q hwmon0/device/pwm1U
>     MINSTART=3Dhwmon0/device/pwm2X hwmon0/device/pwm1p
>     MINSTOP=3Dhwmon0/device/pwm2X hwmon0/device/pwm1f
>=20
> /etc/init.d/fancontrol restart
>=20
> #-----------------------------------------------------------------------
>=20
> /etc/init.d/fancontrol stop
>=20
> whereis fancontrol
> file /usr/sbin/fancontrol
>=20
> bash -x /usr/sbin/fancontrol
>=20
> #-----------------------------------------------------------------------
>=20
> vim /etc/rc.local
>     /usr/local/bin/pct-fancontrol-hddtemp
>=20
> cat /etc/rc.local
>=20
> #-----------------------------------------------------------------------
>=20
> ps aux | grep fancontrol
>=20
> #-----------------------------------------------------------------------


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
