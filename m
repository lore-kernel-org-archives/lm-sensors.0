From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 01 Jul 2010 15:05:01 +0000
Subject: Re: [lm-sensors] Driver for MAX6696 temperature sensor
Message-Id: <20100701170501.5513e262@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100701011831.GA6915@ericsson.com>
In-Reply-To: <20100701011831.GA6915@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 1 Jul 2010 07:52:44 -0700, Guenter Roeck wrote:
> On Thu, Jul 01, 2010 at 02:33:11AM -0400, Jean Delvare wrote:
> > Hi Guenter,
> > 
> > On Wed, 30 Jun 2010 18:18:31 -0700, Guenter Roeck wrote:
> > > one of the hwmon drivers I'll have to write is for MAX6696. This chip is similar to lm90 / max6680,
> > > only it supports three temperature sensors instead of two. The two external sensors share one
> > > set of registers.
> > 
> > How does it work exactly?
> > 
> Setting Command register bit 3 switches the limit and temperature registers to the
> second external channel, and there is a second status register for its status bits.

I see. strange approach, I wonder why they did it that way.

> > > What is the better approach - write a new driver based on the lm90 driver,
> > > or modify the lm90 driver to support max6696 and thus optionally three channels ?
> > > Any thoughts ?
> > 
> > Both are acceptable. Best choice depends on how intrusive it is to add
> > support to the lm90 driver. I suspect there won't be too much to add? I
> > would recommend trying it, and if we finally decide it's too intrusive,
> > copy the lm90 driver to a new one and clean up them both.
> > 
> I implemented a prototype last night. It adds about 130 lines of code, and changes about 20.
> A few things like chip detection are still missing, so it will probably end up adding
> maybe 150 lines of code.

Seems reasonable. And maybe another pair of eyes who know the lm90
driver well will have suggestions to make it even smaller :)

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
