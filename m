From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 12 May 2010 07:27:15 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (tmp421) Add nfactor support.
Message-Id: <20100512092715.12639dcf@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4BE81B7B.7010804@theptrgroup.com>
	<20100511190327.GA2031@andre-laptop>
	<4BE9B145.7000702@theptrgroup.com>
In-Reply-To: <4BE9B145.7000702@theptrgroup.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jeff Angielski <jeff@theptrgroup.com>
Cc: lm-sensors <lm-sensors@lm-sensors.org>, Linuxppc-dev@lists.ozlabs.org, Andre Prendel <andre.prendel@gmx.de>

Hi Jeff,

On Tue, 11 May 2010 15:34:29 -0400, Jeff Angielski wrote:
> On 05/11/2010 03:03 PM, Andre Prendel wrote:
> > I'de prefer implementing the sysfs access methods in a consistent way (see other functions). That means adding the nfactor register to the tmp421_data structure and using tmp421_update_device() to update the structure.
> 
> I did this on purpose since the nfactor typically only changes once at 
> runtime when you program it for your sensor.  It seemed like a waste of 
> processing power and i2c bandwidth to read a "pseudo static" register 
> over and over again.
> 
> It can easily be changed if that's what will help the community the best.

I get your point and it makes sense. However, we also have to ensure
that no regular user can saturate the I2C link by repeatedly polling
for the same register value. So, any sysfs attribute which triggers an
immediate I2C transaction shouldn't be accessible by regular users
(i.e. change the mode from 0644 to 0640).

An alternative is to slit the cache into short-lived (~ 1 or 2 seconds)
and long-lived (1 to 5 minutes.) A number of drivers do this.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
