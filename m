From: Harry G McGavran Jr <w5pny@w5pny.com>
Date: Wed, 18 May 2011 15:59:59 +0000
Subject: Re: [lm-sensors] EMC6W201 module - Dell Sensors Testing
Message-Id: <20110518155959.CABA71A987F@localhost.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
References: <4DD30DD1.4080909@myamigos.us>
In-Reply-To: <4DD30DD1.4080909@myamigos.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



For Voltages, the dual-CPU and single-CPU setups
seem to be the same (except singles should ingnore
in5).

For Fans -- this wasn't so clear because I was partly going
by what some Windows sensors programs report to decide what
they were.

HWiNFO32 reports the CPU Fan and Chassis Fan swapped from I 
had decided.  CPUID reported what I had decided.

I decided which was which based on which fan speed went up
with heavy CPU use. Normally my CPU runs at 129F, but if
I am compiling a very large program it will run up to
151F.  The fan speed that increases the most (by several hundred
RPM) was the one I decided to call CPU which is what CPUID decided.
But who knows without running with the case open and watching.

It very well could be I have the fans backwards.
Single CPUs should ignore fan2, fan4 and fan5.

For Temperatures, HWiNFO32 reports only my first hard drive temperature.
CPUID reports the CPU, Remote Diode 5 and Mainboard temperatures,
so That's what I named them.  Looking at the emc6w201 data sheet
shows temp 5 as "Remote Diode 5" which is what CPUID called it.
Who knows what it is hooked to. Temp6 is "mainboard" or "chassis"
pretty clearly and temp1 is CPU1.  Apparently temp2 is CPU2
for those who have it, so MAYBE fan1 is really the CPU fan
if the scheme is the same, but who knows what one can count on.

	Harry McGavran







-- 

Harry G. McGavran, Jr.

E-mail: w5pny@w5pny.com




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
