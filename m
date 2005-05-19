From: ajohnson@lastaccess.com (Andrew D. Johnson)
Date: Thu, 19 May 2005 06:25:03 +0000
Subject: PC87366 with the net4801
Message-Id: <1088377947.pkrlbn1vqe8@lastaccess.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200406240822.i5O8M634041403@zone3.gcu-squad.org>
In-Reply-To: <200406240822.i5O8M634041403@zone3.gcu-squad.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun 27 Jun 2004 03:29:00 PM CDT Jean Delvare <khali@linux-fr.org> said:
> 1* Make sure that temperatures increase with CPU load, and not the other
> way around. There are two kind of thermistors, positive coeff and
> negative coeff. The driver assumes negative, since that's what most
> people use. But if Soekris did a different choice, you'll have to change
> the "compute" lines in sensors.conf. Likewise, if Beta value isn't 3435,
> you'll need to update the "compute" line for proper readings.

Upon further examination, I'm now noticing a problem -- wild temperature swings.

soekris1# sensors
pc87366-isa-6620
Adapter: ISA adapter
in0:       +2.95 V  (min =  +0.00 V, max =   2.95 V)
in1:       +2.24 V  (min =  +1.18 V, max =   1.45 V)       ALARM
in2:       +2.79 V  (min =  +0.00 V, max =   2.95 V)
in3:       +0.77 V  (min =  +0.00 V, max =   2.95 V)
in4:       +2.76 V  (min =  +0.00 V, max =   2.95 V)
in5:       +2.78 V  (min =  +1.27 V, max =   1.55 V)       ALARM
in6:       +0.00 V  (min =  +1.18 V, max =   1.45 V)       ALARM
Vsb:       +3.66 V  (min =  +2.99 V, max =   3.59 V)       ALARM
Vdd:       +3.66 V  (min =  +2.99 V, max =   3.59 V)       ALARM
Vbat:      +2.95 V  (min =  +2.40 V, max =   2.95 V)
AVdd:      +3.64 V  (min =  +2.99 V, max =   3.59 V)       ALARM
temp4:       +28 C  (low  =    -0 C, high =   +85 C)
temp4_crit:
              -9 C
temp5:       +31 C  (low  =    -0 C, high =   +85 C)
temp5_crit:
              -9 C

soekris1# sensors
pc87366-isa-6620
Adapter: ISA adapter
in0:       +2.95 V  (min =  +0.00 V, max =   2.95 V)
in1:       +2.24 V  (min =  +1.18 V, max =   1.45 V)       ALARM
in2:       +2.78 V  (min =  +0.00 V, max =   2.95 V)
in3:       +0.77 V  (min =  +0.00 V, max =   2.95 V)
in4:       +2.76 V  (min =  +0.00 V, max =   2.95 V)
in5:       +2.77 V  (min =  +1.27 V, max =   1.55 V)       ALARM
in6:       +0.00 V  (min =  +1.18 V, max =   1.45 V)       ALARM
Vsb:       +3.66 V  (min =  +2.99 V, max =   3.59 V)       ALARM
Vdd:       +3.66 V  (min =  +2.99 V, max =   3.59 V)       ALARM
Vbat:      +2.95 V  (min =  +2.40 V, max =   2.95 V)
AVdd:      +3.64 V  (min =  +2.99 V, max =   3.59 V)       ALARM
temp4:       +39 C  (low  =    -0 C, high =   +85 C)
temp4_crit:
              -9 C
temp5:       +41 C  (low  =    -0 C, high =   +85 C)
temp5_crit:
              -9 C

This may sound strange, but it seems like the more I run sensors, the higher the
temperature goes. If I let it "rest" for a while by not running sensors, the
readings seem to return to 20-25C. They *seem* to stay there as long as I don't
run sensors too often. Running sensors two or more times in quick succession
will almost always yield the swings.

> 2* I still wonder why temp3 reads 80 degrees. On the one hand, it looks
> damn hot and hardly credible. On the other hand, temp3 is an internal
> sensor, so it cannot possibly be wrong. If you get a contact at Soekris,
> this is a question you may ask to them.

Ok, will do.

> 4* If you confirm that on cold reboot, thermistors (temp4 and temp5) are
> disabled on your Soekris board, we will need to give you a way to
> forcibly enable them (instead of temp1 and temp2 by default). Of course
> you can do it with isaset but that's not particularly convenient. I plan
> to do that through the init parameter (something like "add 4 to init to
> prefer thermistors over thermal diodes regardless of how the chip is
> configured"). Just tell me if you actually need it.

Ok, i'll do a cold reboot sometime tomorrow.

Thanks,

--
Andrew D. Johnson
PGP Fingerprint: 77BD 80B1 4918 1D98 9EBF 2E62 073B 9B31 A1DC 41F4
KeyID: 0xA1DC41F4
