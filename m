From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:38 +0000
Subject: gl518sm chip driver for 2.6 kernel
Message-Id: <1075741350.401e82a67eb4a@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <1075295349.4017b475e9031@imp.gcu.info>
In-Reply-To: <1075295349.4017b475e9031@imp.gcu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> There is already regvalue = gl518_read_value() & 0x14;

In fact there shouldn't be. Because I believe it shouldn't be, I forgot
it was ;) More right below.

> above that, since regvalue is supposed to only hold values from
D6,D3,
> so there is no need to &= 0x37 again.

For one thing, I didn't mean "&= 0x37 again" but "&= 0x37 *instead*".
More precisely:

- gl518_write_value(client, GL518_REG_CONF, 0xb7 & regvalue);
+ gl518_write_value(client, GL518_REG_CONF, (regvalue &= 0x37));

Hope it's clearer now.

More generally, the way things are now, you are more or less silently
forcing D0, D1 and D5 to 0. You can argue that it doesn't matter much
because D5 is set back to 1 (and 0 again) later, and D0 and D1 are
"reserved" so likely 0 anyway. Still this isn't how things should be
done IMHO. The right (and safe) way of doing things is not to touch
anything unless we have a reason and say we do.

For this reason, I would only mask D7 out of the original register
reading. It doesn't change anything practically as far as I can see,
but, again, looks safer. If you don't see why this is better, thing of
the case where the "reserved" bits are in fact used in later releases
of the chip. Forcing them to 0 could have an unexpected effect.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
