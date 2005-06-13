From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 13 Jun 2005 11:44:56 +0000
Subject: [lm-sensors] w83781d.o: Subclient 0 registration at address 0x49
Message-Id: <ar2DskX7.1118655290.4415460.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <2ef564dc05061302175b8427fd@mail.gmail.com>
In-Reply-To: <2ef564dc05061302175b8427fd@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Sukhdeep,

> I am using the chip W83697F chip.

I assume W83697_H_F?

> I am getting this error when loading the w83781d driver.
> w83781d.o: Subclient 0 registration at address 0x49 failed

This is quite strange, the W83697HF is an ISA-only chip, so it isn't
supposed to have subclients. Which version of lm_sensors are you using?
On which kernel?

> I have tried  modprobe w83781d init=0 force_subclients=0,0x2c,0x4a,0x4b
> without any succes..

Which isn't surprising, as force_subclients only works for I2C chips,
not ISA ones.

> Can you please provide some insights.. I have run out of options :(

Please try the w83627hf driver instead. The support of ISA-only chips in
the w83781d driver is deprecated and will be removed soon.

--
Jean Delvare
