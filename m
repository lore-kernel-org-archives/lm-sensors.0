From: saturnus@silverhaven.chaosmagic.com (Incubus Saturnus)
Date: Thu, 19 May 2005 06:24:53 +0000
Subject: it87 & Asus A7V8X-X
Message-Id: <200404171549.i3HFnfn00517@SilverHaven.dnsalias.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

A suggested Asus A7V8X-X -specific fix to be included in the sample 
/etc/sensors.conf file as an MB-specific comment:

The IT87 chip on Asus A7V8X-X seems to report the VCORE voltage approximately 
0,05 volts higher as the board's BIOS does. I had the opportunity to check 
this with two CPUs, and while the amount is not exact, it seems to be a 
working fix for Athlon XP 1600+ and Athlon XP 2500+ on this motherboard.
So I managed to correct this by setting a line

compute in0 -0.05+@ , @+0.05

in /etc/sensors.conf

I have little idea of the meanings of the compute line, and I'm not saying 
the formula is correct, but this did work for me.
