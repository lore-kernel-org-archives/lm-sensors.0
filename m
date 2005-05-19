From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:27 +0000
Subject: Via KT600 as I2C controller
Message-Id: <20031129183501.391f4dd1.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031126235249.GA7632@gumby>
In-Reply-To: <20031126235249.GA7632@gumby>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> thanks. would you please download the latest lm_sensors CVS
> and compile the userspace tools with 2.6 support
> (make user and make user_install)
> and use i2cdetect and i2cdump to test the driver.
> use all modes of i2cdump that work (b,w,c,s)
> On a DIMM eeprom, for example, all modes should return the
> same data.

I don't have DIMM eeproms on my i2c-viapro bus, so I tried on an
as99127f. b produces a good dump, c doesn't. The byte at 0x00 (value
0xbd) is repeated everywhere. I guess this is expected because the chip
doesn't have autoincrement? s gave me a kernel panic (stack trashed with
0xbd). w is OK (each byte is repeated twice to form a word).

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
