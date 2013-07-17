From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 17 Jul 2013 09:11:44 +0000
Subject: Re: [lm-sensors] [PATCH v3 1/4] hwmon: (lm90) split set&show temp as common codes
Message-Id: <20130717111144.491e9958@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1373615287-18502-1-git-send-email-wni@nvidia.com>
	<1373615287-18502-2-git-send-email-wni@nvidia.com>
	<20130712152615.23464a6b@endymion.delvare>
	<20130712135000.GA3386@roeck-us.net>
	<20130712163034.1fc1cd66@endymion.delvare>
	<20130712144011.GC3629@roeck-us.net>
	<51E395D9.6070000@nvidia.com>
	<20130715092415.6d082aa2@endymion.delvare>
	<20130717042618.GA11359@mithrandir>
	<20130717051409.GA16413@roeck-us.net>
	<51E6392E.5080906@nvidia.com>
In-Reply-To: <51E6392E.5080906@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wei Ni <wni@nvidia.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Thierry Reding <thierry.reding@gmail.com>, rui.zhang@intel.com, lm-sensors@lm-sensors.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org

On Wed, 17 Jul 2013 14:26:54 +0800, Wei Ni wrote:
> On 07/17/2013 01:14 PM, Guenter Roeck wrote:
> > On Wed, Jul 17, 2013 at 06:26:20AM +0200, Thierry Reding wrote:
> >> On Mon, Jul 15, 2013 at 09:24:15AM +0200, Jean Delvare wrote:
> >>> On Mon, 15 Jul 2013 14:25:29 +0800, Wei Ni wrote:
> >>>> I think we can decide it in the DT, we can add a dt property in the lm90
> >>>> device node, such as:
> >>>> sys-interface = SYS_HWMON;
> >>>> or
> >>>> sys-interface = SYS_THERMAL;
> >>>> So we register it as the hwmon or thermal device
> >>>
> >>> This is an option, but please keep in mind that DT is not the only way
> >>> to instantiate LM90-like devices, and we should not expose duplicate
> >>> inputs by default. It is fine with me if the default is to create only a
> >>> HWMON device (as the lm90 driver was doing so far), and only
> >>> DT-instantiated devices have the choice.
> >>
> >> I don't think this information belongs in the device tree. Whether the
> >> device is exposed as hwmon or thermal device (or both) is entirely a
> >> software issue whereas DT is a means to describe the hardware.
> >>
> > Correct; this is exactly the type of information which does _not_ belong int
> > devicetree.
> > 
> >> It seems to me that the earlier proposal of communicating to the bridge
> >> whether or not a device should be exposed as hwmon device is the right
> >> thing to do here.
> >
> > Agreed..
> 
> Sorry, what's the "bridge" mean,

The code which creates a virtual hwmon input when a new thermal zone is
registered (this code is in thermal_core.c.)

> does it mean we need to add a flag in
> the thermal_zone_device_register() to indicate if we want to register
> virtual hwmon device or not?

I think so, yes.

Alternatively the flag could be added to struct
thermal_zone_device_ops, so that you don't have to update all the
callers. But I admit it's a hack as the flag doesn't really belong
there, so I suppose we don't really want to do that.

I have been thinking of an automatic approach, based on comparing the
type string passed to thermal_zone_device_register() with already
registered hwmon devices, but I couldn't come up with something good
and robust enough, so let's forget about it.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
