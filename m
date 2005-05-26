From: dpervushin@ru.mvista.com (dmitry pervushin)
Date: Thu, 26 May 2005 12:03:12 +0000
Subject: [lm-sensors] [RFC] SPI core ?
Message-Id: <1117101776.6365.26.camel@diimka.dev.rtsoft.ru>
List-Id: <lm-sensors.vger.kernel.org>
References: <1117097307.6365.5.camel@diimka.dev.rtsoft.ru>
In-Reply-To: <1117097307.6365.5.camel@diimka.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 2005-05-26 at 10:54 +0200, Jean Delvare wrote:
> Hi Dmitry,
> 
> > In our internal linux tree, we have the SPI core support, which has been
> > derived from I2C framework. The SPI support is very valuable for our
> > customer; they want to attach various devices to SPI bus and want to
> > have SPI support in linux kernel.
> What is SPI please? Never heard of that.
SPI stands for "Serial Peripheral Interface". The SPI (this name was
created by Motorola) is also known as Microwire. The Serial Peripheral
Interface is used primarily for a synchronous serial communication of
host processor and peripherals. There is a small introduction to SPI and
comparison with I2C on embedded.com
(http://www.embedded.com/story/OEG20020124S0116)

> > What community thinks about adding the SPI core to kernel to be
> > maintained as part as I2C framework ?
> 
> Please tell how SPI and I2C would be linked. We can't tell you what we
> think about an idea before you describe that idea in detail.
Both SPI and I2C are intended to provide support to communicate with
slow devices. Looking from kernel developer's side, development of
drivers for SPI devices would be similar to development for I2C devices,
giving developer the abstraction of bus and primitives to use the bus
capabilities.
From the other side, supporting the SPI as a sub-feature of I2C looks
not as a good idea; SPI is capable to provide high-speed comunitications
utilizing DMA channels. So I suggest to use drivers/spi directory to
maintain SPI sub-tree. 

> Thanks,
> --
> Jean Delvare
> 
> 
-- 
cheers, dmitry pervushin

