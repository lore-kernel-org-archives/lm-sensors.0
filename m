From: christophe.dr@free.fr (christophe)
Date: Thu, 19 May 2005 06:25:38 +0000
Subject: adt7463 on asus w1n laptop
Message-Id: <200502181709.41153.christophe.dr@free.fr>
List-Id: <lm-sensors.vger.kernel.org>
References: <200502141545.03330.christophe.dr@free.fr>
In-Reply-To: <200502141545.03330.christophe.dr@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

> > So now the patch is correctly applied and could run sensors-detect
> > successfully.
> > Actually, sensors-detect did not detect the adt7463 chip.
> This is a problem. Can you please provide a dump of your chip (using
> i2cdetect to locate the correct address and i2cdump to do the actual
> dump)?

I don't know what parameters to pass to i2detect and i2cdump. I've tried some 
adresses like 002e and lots of others but i don't know which one. I'll take 
time to read man for i2cdetect and i2c dump. But i don't have time to do it 
know.

OK i realised that /sys/bus/i2c/devices/0-002e/name contains adm1027 instead 
of adt7463. Actually, i don't know which one is right since i can't read the 
name of a chip that is "jailed" in a laptop.
Do i have to load the lm85 module with special options like :
modprobe lm85 force_adt7463=xxxx
What should i put instead of this xxxx ? modinfo lm85 says "list of adapter, 
address pairs, what does it mean ?

> > So now, i can reduce manually the fan speed and have a longer battery
> > time.
> I admit I am surprised, I never thought that lowering the speed of the
> fan could really spare a significant amount of battery.

Well, i thought that the fastest the fan turns, the more energy is spent and 
the shorter the battery lasts. No ? If the fan does not spend a lot of 
energy, reducing fan speed has at least one advantage : less noise !

> > One more question : is there a way to adjust fan speed to one of the
> > temperature ?
> See this file for additional insight:
> http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/doc/chips/lm85

Should i use something like :

set pwm1_zone 123

in /etc/sensors.conf in the appropriate section (lm85 and co...), as explained 
at the end of your linked document ?


Any way, thanks a lot !!!
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFCFhNDoBxdxgioZBIRAgEvAKCpQPJd33foFF0MusCFYhEsN3B0jwCfZVld
mQW4HLMHOXvVWzoSO5+L2jE=eGxd
-----END PGP SIGNATURE-----
