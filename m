From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 28 May 2013 11:35:27 +0000
Subject: Re: [lm-sensors] W83L786G not detected on vx800
Message-Id: <20130528133527.5b666c96@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20130524085927.6f646a4d@endymion.delvare>
In-Reply-To: <20130524085927.6f646a4d@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Richard,

On Fri, 24 May 2013 08:28:40 -0700, rh wrote:
> On Fri, 24 May 2013 08:59:27 +0200
> Jean Delvare <khali@linux-fr.org> wrote:
> > On Fri, 24 May 2013 03:21:29 -0700, rh wrote:
> > > # sensors-detect revision 6085 (2012-10-30 18:18:45 +0100)
> > > # System: VIA Technologies Ltd. VX800 [1.0]
> > > (...)
> > > Next adapter: SMBus Via Pro adapter at 0500 (i2c-3)
> > > Do you want to scan it? (YES/no/selectively): 
> > > Client at address 0x2f can not be probed - unload all client
> > > drivers first!
> > 
> > This is your W83L786G chip. sensors-detect would tell you if the
> > driver was built as a module rather than embedded in the kernel.
> > 
> > I have improved sensors-detect so that it can handle monolithic
> > kernels better. Please give it a try and report the output:
> >   http://khali.linux-fr.org/devel/lm-sensors/sensors-detect
> 
> I tried this and sensors-detect produces the same output.

I tested it myself and it doesn't produce the exact same output for me.
The new script properly reports that the busy I2C address has a
built-in driver attached and it reports that driver's name (which in
most cases matches the module name.)

This could be improved by remembering this finding and using it when
later presenting the summary, but I don't really have the time for that
right now.

> It seems I don't need to rely on sensors-detect though and
> need to find out why pwmconfig cannot control the fans.

That's right, once you have the right modules built-in, sensors-detect
is almost useless, except for distributions which will not start
dependent services (e.g. sensord or fancontrol) if the configuration
file is missing. But anyway, once you go for a monolithic kernel you
are moving away from the distribution and must be ready to experience
some hiccups.

> But it's another guess. I did see that in the 3.9.2 kernel there's
> a separate flag for PWM that I had never noticed before. I think
> it's new. I checked the box for that.

This is unrelated. The new PWM "subsystem" is essentially used on
embedded systems, hwmon drivers aren't using it (yet.)

> I just want to have fan control and it seems all the pieces are there
> but something's missing.  It could be PEBKAC but I've looked at a
> lot of stuff....the vx800 spec, the W83l786NG,NR,G,R datasheets,
> linux/Documentation/hwmon, thermal, etc., etc.

The W83L786* chips aren't very popular, I don't think the driver
received too much testing and fan control is the last part of hwmon
driver to receive proper testing coverage. So it is entirely possible
that there is a bug remaining in this area of the driver.

If you share the output of pwmconfig, it will be easier for us to help
you. You said it didn't work, but we have no idea how it failed exactly.

> Thanks for lm-sensors! And thanks for taking the time to reply.

You're welcome.
-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
