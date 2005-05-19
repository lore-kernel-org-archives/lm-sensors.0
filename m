From: patrick@dreker.de (Patrick Dreker)
Date: Thu, 19 May 2005 06:24:04 +0000
Subject: LM Sensors and Kernel 2.5 (Nvidia Nforce2)
Message-Id: <200307110439.33500.patrick@dreker.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello...

After a lot of trying and reading I have realised that lm-sensors and Kernel 
2.5 are not yet usable with the Nvidia Nforce2 Chipset because of a missing 
module and because libsensors is not ready for sysfs yet. (Using Asus 
A7V8X-Deluxe Motherboard, so the sensor chip itself (w83781d) is supported 
and works under 2.4)

As far as I could understand from the website the following things would have 
to happen to make the above system work:
1) port or integrate i2c-nforce2 from LM-Sensors CVS into kernel 2.5
2) adapt libsensors to use sysfs
(correct me if I am wrong...)

Question: Is anybody already doing one or both of the above? If not: How can I 
help? If yes: are there patches to try out, or something else to help with?

I know C but I have never got my hands on kernel code (except for some USB 
Device IDs...). Would it be easy to port the nforce2 bus driver to kernel 
2.5? If it is just a simple task, how would this have to be done 
(Documentation)? I already found 
/usr/src/linux/Documentation/i2c/i2c-old-porting but this seems to not apply 
to the i2c-nforce2 driver (at least from a quick glance).

I would be willing to help, but I'd definitely need someone to show me where 
to start and give me some hints on what needs to be done...

TNX in advance
Patrick
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/DiNicERm2vzC96cRAmMuAKCTLJxciWYdnUIPVnsz4V8tPKda9ACfaR+B
cow1kU6u1d7jR2R4p5aEyc0jl5
-----END PGP SIGNATURE-----
