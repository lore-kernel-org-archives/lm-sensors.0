From: Michael Barkowski <michaelbarkowski@ruggedcom.com>
Date: Wed, 12 Aug 2009 20:45:55 +0000
Subject: Re: [lm-sensors] [PATCH 2/6] mtd: m25p80: Convert to device table
Message-Id: <4A832A03.6020507@ruggedcom.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090731003957.GA23982@oksana.dev.rtsoft.ru> <20090731004100.GB8371@oksana.dev.rtsoft.ru>
In-Reply-To: <20090731004100.GB8371@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: linux-mtd@lists.infradead.org, lm-sensors@lm-sensors.org, linuxppc-dev@ozlabs.org

Hello Anton,

Is m25p_probe now valid with dev.platform_data = NULL, for of platforms?

Then shouldn't you have the following change as well, near the end of
the function?

-  	} else if (data->nr_parts)
+  	} else if (data && data->nr_parts)
		dev_warn(&spi->dev, "ignoring %d default partitions on %s\n",
				data->nr_parts, data->name);

Or am I misunderstanding something?

-- 
Michael Barkowski
RuggedCom


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
