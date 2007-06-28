From: "Juerg Haefliger" <juergh@gmail.com>
Date: Thu, 28 Jun 2007 22:00:52 +0000
Subject: Re: [lm-sensors] dme1737 / sch311x hybrid driver
Message-Id: <191fb4ca0706281500t21f8e01by50002f035869486d@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0706281128l75612b36t7da3a07b4a5b73e8@mail.gmail.com>
In-Reply-To: <191fb4ca0706281128l75612b36t7da3a07b4a5b73e8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On 6/28/07, Hans de Goede <j.w.r.degoede@hhs.nl> wrote:
> Juerg Haefliger wrote:
> > Hi all,
> >
> > I was playing around with adding support for the sch311x to the
> > dme1737 driver but I'm not so sure anymore how to go about it. For
> > those unfamiliar with the 2 chips, both chips implement the same
> > (almost but very close) HW monitoring capabilities but the dme1737
> > only allows access via SMBus while the sch311x only supports the LPC
> > interface. There are multiple ways to go about this:
> >
> > 1) 2 separate drivers. An i2c driver for the dme1737 and a platform
> > driver for the sch311x. They would only differ in the way they access
> > the HW, all the rest would be identical and could be shared.
> >
> > 2) 1 single driver that either registers itself as an i2c client or a
> > platform driver, depending on which chip is detected.
> >
> > 3) 1 single driver that registers itself as an i2c client independent
> > of the chip found.
> >
> > While option 1) would be preferred, I kind of shy away from the amount
> > of work/changes necessary to implement it. I started of with option 2)
> > but it turned out to be bigger than expected. Lots of code for
> > registering/adding the platform stuff to support a chip that doesn't
> > seem to be very popular. It blows up the code and makes it pretty
> > ugly. I'm almost tempted to go with option 1)...
> >
> > Not sure if option 3) is feasible. Sounds a little bit hacky and I
> > don't know if it's even possible to register a 'bogus' i2c client or
> > if it would break something somewhere that I'm not aware of.
> >
> > Oh and option 2) and 3) of course require an i2c bus driver to be
> > present and loaded. So in case someone has a system with a sch311x
> > that doesn't have a supported i2c controller, he/she couldn't load the
> > dme1737 driver... Not very nice...
> >
> > Does anybody have any suggestions or comments or other ideas?
> >
>
> While I was looking at writing a driver for an intel motherboard superio chip
> some time ago, I had the same problem, since this superio chip could be
> connected to either smbus or LPC. I then came up with the plan to first probe
> through LPC and then depending on the configuration (which can always be read
> through LPC in this case) register either an platfrom or a i2c client driver
> and matching device. Won't that work here?

Well yes it would. That's in fact what I started doing. I just think
it's kind of ugly to have 2 sets of device register/unregister methods
in a single driver. I thought I'd run it by the list before spending
more time on it.

...juerg


> Regards,
>
> Hans
>
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
