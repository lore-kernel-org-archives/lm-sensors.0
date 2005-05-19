From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:30 +0000
Subject: fan speeds and temps no reading
Message-Id: <qEHOc0gR.1105696557.6106170.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <1104907933.3003.195.camel@tooheys.tnsa.com.au>
In-Reply-To: <1104907933.3003.195.camel@tooheys.tnsa.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Mark,

I'm admittedly surprised by the dump, as all registers in the 0xF0-0xF7
range are set to 0xFF while the datasheet mentions default values of
0x00 for most. We might assume that the datasheet is wrong and continue,
but this still worries me.

isaset -y -f 0x2e 0x87
isaset -y -f 0x2e 0x87
isaset -y 0x2e 0x2f 0x07 8
isaset -y 0x2e 0x2f 0xf2 0xe7
isaset -y 0x2e 0x2f 0xf0 0xe7

At this point you can modprobe i2c-i801 if you didn't already. Then do
"i2cdetect -l" to get the id of the i801 bus (most probably 0 or 1)
and do "i2cdetect 0" or 1 or whatever number the i801 bus id is. See
if any new device appeared especially in the 0x28-0x2f range.

If nothing showed, try:
isaset -y 0x2e 0x2f 0xf1 0xef

And try i2cdetect again. If still nothing:

isaset -y 0x2e 0x2f 0xf1 0xf7

And try i2cdetect again. If still nothing:

isaset -y 0x2e 0x2f 0xf1 0xe7

And i2cdetect again. If still nothing we have lost :( so let's just hope
that one of the i2cdetect above found something.

Finally release the super-io chip with:
isaset -y -f 0x2e 0xaa

Thanks,
--
Jean Delvare
