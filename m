From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 05 Jun 2008 16:32:39 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] lm87: Convert into a new-style driver
Message-Id: <20080605183239.37ee41a7@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080604184401.GG11300@solarflare.com>
In-Reply-To: <20080604184401.GG11300@solarflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 5 Jun 2008 16:12:16 +0100, Ben Hutchings wrote:
> Jean Delvare wrote:
> > Same is true of every hardware monitoring in every system. If the user
> > doesn't care about the limits, why should you care for him/her?
> 
> If I remember correctly, the lm-sensors drivers were written for sensors
> that were on PC motherboards and already used and initialised by the BIOS.
> It appears to me that the lm87 driver at least still assumes this as the
> normal cases.  For example, it absolutely requires that the channel
> register is set correctly before it is bound to the device.

That's partly correct. The drivers were originally written for
sensors on PC motherboards, and they assume some initialization done
by the BIOS, but also expect missing initialization. lm87_init_client()
clearly shows this, if the chip is already running we assume that the
limits are already set, if not, as we know that the LM87 doesn't
initialize these register to sane values, we reset them all (that's
what would happen in your case I guess.)

For the channel register you are correct, and this one makes full sense
to have in platform_data in your case.

> So usually there is little need for initialisation by the hardware monitor
> driver or the user.  Advanced users can tweak the limits as they see fit,
> but most users will be happy with the firmware defaults.

It really depends on the board. A few boards initialize the limits
properly, but in general the user really wants to set them, or he/she
gets either spurious alarms or no alarms at all.

> But in the absence of firmware to initialise the limits, this falls apart.

Why? In general, the limits and the alarms are informative only, and
nothing bad will happen if the limits aren't set immediately. So,
user-space has all the time to set the limits after the driver has been
loaded. All that matters is that the limits are set before the user
gets a chance to look at them.

> > The standard way of proceeding would be to provide libsensors
> > configuration files for your network adapters, and users who care about
> > proper sensor labelling and limits, will download and install them on
> > their systems. We plan to automatize the process a bit in the future
> > but this isn't done yet.
> 
> We could probably provide these in driver RPMs, but that doesn't really
> help people getting the in-tree driver.  It seems to me that platform_data
> is exactly the right place to put such information.

You could make the configuration files available for download from your
web site directly (it really makes no sense to put these in RPMs), or
just ask for a wiki account on lm-sensors.org and upload them there.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
