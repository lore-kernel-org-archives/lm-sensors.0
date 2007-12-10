From: Stephen Cormier <s.cormier@gmx.net>
Date: Mon, 10 Dec 2007 16:01:02 +0000
Subject: Re: [lm-sensors] sensors help
Message-Id: <200712101201.02999.s.cormier@gmx.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <a0870dac0712100008s55fbd834x3ca1b8816ff4ccf2@mail.gmail.com>
In-Reply-To: <a0870dac0712100008s55fbd834x3ca1b8816ff4ccf2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On December 10, 2007 04:08:08 am jounin F wrote:
> Hi guys,
> Anybody out there know how I can output only the motherboard and cpu
> temperature when I issue the command 'sensors'?
> I need to log the temperature reading outputted by sensors, but I only wa=
nt
> the temperature for my mobo and my cpu. That way, the log file won't be t=
oo
> large even if I collect temperature readings for days.
>
> Thanks!

$ sensors | grep Temp
CPU Temp:    +33=B0C  (low  =3D  +127=B0C, high =3D  +127=B0C)   sensor =3D=
 thermistor
SYS Temp:    +13=B0C  (low  =3D  +127=B0C, high =3D   +60=B0C)   sensor =3D=
 diode

$ sensors | grep Temp >> sensors.txt

$ cat sensors.txt
CPU Temp:    +33=B0C  (low  =3D  +127=B0C, high =3D  +127=B0C)   sensor =3D=
 thermistor
SYS Temp:    +12=B0C  (low  =3D  +127=B0C, high =3D   +60=B0C)   sensor =3D=
 diode

Now you probably want to make a little script file with the command you wil=
l=20
use in it using the full path to the file and run it via a cron job at=20
whatever interval you want the data collected. A line this in your crontab =

(use crontab -e to edit then save it) should run a script file every minute.

*/1 * * * * /home/stephen/archives/bin/sensor_log.sh >/dev/null 2&>1

With maybe this for the sensor_log.sh having used chmod +x sensor_log.sh on=
=20
the file after creating it.

#!/bin/sh
sensors | grep Temp >> /home/stephen/archives/log/sensors.log

Of course changing to your paths and the string you are greping for and if =
you=20
want to get rid of the excess on the end of the lines assuming the output=20
appears like mine above then use this for the grep part of the command.

$ sensors | grep Temp | cut -d"(" -f1
CPU Temp:    +34=B0C
SYS Temp:    +14=B0C

$ sensors | grep Temp | cut -d"(" -f1 >> sensors.txt

$ cat sensors.txt
CPU Temp:    +33=B0C  (low  =3D  +127=B0C, high =3D  +127=B0C)   sensor =3D=
 thermistor
SYS Temp:    +12=B0C  (low  =3D  +127=B0C, high =3D   +60=B0C)   sensor =3D=
 diode
CPU Temp:    +34=B0C
SYS Temp:    +14=B0C


Stephen

--=20
GPG Public Key: http://users.eastlink.ca/~stephencormier/publickey.asc

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
