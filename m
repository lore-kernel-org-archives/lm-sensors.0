From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:05 +0000
Subject: i2c_smbus_write_* will never work
Message-Id: <40F1D727.9000508@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <367ED8C46538D7119DAC000A0D106744520D5F@elmegmbh.elmedmn.com>
In-Reply-To: <367ED8C46538D7119DAC000A0D106744520D5F@elmegmbh.elmedmn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Correction, i2cset can't be used to reproduce the problem because it uses i2c-dev.h, not
the functions in i2c-core.c.
However using admxxxx drivers on a driver with i2c-algo-bit should show the problem if it exists.

Jean Delvare wrote:
>>seems hard to believe but I think you're right.
>>Hopefully somebody on this list can verify 
>>(you need a chip on an emulated bus to test, preferably something
>>besides an eeprom you don't want to corrupt... Don't think I have
>>anything I could test on.) i2cset would be a good tool to test with.
>>It's looks to have been broken for years.
>>If I don't hear from anybody I'll get brave and test it on my
>>DDC monitor eeprom on my voodoo-3 card.
> 
> 
> I'm using evaluation boards with various Analog Devices chips over
> parallel port. The bus driver being based on i2c-algo-bit, I assume that
> it does rely on i2c_smbus_xfer_emulated? And it happens that everything
> always worked OK, including writes, so how could there be such an
> important bug in there?
> 
