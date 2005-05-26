From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 26 May 2005 17:20:17 +0000
Subject: [lm-sensors] [RFC] SPI core ?
Message-Id: <JBTZaySv.1117120308.1934920.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <1117097307.6365.5.camel@diimka.dev.rtsoft.ru>
In-Reply-To: <1117097307.6365.5.camel@diimka.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Dmitry,

> > What is SPI please? Never heard of that.
>
> SPI stands for "Serial Peripheral Interface". The SPI (this name was
> created by Motorola) is also known as Microwire. The Serial Peripheral
> Interface is used primarily for a synchronous serial communication of
> host processor and peripherals. There is a small introduction to SPI and
> comparison with I2C on embedded.com
> (http://www.embedded.com/story/OEG20020124S0116)

I read the article, ineteresting read, thanks.

> Both SPI and I2C are intended to provide support to communicate with
> slow devices. Looking from kernel developer's side, development of
> drivers for SPI devices would be similar to development for I2C devices,
> giving developer the abstraction of bus and primitives to use the bus
> capabilities.

From the article, I think I understand that there are significant
differences between both protocols. In particular, slave addressing is
not part of the SPI protocol. The article suggests that the addressing
is left to the master, so as far as the subsystem goes, it would be bus
driver specific, or even worse, platform specific. In fact both
protocols have very little in common, except for being
master/slave-oriented serial busses, and are obviously in no way
compatible.

> From the other side, supporting the SPI as a sub-feature of I2C looks
> not as a good idea; SPI is capable to provide high-speed comunitications
> utilizing DMA channels. So I suggest to use drivers/spi directory to
> maintain SPI sub-tree.

I absolutely agree. There would be no benefit in creating any form of
relation between two subsystems which would have almost no common code.

Thanks,
--
Jean Delvare
