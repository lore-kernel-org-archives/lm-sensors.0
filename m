From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:05 +0000
Subject: i2c_smbus_write_* will never work
Message-Id: <20040709195953.209a42b3.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <367ED8C46538D7119DAC000A0D106744520D5F@elmegmbh.elmedmn.com>
In-Reply-To: <367ED8C46538D7119DAC000A0D106744520D5F@elmegmbh.elmedmn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> seems hard to believe but I think you're right.
> Hopefully somebody on this list can verify 
> (you need a chip on an emulated bus to test, preferably something
> besides an eeprom you don't want to corrupt... Don't think I have
> anything I could test on.) i2cset would be a good tool to test with.
> It's looks to have been broken for years.
> If I don't hear from anybody I'll get brave and test it on my
> DDC monitor eeprom on my voodoo-3 card.

I'm using evaluation boards with various Analog Devices chips over
parallel port. The bus driver being based on i2c-algo-bit, I assume that
it does rely on i2c_smbus_xfer_emulated? And it happens that everything
always worked OK, including writes, so how could there be such an
important bug in there?

-- 
Jean Delvare
http://khali.linux-fr.org/
