From: David Brownell <david-b@pacbell.net>
Date: Tue, 23 Sep 2008 09:13:36 +0000
Subject: Re: [lm-sensors] [PATCH 6/8] hwmon: add max1111/max1110 Low-power
Message-Id: <200809230213.37098.david-b@pacbell.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <f17812d70809022312y6fd288ffu2607761414152f77@mail.gmail.com>
In-Reply-To: <f17812d70809022312y6fd288ffu2607761414152f77@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tuesday 23 September 2008, Jean Delvare wrote:
> Still, can't we allocate the transmit and receive buffers in one go?

I'd think so ...


> I guess transmit and receive can't happen concurrently, so that would be
> safe?

This is SPI, not I2C, so full duplex transfers work just fine.

Have a look at figure 12a in the MAX1110/MAX1111 data sheet to
observe continuous sampling using full duplex transfers.



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
