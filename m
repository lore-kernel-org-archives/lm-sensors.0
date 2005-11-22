From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 22 Nov 2005 17:04:00 +0000
Subject: [lm-sensors] ALARM messages - why ?
Message-Id: <G7aOtjMX.1132674574.7169170.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051121154527.6F4D34BEC5@duinheks.xs4all.nl>
In-Reply-To: <20051121154527.6F4D34BEC5@duinheks.xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Johannes,

On 2005-11-22, Johannes Beekhuizen wrote:
> JD> If I am right, the way to correct this would be to edit
> JD> /etc/sensors.conf. Search for the adm1025-* section, and replace:
> JD>     set in0_min 1.5 * 0.92
> JD>     set in0_max 1.5 * 1.08
>
> Why the 8% margin?

Why not? :) Our 10% default is a bit too permissive IMHO, I would expect
a good power supply unit to be within 5%. As I don't know what hardware
you have, I proposed 8% as a compromise. The final choice is really up
to you, depends on how good you hardware is, and how picky you are.

> JD> try to reconfigure the chip by using the following command: "i2cset 0
> JD> 0x2d 0x40 0x20 b 0x20". Then reload the adm1025 driver, and the bogus
> JD> +12V line should be gone.
>
> It has gone indeed. But the change causes another problem. Now
> 'sensors -s' reports an error:
> adm1025-i2c-0-2d: Can't access procfs/sysfs file for writing;
> Run as root?
>
> After a cold boot and when I don't use i2cset I do not see this
> error. Any ideas?

Simply comment out the "set in4_min" and "set in4_max" lines in your
configuration file, and the error should disappear. The program is
complaining that you are trying to set limits for a voltage channel
which the adm1025 driver no more has.

If the i2cset command works OK, you should consider adding it in some
boot script on your system before the adm1025 driver is loaded.

Have you searched Intel's website for an updated BIOS? I believe this is
the BIOS' job to configure the chip properly.

Ideally, if the latest BIOS available doesn't configure the chip
properly, you should report the problem to Intel and ask them for an
updated BIOS. However, their site clearly states that this motherboard
is no more supported, so it's probably not even worth trying.

--
Jean Delvare
