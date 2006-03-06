From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 06 Mar 2006 08:43:24 +0000
Subject: [lm-sensors] Radeon LM63 support
Message-Id: <pEuED2gZ.1141634604.5634840.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <200602272329.20330.pavouk@pavouk.org>
In-Reply-To: <200602272329.20330.pavouk@pavouk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Rudolf, Pavel,

On 2006-03-05, Rudolf Marek wrote:
> Pavel Ruzicka wrote:
> > I have ATI Radeon X800 card with passive heatsink.
> > Winblows program ATITOOL displays two temperatures and can control fan.
> > In a log I see that he found LM63 chip. This chip is supported by latest
> > kernel, but I didn't found support for Radeon SMBus or I2C.
> > It's possible to read temperatures? (or control fan for others...)
>
> Technically yes if there is a driver to access the SMBUS on the ATI card.
> I know that such driver is for nVidia not sure about ati.
>
> There is a possibility that it resides on same bus as DDC channel to
> monitor, so you may try to scan that bus (it is the bit bang bus)
>
> So just look to X.org sources for I2C the implement the bitbang driver
> and then use i2cdetect ;)

If the LM63 chip is on the DDC channels, then Pavel could simply use the
radeonfb driver with I2C support enabled. This will instanciate 4
bit-banging i2c adapters.

However, another user in a similar situation tried that, and reported
that the LM63 was nowhere to be found, so either there was one or more
additional I2C/SMBus busses on the Radeon boards, or there was some bus
multiplexing in action. We did not investigate any further. In either
case, the radeonfb driver would need to be extended to support the
additional busses or bus branches. This would require documentation we
(or at least I) don't have, or free code to look at.

--
Jean Delvare

