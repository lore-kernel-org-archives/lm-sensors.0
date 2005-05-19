From: info@i-service.de (Markus Pillmann)
Date: Thu, 19 May 2005 06:24:09 +0000
Subject: Asus a7v266ex // lm_sensors // fan solution
Message-Id: <200308041410.02266.info@i-service.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <200308040114.06823.info@i-service.de>
In-Reply-To: <200308040114.06823.info@i-service.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi again,

> > I tried to find out the correct settings and I've seen that the Asus
> > tool for watching the sensors is using a switch fan_div 4 and I tried
> > that to set for the AS99127F settings in /etc/sensors.conf
>
> What tool are you talking about? SmartDoctor2? How could you seen the
> flag there?

I used "Motherboard Monitor 5", downloaded from http://mbm.livewiredev.com/
to examine if the fan monitoring is available for any monitoring tool. well, 
it is and so I thought, I should play a bit with the dividor settings like 
seen in MBM.

> > What shell I say, it works and the fan speed is identic to that what
> > my bios itself shows up in Hardware monitoring.
>
> OK, great.
>
> > CPU FAN:  2327 RPM  (min = 1328 RPM, div = 4)
> > (...)
> > and here is the /etc/sensors.conf:
> > (...)
> > set fan1_min 1800
> > set fan1_div 4 			### this is what I changed so far
>
> Well, you ask for 1800 and you get 1328, it's far from being perfect.
> However, as mentioned in our FAQ, we won't try to fix the driver until
> Asus releases a datasheet.

sure, its far from beeing perfect, but the RPM itself is shown with a 
correct value, just the limits are not shown as the settings would expect. 
I didnt realize that so far :)

ok, anyway, thx a lot for your great work, we'll see what asus will do in 
the future with their behavior about giving datasheets or not... 

Another output to show, I'm a bit confused. I did again a "sensors -s" like 
yesterday, but now, without any changes to sensors.conf I got this:

(root@athlon) ~$ sensors -s
(root@athlon) ~$ sensors
as99127f-i2c-0-2d
Adapter: SMBus Via Pro adapter at e800
Algorithm: Non-I2C SMBus adapter
[...]
- -5V:       -4.03 V  (min =  -5.24 V, max =  -4.74 V)       ALARM
CPU FAN:  2311 RPM  (min = 1795 RPM, div = 4)
[...]

setting is still 1800, I got 1795, I think its ok so far.


sincerly

Markus Pillmann

- -- 
InternetService Rotenburg
http://www.i-service.de // info@i-service.de
Tel: +49 (0)4261-819687 // Fax: +49 (0)4261-819688
- -= Quality Webhosting in Germany =-

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/Lk0Y6BKF9iWmmLwRAoAOAKDn+4XZf7hdeVmPVl4M7ayDkZVA5gCgoLC8
t6XXqdH58FF/RjdqCp0akd0=wNXA
-----END PGP SIGNATURE-----

