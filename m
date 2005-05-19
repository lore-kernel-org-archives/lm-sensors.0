From: ajohnson@lastaccess.com (Andrew D. Johnson)
Date: Thu, 19 May 2005 06:25:03 +0000
Subject: PC87366 with the net4801
Message-Id: <1088411031.5yojq7zqjr0g@lastaccess.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200406240822.i5O8M634041403@zone3.gcu-squad.org>
In-Reply-To: <200406240822.i5O8M634041403@zone3.gcu-squad.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon 28 Jun 2004 03:14:11 AM CDT Jean Delvare <khali@linux-fr.org> said:
> You may try the following command:
>
> isaset -f 0x6627 0x02
>
> It'll increase the sampling rate (at the cost of power consumption, I
> suppose). You can revert to the old speed at any time using:
>
> isaset -f 0x6627 0x00
>
> Let me know if it changes anything.

It did have rather interesting results:
pc87366-isa-6620
Adapter: ISA adapter
in0:       +2.95 V  (min =  +0.00 V, max =   2.95 V)
in1:       +2.24 V  (min =  +1.18 V, max =   1.45 V)       ALARM
in2:       +2.78 V  (min =  +0.00 V, max =   2.95 V)
in3:       +0.79 V  (min =  +0.00 V, max =   2.95 V)
in4:       +2.76 V  (min =  +0.00 V, max =   2.95 V)
in5:       +2.77 V  (min =  +1.27 V, max =   1.55 V)       ALARM
in6:       +0.00 V  (min =  +1.18 V, max =   1.45 V)       ALARM
Vsb:       +3.66 V  (min =  +2.99 V, max =   3.59 V)       ALARM
Vdd:       +3.66 V  (min =  +2.99 V, max =   3.59 V)       ALARM
Vbat:      +2.95 V  (min =  +2.40 V, max =   2.95 V)
AVdd:      +3.64 V  (min =  +2.99 V, max =   3.59 V)       ALARM
temp4:        +5 C  (low  =    -0 C, high =   +85 C)
temp4_crit:
              -9 C
temp5:       +11 C  (low  =    -0 C, high =   +85 C)
temp5_crit:
              -9 C

These readings seem to hold steady, regardless of how rapidly I run the sensors
program. They return to "normal" when I revert the change.

--
Andrew D. Johnson
PGP Fingerprint: 77BD 80B1 4918 1D98 9EBF 2E62 073B 9B31 A1DC 41F4
KeyID: 0xA1DC41F4
