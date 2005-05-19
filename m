From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:46 +0000
Subject: non-sensors i2c chip drivers
Message-Id: <20040306231034.469fef54.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

There are a number of i2c chip drivers that are not sensors related. A
first example of this is eeprom, which is already in 2.6. I can think of
at least four other drivers in the same case: ddcmon, bt869, pcf8574 and
pcf8591. What do we want to do with these? Two points to be discussed:
physical location in the source tree, and position in the kernel
configuration menu.

I think that it would make sense to have a specific menu entry for
these, separate from the sensors stuff. Looks like an easy thing to do.

As for the physical location, we have a single "chips" directory and I
think it can stay that way.

What do you think?

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
