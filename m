From: christophe.dr@free.fr (christophe)
Date: Thu, 19 May 2005 06:25:39 +0000
Subject: adt7463 on asus w1n laptop
Message-Id: <200502211655.46106.christophe.dr@free.fr>
List-Id: <lm-sensors.vger.kernel.org>
References: <200502141545.03330.christophe.dr@free.fr>
In-Reply-To: <200502141545.03330.christophe.dr@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Le lundi 21 F?vrier 2005 16:32, Jean Delvare a ?crit?:
> Hi Christophe,
>
> > If i run "sensord -i 1m -l 30m", i read this in /var/log/syslog :
> > Error getting sensor data: adt7463/fan1_tach_mode: Can't access
> > procfs/sysfs file
>
> I would suggest that you do NOT run sensord. Most people don't need it
> and since it is not being actively maintained, using it is usually
> asking for more trouble than is worth.

Thanks for your very kind advice !

> sensord is a deamon which will poll the sensors repeatedly, and log
> problems when they occur. While this is fine for servers, it is usually
> easier for regular users on desktop/laptop systems to just run
> "sensors" from times to times, or use graphical frontends (xsensors,
> gkrellm, ksensors...).
>
> At any rate, sensord is *not* required for fan control operations
> (neither automatic nor manual). It is, in fact, totally unrelated
> (sensord is about monitoring/reporting, not control).

So how can i suggect this fan to adapt its temperature to the 3 monitored 
temperatures ?
I have added in /etc/sensors.conf :

set pwm1_zone 123
set pwm1_min_ctl 0
set pwm1_min 0

set temp1_min 20
set temp1_max 60       # dothan's max temp is actually around 100?C
set temp2_min 10
set temp2_max 45
set temp3_min 10
set temp3_max 45

It appears that when the fan reaches 3000rpm it never spins down below that 
speed whatever the temp#_min and temp#_max are.

I ran pwmconfig and fancontrol but fancontrol adjusts fan speed only to one 
temperature, and moreover, it says that access to fan1_pwm_enable is denied.

Actually i can't find an easy way to adapt the fan speed (fan1) according the 
3 temperatures, so that fan speed is as low as possible.

Thank you.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFCGgSAoBxdxgioZBIRAkPZAJ9vmk0U7gsWWuh26UPHlQ6VD2UBlgCfW959
Aa6lNVPvx1cITevx7KjbsMU=eHFw
-----END PGP SIGNATURE-----
