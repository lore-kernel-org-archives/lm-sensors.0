From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Date: Tue, 28 Sep 2010 01:41:37 +0000
Subject: Re: [lm-sensors] [patch 01/36] hwmon: New driver for the
Message-Id: <20100928014137.GA29913@khazad-dum.debian.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100915163447.GB10422@ericsson.com>
In-Reply-To: <20100915163447.GB10422@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 27 Sep 2010, Henrique de Moraes Holschuh wrote:
> Chassis Intrusion, Bank 0, Offset 0x46, BitMask 0x40    1 = Bad, 0 > Good
>                         (Clear Bit: Bank 0, Offset 0x4d, BitMask 0x80)
> 
> Power Supply Failure, GP31(From W83627DHG-P)    1 = Good, 0 = Bad

[...]
> Is there any way to access the last two?  Do we export the GPIO pins of
> these chips through sysfs at all?

Bah, yes, we do. It's all there in sysfs, at least for the first one...

> Also, I am wondering what they mean with "Fact" in the -12V reading.

I've asked them about it, I hope they will answer.  All other readings from
the new module are matching fine with SuperODoctor (SuperMicro's userspace
monitoring application/driver through i2c-dev).

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
