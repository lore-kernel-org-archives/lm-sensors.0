From: p.koegler@el-me.de (=?iso-8859-1?Q?K=F6gler_Peter?=)
Date: Thu, 19 May 2005 06:25:05 +0000
Subject: i2c_smbus_write_* will never work
Message-Id: <367ED8C46538D7119DAC000A0D106744520D63@elmegmbh.elmedmn.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <367ED8C46538D7119DAC000A0D106744520D5F@elmegmbh.elmedmn.com>
In-Reply-To: <367ED8C46538D7119DAC000A0D106744520D5F@elmegmbh.elmedmn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

hi jean,
can you confirm that i2c_smbus_xfer_emulated is called and not smbus_xfer
when you communicate (see i2c_smbus_xfer) to the chip. 

hi mark,
until now i didn't have the time to test your fix. i will do it the next
days.

wbr
peter



--------------------------------------------------------------
Peter K?gler
EL-ME AG
Gewerbering 1
D-84072 Au i. d. Hallertau

Tel.:     +49 / 8752 / 864 - 527
Fax.:     +49 / 8752 / 864 - 100
mailto.:  p.koegler@el-me.de         
Web:      www.el-me.de
 

-----Original Message-----
From: Jean Delvare [mailto:khali@linux-fr.org]
Sent: Monday, July 12, 2004 11:42 AM
To: sensors@Stimpy.netroedge.com
Cc: K?gler Peter
Subject: Re: i2c_smbus_write_* will never work



>Correction, i2cset can't be used to reproduce the problem because it uses
>i2c-dev.h, not the functions in i2c-core.c.

How does it matter? i2c-dev is just the access point, it has no real
(I2C/SMBus-related) code, has it? So I guess that the commands will end
up in i2c-core, whether they come from a chip driver or i2c-dev. After
all, i2c-dev is nothing but a universal, user-space controllable chip
driver.

>However using admxxxx drivers on a driver with i2c-algo-bit should show the
>problem if it exists.

I did that several times and can confirm it always worked fine. So,
whatever the exact problem is, it's more complex than just "emulated
smbus writes don't work".


Jean Delvare
