From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 21 Nov 2005 18:08:15 +0000
Subject: [lm-sensors] ALARM messages - why ?
Message-Id: <hnrias85.1132592064.0822590.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051121154527.6F4D34BEC5@duinheks.xs4all.nl>
In-Reply-To: <20051121154527.6F4D34BEC5@duinheks.xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hallo Johannes,

On 2005-11-21, Johannes Beekhuizen wrote:
> I just installed lm_sensors 2.9.2 on my system. Motherboard
> Intel D845EBG2, kernel 2.6.13.4. When I run sensors, I see
> two alarms which I don't understand. Does somebody know why
> I get them and how I should interpret them?
> (...)
> adm1025-i2c-0-2d
> Adapter: SMBus I801 adapter at e000
> +2.5V:     +1.51 V  (min =  +2.25 V, max =  +2.75 V)   ALARM

This first one is quite easy to understand. The alarm is caused by the
measurement being off-limits. If this line is actually supposed to be at
+2.5V, yours is way too low and you should expect problems.

However, it is also possible that Intel decided to monitor something
else. The most probable candidate there is AGP, those nominal voltage is
1.5V. You could check in the BIOS setup screen (if there is a hardware
monitoring item there) or technical documentation.

If I am right, the way to correct this would be to edit
/etc/sensors.conf. Search for the adm1025-* section, and replace:

    label in0 "+2.5V"

with:

    label in0 "Vagp"

and:

    set in0_min 2.5 * 0.90
    set in0_max 2.5 * 1.10

with:

    set in0_min 1.5 * 0.92
    set in0_max 1.5 * 1.08

> VCore:     +1.48 V  (min =  +1.43 V, max =  +1.57 V)
> +3.3V:     +3.35 V  (min =  +2.97 V, max =  +3.63 V)
> +5V:       +5.05 V  (min =  +4.50 V, max =  +5.50 V)
> +12V:      +0.00 V  (min = +10.81 V, max = +13.19 V)   ALARM

This one is more tricky. The fifth voltage input line (in4) is shared
with the fifth digital VID input (VID4) on the ADM1025. You can't have
both at the same time. The board manufacturer can use it in either way,
but the chip must then be properly configured.

The default function is in4 (+12V measurement), which seems to be the way
your own chip is configured. However, the 0 reading, together with the
fact that your CPU uses VRM 9.0, which uses 5-bit VID values, makes me
guess that your chip has the shared pin wired to VID4, not +12V.

Ideally, the BIOS should configure the chip properly, but it doesn't
seem to be your case. You can provide the output of "i2cdump 0 0x2d b"
(after a cold boot and before loading adm1025) for confirmation. You can
try to reconfigure the chip by using the following command: "i2cset 0
0x2d 0x40 0x20 b 0x20". Then reload the adm1025 driver, and the bogus
+12V line should be gone.

--
Jean Delvare
