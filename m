From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 06 Sep 2005 09:31:19 +0000
Subject: [lm-sensors] Random values with pcf8591 chip driver
Message-Id: <oCytQmgf.1125991373.8376100.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Mirko,

[Mirko Buholzer]
> The pcf8591 is the only chip. When I do a "i2cdetect 1" and change the
> hardware address from 100 to 000 you can see the output below (The UU
> value comes from the loaded chip driver), so for me it looks like a
> detected chip?

Yes, you are right, this would suggest that the bus driver is OK.

BTW, you should never change the address of the PCF8591 chip while the
driver is loaded, as the driver won't notice and strange things will
happen.

Anyway, this probably means that your PCF8591 is either not properly
wired or incorrectly configured, as Aurelien Jarno suggested elsewhere.

--
Jean Delvare
