From: Andrey Repin <hell-for-yahoo@umail.ru>
Date: Sat, 16 Feb 2013 00:40:58 +0000
Subject: Re: [lm-sensors] [PATCH 7/9] hwmon: (adt7410) Add support for the adt7310/adt7320
Message-Id: <922462061.20130216044058@mtu-net.ru>
List-Id: <lm-sensors.vger.kernel.org>
References: <511E951C.6090604@gmx.de>
In-Reply-To: <511E951C.6090604@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Greetings, Lars-Peter Clausen!

> The adt7310/adt7320 is the SPI version of
> the adt7410/adt7320. The register map

Typo, I suppose?  ^
Just making sure it doesn't end copy-pasted somewhere else.

> layout is a bit different, i.e. the register addresses differ between the two
> variants, but the bit layouts of the individual registers are identical. So both
> chip variants can easily be supported by the same driver. The issue of non
> matching register address layouts is solved by a simple look-up table which
> translates the I2C addresses to the SPI addresses.

> The patch moves the bulk of the adt7410 driver to a common module that will be
> shared by the adt7410 and adt7310 drivers. This common module implements the
> driver logic and uses a set of virtual functions to perform IO access. The
> adt7410 and adt7310 driver modules provide proper implementations of these IO
> accessor functions for I2C respective SPI.


--
WBR,
Andrey Repin (hell-for-yahoo@umail.ru) 16.02.2013, <04:39>

Sorry for my terrible english...


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
