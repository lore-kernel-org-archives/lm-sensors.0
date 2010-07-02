From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 02 Jul 2010 09:53:45 +0000
Subject: Re: [lm-sensors] Driver for MAX6696 temperature sensor
Message-Id: <20100702115345.64e18adc@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100701011831.GA6915@ericsson.com>
In-Reply-To: <20100701011831.GA6915@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Fri, 2 Jul 2010 01:38:30 -0700, Guenter Roeck wrote:
> On Fri, Jul 02, 2010 at 03:52:04AM -0400, Jean Delvare wrote:
> > Hi Guenter,
> > 
> > On Thu, 1 Jul 2010 18:17:24 -0700, Guenter Roeck wrote:
> > > On Thu, Jul 01, 2010 at 11:05:01AM -0400, Jean Delvare wrote:
> > > > On Thu, 1 Jul 2010 07:52:44 -0700, Guenter Roeck wrote:
> > > > > I implemented a prototype last night. It adds about 130 lines of code, and changes about 20.
> > > > > A few things like chip detection are still missing, so it will probably end up adding
> > > > > maybe 150 lines of code.
> > > > 
> > > > Seems reasonable. And maybe another pair of eyes who know the lm90
> > > > driver well will have suggestions to make it even smaller :)
> > > 
> > > Agreed.
> > > 
> > > Followup question: The chip supports three limits per sensor - ALERT, OT1, and OT2.
> > > Default settings are along the line of 70, 90, and 120 degrees C. OT2 typically causes
> > > a board shutdown.
> > > 
> > > Current API only allows for two limits, so I am using ALERT for min/max, OT1 for crit,
> > > and ignore OT2. Any idea if/how we could report OT2 as well ?
> > 
> > I have no objection adding another limit to the sysfs-interface. I seem
> > to recall that a few other thermal sensors would benefit from it.
> > 
> > Could take the form of temp[1-*]_warn or temp[1-*]_crit2 (or any other
> > suggestion you may have). The w83795 driver I'm currently working on
> 
> temp[1-*]_crit2 would probably be a better fit. "warn" doesn't seem right
> for a temperature causing a board reset.

Of course it really depends on what each limit does. "warn" would
probably be the lowest high limit, only warning the user / admin that
some action will be taken later if the temperature keeps raising.

Maybe temp[1-*]_emergency would be better than temp[1-*]_crit2?

> > has temp5_warn and temp6_warn. The values are lower than the ones in
> > temp5_max and temp6_max, respectively, so it seems different from your
> > own case. I'll check the register descriptions.
> > 
> > Note that our decision might change the pertinence of adding support
> > for the MAX6696 to the lm90 driver.
> 
> Code would not have to change much, though. All I have to add is some code to 
> read the additional registers, and add three more sysfs attributes for the _crit2
> temperatures. Since I already added several attributes for the third sensor, 
> this is not much additional change.

OK, alright then.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
