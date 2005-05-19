From: christophe.dr@free.fr (christophe)
Date: Thu, 19 May 2005 06:25:39 +0000
Subject: adt7463 on asus w1n laptop
Message-Id: <200502222306.38302.christophe.dr@free.fr>
List-Id: <lm-sensors.vger.kernel.org>
References: <200502141545.03330.christophe.dr@free.fr>
In-Reply-To: <200502141545.03330.christophe.dr@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Le lundi 21 F?vrier 2005 20:22, vous avez ?crit?:
> The lm85 driver is the correct driver for the ADT7463.  The problem you
> have is that you're using a version of lm85 that does not include the
> fan speed control functionality.
>
> The initial port of the lm85 driver to the 2.6 kernel did *not* include
> the fan speed control features.  They were added later (a couple of
> months ago.) with a patch.
>
> Unfortunately, I don't have the patch handy.  It was submitted to Greg
> KH for inclusion in his trees and from there should have made it's way
> into the Torvalds tree.
>
> If you search the lm_sensors archives, you should find the patch.
> Alternatively, you might be able to get it from a GregKH kernel on
> kernel.org.  Lastly, you might need a 2.6.10 or later kernel to get the
> additional functionality.
>
> Then the pwm1_zone settings in sensors.conf will work.  Until you
> upgrade the driver, they won't.
>
> :v)
OK !!!
Thanks a lot for your help.
As i'd like to stay on kernel 2.6.8.1 for a few months more (too much work 
done on it), i decided to solve the problem by myself. I wrote a small 
programm in c to compute a value between 0 and 255 according to the 
temperature of cpu, gpu and motherboard. With a 4 lines shell script it can 
set fan speed (fan1_pwm) at a regular pace. And that worls great. Each time, 
a sensors gets a lot of celsius, the fan gets a lot of rpms....

Thanks to Jean, Mark and Philip
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFCG6zsoBxdxgioZBIRAnJCAJ97wL6HZYA/sOtkdyKb0jVr5H6g6QCgim3/
7uX4E5AcgCcki6yBLkMt9nY=h05n
-----END PGP SIGNATURE-----
