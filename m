From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 24 Jun 2005 15:35:18 +0000
Subject: [lm-sensors] [PATCH 2.6.12-rc5-mm2] max6875: new i2c device driver
Message-Id: <gGnTe7JE.1119619845.6187990.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <F06EB2894F3F0D45AD9BEA7246DE9C9076C659@WCSEXCMBS1.ad.wabtec.com>
In-Reply-To: <F06EB2894F3F0D45AD9BEA7246DE9C9076C659@WCSEXCMBS1.ad.wabtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi again Ben,

One more thing about the max6875 driver. After reading the datasheet, I
think I understand that each chip will respond to two I2C addresses
(0x50+0x51 or 0x52+0x53). Your driver should allocate a subclient for
the second address (see the asb100 driver for an example) so as to
prevent another driver (e.g. eeprom) from requesting it and cause a
conflict. Also, this should give you the possibility to improve your
device identification procedure: if the same register or EEPROM location
read from both addresses return different results, this certainly is a
misdetection. And the sole fact of ensuring that the other address is
responsive will avoid some misdetections too.

Thanks,
--
Jean Delvare
