From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:55 +0000
Subject: Ticket #1963 solution + further info
Message-Id: <XeczbLHE.1114516968.5956230.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <426DD728.6040200@SoftHome.net>
In-Reply-To: <426DD728.6040200@SoftHome.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org


Hi Barton,

> The script wants these modules loaded:
>
> MODULE_0=3Di2c-matroxfb
> MODULE_1=3Di2c-isa
> MODULE_2=DDcmon
> MODULE_3=3Dw83627hf
>
> i2c-matroxfb is uneeded and creates the problem with the smbus and
> blanked screens, and the ddcmon module which is non-existent.

The ddcmon driver is a Linux 2.4-only driver, which is now deprecated in
favor of the more standard eeprom driver with a userspace decoding
script. More recent versions of the sensors-detect script would suggest
the eeprom driver in this case.

I would tend to agree with you that loading the i2c-matroxfb driver by
default is not a good idea, as this will first load the matroxfb driver
itself, which may cause problems as you experienced. Not everyone wants
a framebuffer console. Ideally, we would only load i2c-matroxfb if
matroxfb itself is already loaded. I have no immediate idea how this can
be done though.

Thanks for the report anyway.
--
Jean Delvare
