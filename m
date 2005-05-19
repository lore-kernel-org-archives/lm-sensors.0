From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:43 +0000
Subject: via686a on I2C
Message-Id: <403A0462.7010806@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040217230608.31c66662.khali@linux-fr.org>
In-Reply-To: <20040217230608.31c66662.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

one problem with adding i2c support to via686a in 2.6 is that it's a PCI module
so you'd still have the driver conflict problem.

You'd have to delay PCI module registration, or else do a separate driver.

Where is the i2c address for the via686a set?
couldn't find it in the docs.

Jean Delvare wrote:
> Hi all,
> 
> FYI, I just solved the mystery of lm80 being misdetected on systems
> where the via686a driver is used and works. It happens that the via686a
> chip can *also* be accessed on the I2C bus. Alex van Kaam just told me
> about that, he was aware of that for some times already.
> 
> We might consider adding some code in sensors-detect to say we detected
> something there. That said, the via686a as an i2c chip isn't necessarily
> very easy to detect. I'll take a look and do what I can.
> 
> Do we want to add i2c support to the existing via686a driver? Doesn't
> seem to be necessary since I can't imagine that the chip would be seen
> on i2c and not available on isa. Still something to consider is someone
> doesn't want to use i2c-isa for some reason. Also, since via686a and
> i2c-viapro are not compatible in Linux 2.6, having a way to access the
> via686a through i2c-viapro may have an interest.
> 
