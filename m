From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:17 +0000
Subject: Ticket #: 1737
Message-Id: <20040928205345.68ce687d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1096310877.11070.6.camel@drevil.aslab.com>
In-Reply-To: <1096310877.11070.6.camel@drevil.aslab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Hi,
> 
> Yes, upon inspecting the motherboard there is a W83792D chip.  In
> addition, there is also a W83791SD device.

From the datasheet, the W83791SD *seems* to be a speech synthetizer. The
datasheet is complete crap though, obviously ripped from another one,
maybe W83791D, and thus incorrectly labelled "H/W Monitoring IC". It
even fails to give the I2C address (it only mentions that 4 different
addresses can be chosen). You have some unknown devices on your SMBus,
it might be one of these.

> Can you tell from the i2c
> dump what the chip ID for the W83792D is?  I can try adding it to the
> w83781d driver and see if I get lucky. :-)  

ID is 0x72 at register 0x58.

BTW, I just added detection of the W83792D to sensors-detect.

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/
