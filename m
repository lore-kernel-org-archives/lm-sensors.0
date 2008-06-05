From: Ben Hutchings <bhutchings@solarflare.com>
Date: Thu, 05 Jun 2008 15:12:16 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] lm87: Convert into a new-style driver
Message-Id: <20080605151215.GN11300@solarflare.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080604184401.GG11300@solarflare.com>
In-Reply-To: <20080604184401.GG11300@solarflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> On Thu, 5 Jun 2008 15:23:19 +0100, Ben Hutchings wrote:
> > Jean Delvare wrote:
> > > What bad will happen if the limits are only initialized a few seconds
> > > or minutes after the driver is loaded?
> > 
> > My point is that I don't see that they are ever likely to be initialised.
> > They can be set through sysfs, but unless this is automated in some standard
> > way then almost no-one will actually go to the trouble of doing it.
> 
> Same is true of every hardware monitoring in every system. If the user
> doesn't care about the limits, why should you care for him/her?

If I remember correctly, the lm-sensors drivers were written for sensors
that were on PC motherboards and already used and initialised by the BIOS.
It appears to me that the lm87 driver at least still assumes this as the
normal cases.  For example, it absolutely requires that the channel
register is set correctly before it is bound to the device.

So usually there is little need for initialisation by the hardware monitor
driver or the user.  Advanced users can tweak the limits as they see fit,
but most users will be happy with the firmware defaults.

But in the absence of firmware to initialise the limits, this falls apart.

> The standard way of proceeding would be to provide libsensors
> configuration files for your network adapters, and users who care about
> proper sensor labelling and limits, will download and install them on
> their systems. We plan to automatize the process a bit in the future
> but this isn't done yet.

We could probably provide these in driver RPMs, but that doesn't really
help people getting the in-tree driver.  It seems to me that platform_data
is exactly the right place to put such information.

Ben.

-- 
Ben Hutchings, Senior Software Engineer, Solarflare Communications
Not speaking for my employer; that's the marketing department's job.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
