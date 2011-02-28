From: Lucas Stach <dev@lynxeye.de>
Date: Mon, 28 Feb 2011 23:24:37 +0000
Subject: Re: [lm-sensors] hwmon API update
Message-Id: <1298935477.5974.32.camel@workstation>
List-Id: <lm-sensors.vger.kernel.org>
References: <4D57CC24.1040306@free.fr>
In-Reply-To: <4D57CC24.1040306@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Am Montag, den 28.02.2011, 10:42 -0800 schrieb Guenter Roeck:
> On Mon, Feb 28, 2011 at 12:50:45PM -0500, Lucas Stach wrote:
> > Hello all,
> >  
> > let me revive this discussion a bit. After reading some things about the
> > matter I think the way to go is to use Intels thermal framework. It
> > should be easy to add the needed temp_get and fan_set functions to the
> > affected hwmon drivers. 
> > 
> > But then one problem still persists: when the hwmon driver probes a
> > device it automatically creates the sysfs entries. This is unintended
> > behaviour from nouveau's point of view. The sensor value is not the real
> > temperature value; it has to be scaled with some factor and an offset
> > hard-coded in the video bios tables. This scaling could only be done on
> > nouveau's side, so the hwmon driver is exposing an interface with wrong
> > values to the userspace.
> > 
> > We need a way to use the hwmon i2c driver without exposing this
> > interface. Do you have any preferred way how we could achieve this?
> > 
> The whole point of the hwmon subsystem is to expose hardware monitoring
> attributes to userspace. A hwmon driver without sysfs attributes does not
> make sense.
> 
> Guenter

I see your point. So the best way to move forward is to write a separate
module which exposes the thermal framework API and duplicate the needed
code.

Who does the review for thermal api drivers? I remember some discussion
about the Intel medfield driver which landed in the platform directory,
but I think a driver like the one for adt747x has to go
to /drivers/thermal where I couldn't find a maintainer. Could you give
me some hint here?

--Lucas
> 
> > I see two ways to do this:
> > 1. Sort out if we need the sysfs entries in the probe function. This
> > could be done with some name postfix in the board_info. Downside: adds
> > some noise to this function.
> > 
> > 2. Creating a new module which only exposes the thermal framework API.
> > This leads to code duplication and we end up with two drivers for the
> > same i2c monitoring chip. On the other hand this _could_ lead to cleaner
> > code and we could move this part to drivers/thermal instead of
> > drivers/hwmon. I don't like the code duplication, do you see any chance
> > to avoid this in case this is the way to go?
> > 
> > Please comment on my thoughts, we need your feedback to bring up an API
> > everyone could agree on. I'm willing to hack together a prototype over
> > the next week, but want to avoid running in a completely wrong
> > direction.
> > 
> > -- Lucas



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
