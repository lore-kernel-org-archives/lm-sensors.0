From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 23 Mar 2006 20:52:08 +0000
Subject: [lm-sensors] [PATCH 1/1] i2c: m41txx driver for ST i2c RTC chips
Message-Id: <20060323215208.2486cccf.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060217011359.GA16247@mag.az.mvista.com>
In-Reply-To: <20060217011359.GA16247@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > I still have a problem with your patch (sorry). It's really doing to
> > many things at once. Namely, it adds support for new chips, converts
> > from tasklet to workqueue, cleans up a few things (e.g. BIN2BCD instead
> > of BIN_TO_BCD, which is a good move), and also includes some whitespace
> > changes (some of which is NOT OK, please don't attempt to align equal
> > signs with spaces in regular code!)
> 
> You mean things like the following?
> 
> 	sec  =  buf[m41t00_chip->sec]  & 0x7f;
> 	min  =  buf[m41t00_chip->min]  & 0x7f;
> 	hour = buf[m41t00_chip->hour]  & 0x3f;
> 
> I just want to make sure I change the right code.

Yes, this is the kind of thing I was referring to.

Thanks,
-- 
Jean Delvare

