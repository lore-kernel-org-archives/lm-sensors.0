From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:38 +0000
Subject: lm_sensors2/kernel/chips lm75.c
Message-Id: <20050220183749.0c63034c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050220112406.78febb39.khali@linux-fr.org>
In-Reply-To: <20050220112406.78febb39.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> good points
> thanks for reviewing

Thanks. Care to prepare a similar patch for Linux 2.6?

As a side note, your (u8) casts seem unnecessary to me.

> I forgot the LM75 doesn't have an alarm bit, so there's no use
> changing the CMP/INT bit.

That's absolutely right.

> This is similar to what we do in other drivers,
> but for those chips, the CMP/INT mode setting affects
> the output pin AND the alarm bits, with no harm done
> as far as I know.

I don't quite agree. There are in fact three different cases:
1* Mode affects output pin(s) only.
2* Mode affects flags only.
3* Mode affects flags and output pin(s) at the same time.

In case 1, changing the mode is pointless.

In case 2, we obviously can pick comparator mode so that flags behave
the standard way.

In case 3, I think we should *not* change the mode. If the chip is
brought to us in interrupt mode, we might decide not to display any
alarm (because they wouldn't be what user-space expects), but changing
the mode will have the side effect of altering the output, and this is
wrong, because we just don't know what is connected to it.

I think that most chips with a CMP/INT flag fall under case 3.

The fact that other drivers do change the flag in case 3 doesn't mean
it's the right thing to do. Most drivers used to reset the chip on load,
which has since proven to be incorrect.

Thanks,
-- 
Jean Delvare
