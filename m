From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 06 Apr 2011 08:01:36 +0000
Subject: Re: [lm-sensors] [PATCH 1/1] [hwmon] nct1008: Initial NCT1008 driver
Message-Id: <20110406100136.20fcff9e@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1302059183-29631-1-git-send-email-achew@nvidia.com>
	<20110406050929.GA22741@ericsson.com>
	<20110406065048.GA23290@ericsson.com>
In-Reply-To: <20110406065048.GA23290@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: achew@nvidia.com, wni@nvidia.com, w30289@motorola.com, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, olofj@chromium.org, toddpoynor@google.com

On Tue, 5 Apr 2011 23:50:48 -0700, Guenter Roeck wrote:
> On Wed, Apr 06, 2011 at 01:09:29AM -0400, Guenter Roeck wrote:
> > On Tue, Apr 05, 2011 at 11:06:23PM -0400, achew@nvidia.com wrote:
> > > From: Andrew Chew <achew@nvidia.com>
> > >
> > > This is a digital temperature sensor I2C peripheral from ON Semiconductor.
> > >
> > > Signed-off-by: Andrew Chew <achew@nvidia.com>
> > 
> > Comments inline. Note that this is not a complete review.
> > 
> Actually, turns out it would be much simpler to add support for this chip
> to the lm90 driver. It is pretty much identical to ADT7461. Even more
> interesting is that the chip ID is identical to the ADT7461A chip ID.

This isn't exactly surprising, if you consider that Analog Devices sold
part (all?) of its monitoring chip line to On Semi in December 2007:
http://www.analog.com/en/content/Parts_List_Sold_to_On_Semiconductor/fca.html

So NCT1008 is probably just the new name of the ADT7461A and odds are
they are exactly the same chip.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
