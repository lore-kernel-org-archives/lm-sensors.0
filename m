From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 13 Jun 2005 12:25:13 +0000
Subject: [lm-sensors] w83781d.o: Subclient 0 registration at address 0x49
Message-Id: <UA4A0pQj.1118657716.3969220.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <2ef564dc05061302175b8427fd@mail.gmail.com>
In-Reply-To: <2ef564dc05061302175b8427fd@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Sukhdeep,

> The chip is W83697F - that's what written on the chip.

This chip doesn't have hardware monitoring capabilities. So the values
you get may be from a different chip.

> I think it's the W83697_T_H_F chip..

I don't think so. The only THF chip is the the W836_2_7THF, as least as
far as I know.

> Is W83697_THF also ISA-only ?

All W826x7 chips are Super-I/O chips, so they do at least have ISA
access, which is better anyway. I think only the older W83627HF chip has
I2C access in addition.

What motherboard is it?

Please provide the full output of sensors-detect. Don't forget to unload
the w83781d driver beforehand (or any other i2c chip driver).

--
Jean Delvare
