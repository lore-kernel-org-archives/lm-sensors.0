From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:09 +0000
Subject: subscribe gene.heskett@verizon.net
Message-Id: <20030803105603.63f95aba.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200308012231.07647.gene.heskett@verizon.net>
In-Reply-To: <200308012231.07647.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I see.  I think.  So to build against the kernel being built, I would 
> make this line read
> LINUX :=/usr/src/linux
> since this link will be valid for the kernel being built.

You got it.

> Then I ran sensors-detect,  Everything worked except it detected an 
> lm75 instead of an adm1021 for the temp stuffs.  As I already had an 
> old line to bring it in with an option adm1021 line in modules.conf 
> so it would ignore one potential address, canceling the lm75 and 
> re-enabling the adm1021 modload in rc.local made everything work 
> again.

I guess your ADM1021 is in fact a MAX1617, which is hard to detect, as
the LM75 is. However, we have been improving detection for the lm75 and
the adm1021 families, so I'd expect that thing will be better with
lm_sensors-2.8.0. BTW, I'm a bit astonished that a non-LM75 chip could
ever be detected as a LM75 with the detection procedure we use. What is
possible is that you have both an LM75 and an adm1021-like chipset. Most
motherboards that use a LM75 use it as a secondary chip, and have
another chip as their primari monitoring chip.

Anyway, please let us know how it goes with 2.8.0.

> But, I think I've got some hardware problems, and suspect they are 
> only going to be cured by replacing my athlon cpu with a barton cored 
> unit, this DX-1600 has been running at 170F or more, .100 volts low 
> on its core vcc for going on 3 years now, and several of my reboots 
> hung either at the post stage just before the memory scan, and once 
> it spontainously rebooted when the viapro module was modprobed.  Gawd 
> I hate flaky hardware...  I have a friend with a barton cored athlon 
> DX-2400 that rarely exceeds 120F, and then only when doing mpeg2 
> smunching.

170F is a bit hot for sure, you must have some serious heatsink/fan
issue. No wonder your system may be a bit unstable. And you really need
lm_sensors working on such a system ;)

Good luck with your hardware.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
