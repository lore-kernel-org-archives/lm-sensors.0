From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 12 Mar 2011 21:56:15 +0000
Subject: Re: [lm-sensors] extreme fan rpms with atk0110
Message-Id: <20110312225615.7e353e31@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110312212759.3c9e0e56@endymion.delvare>
In-Reply-To: <20110312212759.3c9e0e56@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Anders,

On Sat, 12 Mar 2011 22:39:42 +0100, Anders Kullenberg wrote:
> Thanks for the quick reply.

Please don't top-post.

> I checked the BIOS readings. They are normal, even below 800rpm. I have the
> asus q-fan enabled in the bios that should control fan speeds. I tried to
> disable it, didn't change anything.
> It is possible to select ACPI 1.0, 2.0 or 3.0 in the bios, any
> recommendations on that?

I'd go for ACPI 2.0 as the best compromise between recentness and
support level, but in the end it really depends on what the BIOS adds
in each case, and whether Linux properly supports that yet or not. But
anyway it probably doesn't matter for the problem at hand.

> The fans are not any special stuff as far as I'm aware. They are connected
> to the motherboard directly, no potentiometers used in the installation.

OK. Maybe you should send your board's DSDT to Luca for analysis then.

> I found no chip "atk0110-*" section in /etc/sensors3.conf, what config is
> used then, where should I put the compute statements?

The ATK0110 usually doesn't need any configuration, as the driver knows
all the scaling factors and labels. But you are free to add a new
configuration section for it if you really have to.

I'm a little surprised as the M2V isn't a recent board, so it should be
already supported, or more users would have reported by now. Did you
look for a BIOS update for your board?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
