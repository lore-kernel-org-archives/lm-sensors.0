From: oe@hentges.net (Matthias Hentges)
Date: Tue, 05 Sep 2006 12:17:51 +0000
Subject: [lm-sensors] w83627ehf: Missing fan input and minor problems w/ PWM
Message-Id: <1157458671.18988.34.camel@mhcln03>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

since a few weeks ago I am the proud owner of an Asus P5W DH Deluxe
mainboard. It features the w83627ehf chip for hardware monitoring. While
all in all the monitoring works allright, there are a few minor
bugs in this driver. Before I continue let me say that I have fans
connected to every connector on this board.

- The board has 5 fan connectors (1x CPU, 2xCHA, 2xPWR) and 5 RPM
readings can be accessed in the BIOS, the driver however, only shows 4
fans. It would be nice to get a reading of the missing fan =)

- PWM control is a little bit confused:
	- pwm1 controls _both_ CHA fans, not only one of them (the 2nd CHA fan
is the one missing from 
	the driver)
	- pwm2 works just fine and controls the CPU fan
	- pwm3 doesn't change any fans at all
	- pwm4 controls _both_ PWR fans, not only one of them

It would be nice to get a pwm5 for the 5th fan and have every pwm
control a single fan =)

FWIW: Im running 2.6.18-rc4-mm3 right now.
If you need more information or a willing test-subject, let me know.

-- 
Matthias 'CoreDump' Hentges 

Webmaster of hentges.net and OpenZaurus developer.
You can reach me in #openzaurus on Freenode.

My OS: Debian SID. Geek by Nature, Linux by Choice
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: Dies ist ein digital signierter Nachrichtenteil
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060905/26cacaa5/attachment.bin 
