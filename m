From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 02 Feb 2009 08:37:49 +0000
Subject: Re: [lm-sensors] ACPI versus native IC drivers
Message-Id: <20090202093749.27627445@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <495D3E83.8040003@redhat.com>
In-Reply-To: <495D3E83.8040003@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Luca, Hans,

Sorry for joining in a little late...

On Sun, 4 Jan 2009 15:06:43 +0100, Luca Tettamanti wrote:
> On Thu, Jan 1, 2009 at 11:06 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> > Hi all,
> >
> > I've made a good start with reviewing the new ATK0110 driver. And I must say I
> > like it. But, there is a big but.
> >
> > On my Asus M2N SLI Deluxe motherboard, with this driver loaded the two hwmon
> > IC's on this board (one superio, one smbus) get hit by both the ACPI and native
> > driver code. This is bad, really bad!
> 
> Old news :S
> http://thread.gmane.org/gmane.linux.drivers.sensors/12454
> http://thread.gmane.org/gmane.linux.drivers.sensors/12359
> I actually started writing the ATK driver in response to that thread.
> 
> > Luckily I can fix this by:
> > 1) Using Jean's queued patch for adding acpi resource checks to superio drivers
> > from here:
> > http://khali.linux-fr.org/devel/linux-2.6/jdelvare-hwmon/hwmon-acpi-check-conflict.patch
> >
> > 2) Specifying: "acpi_enforce_resources=strict" on the command line
> >
> > With this, the native drivers will no longer load. As we have no idea what the
> > ACPI code is doing (it might be updating the readings periodically based on a
> > timer for all we know). To me this (causing the native drivers to no longer
> > load) seems to be the right solution.
> 
> Agreed. Note that since the firmware thinks it owns the hardware it
> may access it even without a specific driver loaded (e.g. in the
> thread linked above I think that the native driver was interfering
> with the standard TZ polling.)

Yes, that's true.

> > Back on topic, there is one big "but" here. If we change the default setting
> > for acpi_enforce_resources to strict, then this will cause problems for people,
> > and those problems will get seen as regressions. For example many asus users
> > will stop having functional sensors (atleast in my asus board ACPI claims the
> > relevant resources for accessing the sensors). Still I think we should make the
> > default strict, as that seems the right thing to do. As this is an option
> > people can always change the option as a work around if this causes too much pain.
> >
> > Making this option strict by default is the only safe way I see for ever
> > allowing the atk0110 driver in to the mainline kernel.
> 
> Actually the use of native drivers might already be unsafe... I agree
> on changing acpi_enforce_resources to strict; the transition shouldn't
> be too painful: ACPI drivers are loaded automagically, so the existing
> monitoring software will "just work".

The real world is more complex than that. For one thing, switching from
a native hardware monitoring driver to an ACPI hardware monitoring
driver isn't a transparent operation. Monitoring applications need a
way to identify each sensor and this is based on the device name
string, which itself depends on the driver. For example, the device
name string may change from it8716-isa-0290 to atk0110-acpi-0. This
means that basically all hardware monitoring software must be
reconfigured.

But that's not the worst case. The worst case is when the firmware
requests the I/O ports and either doesn't actually make use of it, or
only for the ACPI thermal zone driver which is very limited, or we do
not have a driver for the ACPI implementation yet. In these 3 cases the
user plain loses the hardware monitoring functionality. And I suspect
this is the most common case.

For this reason I am suggesting that we move acpi_enforce_resources in
the direction of "strict" but with baby steps first, as has been
discussed in another thread since then. If and only if we do not have
too many complaints, we can make one more step, etc.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
