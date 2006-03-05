From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Sun, 05 Mar 2006 20:12:17 +0000
Subject: [lm-sensors] Radeon LM63 support
Message-Id: <440B4621.40206@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <200602272329.20330.pavouk@pavouk.org>
In-Reply-To: <200602272329.20330.pavouk@pavouk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Pavel Ruzicka wrote:
> Hello,
> 
> I have ATI Radeon X800 card with passive heatsink.
> Winblows program ATITOOL displays two temperatures and can control fan.
> In a log I see that he found LM63 chip. This chip is supported by latest
> kernel, but I didn't found support for Radeon SMBus or I2C.
> It's possible to read temperatures? (or control fan for others...)
> 
Technically yes if there is a driver to access the SMBUS on the ATI card.
I know that such driver is for nVidiia not sure about ati.

There is a possibility that it resides on same bus as DDC channel to monitor,
so you may try to scan that bus (it is the bit bang bus)

So just look to X.org sources for I2C the implement the bitbang driver and then use
i2cdetect ;)

Regards
Rudolf

