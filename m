From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 18 Aug 2014 03:07:17 +0000
Subject: Re: [lm-sensors] power supply gating with ltc2978
Message-Id: <20140818030717.GA5131@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <alpine.DEB.2.02.1408151623140.21645@atx-linux-37>
 <20140816132050.GH28623@sirena.org.uk>
In-Reply-To: <20140816132050.GH28623@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@kernel.org>
Cc: atull <atull@opensource.altera.com>, Jean Delvare <jdelvare@suse.de>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>

On Sat, Aug 16, 2014 at 02:20:50PM +0100, Mark Brown wrote:
> On Fri, Aug 15, 2014 at 04:34:49PM -0500, atull wrote:
> 
> > I am interested in adding functionality to be able to gate power supplies 
> > going through a ltc2978.  I see that there is a hwmon driver already 
> > existing (hwmon/pmbus/ltc2978.c).  I see some of the other hwmon drivers 
> > have MFD's.  It looks like this ltc driver would need a MFD and a 
> > regulator driver added.  However I don't see other pmbus hwmon drivers
> > using MFD.
> 
> > So I am asking for recommendations and reservations on how to proceed here 
> > before I get too far with this.
> 
> Without knowing anything at all about pmbus or this particular hardware
> it's hard to comment but what you're saying here sounds sensible (though
> I do see that apparently splitting the drivers may not actually be
> sensible from Guenter's followup).

I had originally thought about converting the pmbus drivers to mfd with client
drivers, but I concluded that it would add a lot of complexity with little gain.
It makes sense to separate a driver into mfd and a number of client drivers
if a device has clear functional blocks for the different devices it supports.
With PMBus, this is not the case. Separating a PMBus driver would be a purely
artificial costruct, and there would be overlapping functionality. Separating
just a single driver out of the group of PMBus drivers, as seems to be suggested
above, makes even less sense as one simply can not separate the core PMBus
driver code from its front-end drivers.

On the other side, adding regulator support into the PMBus driver code would
make a lot of sense. It should also be quite straightforward.

Or anyway that is my opinion. If someone wants to spend the time and separate
the PMBus drivers into an MfD part and hwmon and regulator client drivers, I'll
be happy to look at the resulting patch set.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
