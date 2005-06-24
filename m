From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 24 Jun 2005 11:29:37 +0000
Subject: [lm-sensors] [PATCH 2.6.12-rc5-mm2] max6875: new i2c device driver
Message-Id: <Ueq8Becy.1119605100.8733560.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <F06EB2894F3F0D45AD9BEA7246DE9C9076C659@WCSEXCMBS1.ad.wabtec.com>
In-Reply-To: <F06EB2894F3F0D45AD9BEA7246DE9C9076C659@WCSEXCMBS1.ad.wabtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Ben,

> I had to write a tool to program the device anyway, so it would be
> trivial to use i2c-dev instead of the sysfs files.
>
> Would it be acceptable to axe register access entirely and only provide
> an interface to the user EEPROM?
> I would be happy with read-only access to the EEPROM.

Yup, sounds sane to me. This will make the driver much more simple and
smaller, which can't hurt.

Thanks,
--
Jean Delvare
