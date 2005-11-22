From: johannes.beekhuizen@duinheks.xs4all.nl (johannes.beekhuizen@duinheks.xs4all.nl)
Date: Tue, 22 Nov 2005 16:31:12 +0000
Subject: [lm-sensors] ALARM messages - why ?
Message-Id: <20051122153035.53FE33543@duinheks.xs4all.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051121154527.6F4D34BEC5@duinheks.xs4all.nl>
In-Reply-To: <20051121154527.6F4D34BEC5@duinheks.xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hallo Jean,

Op 21 Nov 05 schreef Jean Delvare aan johannes.beekhuizen@duinheks.xs4all:

 >> adm1025-i2c-0-2d
 >> Adapter: SMBus I801 adapter at e000
 >> +2.5V:     +1.51 V  (min =  +2.25 V, max =  +2.75 V)   ALARM
 JD> This first one is quite easy to understand. The alarm is caused by the
 JD> measurement being off-limits. If this line is actually supposed to be at
 JD> +2.5V, yours is way too low and you should expect problems.

I obviously did not express myself clearly. What I wanted to ask is:
why do I get alarms; there seems to be nothing wrong with the hardware.
That the alarms appeared because the values were out of limits I
understood :)

 JD> However, it is also possible that Intel decided to monitor something
 JD> else. The most probable candidate there is AGP, those nominal voltage is
 JD> 1.5V. You could check in the BIOS setup screen (if there is a hardware
 JD> monitoring item there) or technical documentation.

Unfortunately there is no screen for hardware monitoring configuration
in the BIOS setup. Until I find tecnical documemtation for my ,mother
board I just assume the you guessed correctly. At least the value is
within limits after the changes you suggested.

 JD> If I am right, the way to correct this would be to edit
 JD> /etc/sensors.conf. Search for the adm1025-* section, and replace:
 JD>     set in0_min 1.5 * 0.92
 JD>     set in0_max 1.5 * 1.08

Why the 8% margin?

 >> +12V:      +0.00 V  (min = +10.81 V, max = +13.19 V)   ALARM
 JD> This one is more tricky.
   >cut<
 JD> the fact that your CPU uses VRM 9.0, which uses 5-bit VID values, makes
 JD> me guess that your chip has the shared pin wired to VID4, not +12V.

Thank you for explaining this in such a way that even I could
understand it!

 JD> try to reconfigure the chip by using the following command: "i2cset 0
 JD> 0x2d 0x40 0x20 b 0x20". Then reload the adm1025 driver, and the bogus
 JD> +12V line should be gone.

It has gone indeed. But the change causes another problem. Now
'sensors -s' reports an error:
adm1025-i2c-0-2d: Can't access procfs/sysfs file for writing;
Run as root?

After a cold boot and when I don't use i2cset I do not see this
error. Any ideas?

Groetjes,

           Hans.

jdh punt beekhuizen bij duinheks punt xs4all punt nl

--- GoldED+/LNX 1.1.5/050823
 * Origin: The Wizard is using MBSE/Linux (2:280/1018)
