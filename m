From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:17 +0000
Subject: Data block transactions fail on i2c-i801 controller?
Message-Id: <20040923074637.M14797@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <13938324.1095712833883.JavaMail.root@scooter.psp.pas.earthlink.net>
In-Reply-To: <13938324.1095712833883.JavaMail.root@scooter.psp.pas.earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 22 Sep 2004 18:16:11 -0400, Mark M. Hoffman wrote
> The i2c-i801 driver has *major* brain damage w.r.t. block xfers. 
>  What I *expected* to see in your logs was a timeout of some sort,
> indicating that the bus was not resetting properly after a xfer.
> 
> Not even close: the bus driver is actually performing a whole block xfer
> once for each byte!!!  Seeing this, I wouldn't be suprised to find 
> out that you are the very first user of that function, ever.  I am honestly
> amazed that it works at all.
> 
> So I understand what needs to be done, but actually fixing it is not
> high on my list just now - especially since you have a workaround
> (disable_block=1).
> 
> One reason this will take some time is that this driver supports several
> different chipsets.  Apparently some of them have a block xfer buffer
> and some don't; I would have to read through ~5 chipset datasheets to
> sort it out.  This is one reason I was hoping the original authors would
> get involved.

I am not the original author but a user of the i2c-i801 driver. My laptop has
an ICH3-M chip on-board. It has a couple EEPROMs attached, with which I have
been playing a lot at some time. It seemed to work well, and I think that the
eeprom driver uses block transfer when available. I may do any kind of test on
my chip, either with the current 2.4 and 2.6 drivers or with patches from you
applied, you just have to ask.

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/
