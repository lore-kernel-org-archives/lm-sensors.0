From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:56 +0000
Subject: lm_sensors device request
Message-Id: <20040502212807.3d7b8017.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040502190113.75974.qmail@web60802.mail.yahoo.com>
In-Reply-To: <20040502190113.75974.qmail@web60802.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I was wondering if you guys could add support for the
> Texas Instruments tmp100, since I have no progamming
> skills in c :)
> The chip doesn't have an id, here's a dump
> SMBus Register :$48
> >   $00: $12   $01: $80   $02: $4B   $03: $50   $04:
> > $00  $05: $00   $06: $00
> > $07: $00
> the temp is at the first value 12, in hex, so in dec
> 18 C.  I looked at the code for the lm75 and really
> had no idea what I was looking at, it shouldn't be to
> hard to add though, I think.

This chip is actually an enhanced LM75 chip, fully compatible, according
to the datasheet. Just force the lm75 to load using the force parameter
(modprobe lm75 force=X,0xYY where X is the bus number and 0xYY is the
chip's address on that bus.

I'm not sure we'll bother implementing a separate driver. Which system
have found that device in?

If you want us to add support to sensors-detect for this chip, please
provide the full output of i2cdump for your chip.

-- 
Jean Delvare
http://khali.linux-fr.org/
