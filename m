From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 12 Aug 2007 12:15:27 +0000
Subject: Re: [lm-sensors] dme1737 very slow read...
Message-Id: <20070812141527.097bd969@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <46A8157E.7040003@sandeen.net>
In-Reply-To: <46A8157E.7040003@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark, all,

On Thu, 26 Jul 2007 07:39:58 -0400, Mark M. Hoffman wrote:
> Max rate for standard I2C/SMBus is 100KHz.  However, the hardware which is
> most common on PCs usually runs at something like 10KHz.

Speed which our drivers don't even reach because they don't use
interrupts.

> > > Ok, I thought it might be along those lines.  Is there any other
> > > performance impact to the system while it's waiting for the I2C bus?
> > 
> > Good question, I don't know. That's more a question for the I2C
> > mailing list. Jean?
> 
> It depends on the specific I2C bus driver.  All of the most common ones use
> polling, so unfortunately you will see CPU % go to 100 during that 1.5 sec.

I don't think so. The I2C bus drivers sleep between polls, so most of
the time is spent sleeping. If we were "actively" polling (without
sleeping) it would be much faster, but would indeed suck the CPU time
so we don't do that.

Whoever is really concerned about slow I2C bus speed could spend some
time converting his/her I2C bus driver to use interrupts instead of
polling. I wanted to convert the i2c-i801 driver that way but could
never find the time for it.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
