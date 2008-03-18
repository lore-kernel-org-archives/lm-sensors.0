From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 18 Mar 2008 09:40:01 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] thermal: add hwmon sys I/F for thermal
Message-Id: <20080318104001.10a9335e@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1203975102.10256.82.camel@acpi-hp-zz.sh.intel.com>
	<47C3D04E.6090609@hhs.nl>
	<20080317133732.05b79f4d@hyperion.delvare>
	<1205805569.3171.23.camel@acpi-hp-zz.sh.intel.com>
In-Reply-To: <1205805569.3171.23.camel@acpi-hp-zz.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Zhang, Rui" <rui.zhang@intel.com>
Cc: Hans de Goede <j.w.r.degoede@hhs.nl>, linux-acpi <linux-acpi@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Thomas Renninger <trenn@suse.de>, "Thomas, Sujith" <sujith.thomas@intel.com>, "Mark M. Hoffman" <mhoffman@lightlink.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <lenb@kernel.org>, Richard Hughes <hughsient@gmail.com>

Hi Rui,

On Tue, 18 Mar 2008 09:59:29 +0800, Zhang, Rui wrote:
> On Mon, 2008-03-17 at 20:37 +0800, Jean Delvare wrote:
> > I am sorry that I did not notice when you suggested this. I disagree,
> > but now Rui's code is upstream so I guess it's too late to complain.
> > Still here are my reasons:
> > 
> > One of the great things about libsensors is that it gives unique names
> > to hardware monitoring devices, and for each device, each feature has
> > a
> > unique name as well. This makes it possible to ignore or label a
> > specific feature in /etc/sensors.conf in a way that is stable over
> > reboot and addition of new hardware.
> Interesting.
> 
> > By going with a single virtual device for all thermal zones, you break
> > this model. Depending on which thermal zone drivers are loaded and in
> > which order they are loaded, there will be more or less temp* files in
> > the hwmon directory and you also can't predict their order.
> Yes, you're right.
> 
> > The
> > labelling issue could be solved by adding temp*_label files, but this
> > still prevents the user from overriding a label.
> why user needs to override the label?

Originally, the kernel drivers don't provide any labels (because they
don't know which temperature sensor corresponds to what) so the default
labels are temp1, temp2, temp3 etc. The users instead what to see "CPU
Temp", "M/B Temp" etc. which is why libsensors makes it possible to
associate a label to each input. If a given kernel driver knows what
temperature sensors correspond to, then this driver could propose a
label. However there are many reasons why the user may want to override
the proposed label:
* The BIOS is broken and mislabeled the zone.
* The default label is too long and doesn't fit it some graphical
  interface.
* The user wants to translate the text to his/her native language.
* Different thermal zones end up with the same label and the user
  wants to differentiate them.

> >  And there's no way to
> > reliably ignore a specific thermal zone or to ask for information
> > about a specific thermal zone with the current model.
> > 
> > For this reason, I think it would be much better to have one hwmon
> > class device for each _type_ of thermal zone.
> Well. I disagree.
> First, the generic thermal driver only checks the callbacks and builds
> the sys I/F for each thermal zone registered. So there is no difference
> between different thermal zones. Checking the type of different thermal
> zone and register a hwmon device for each _type of thermal zones doesn't
> make sense to me. :(

The type of the thermal zone is known to the generic thermal driver
somehow, as it exposes the information through the "type" sysfs file. I
understand that it doesn't make any difference between different types
other than that, but as long as it can differentiate between them, it
could create different hwmon devices. Whether we want to do it or not,
can be discussed of course.

> Second, take ACPI thermal zone for example, the number/order of the ACPI
> thermal zones can not be predicted either. All of this information is
> gotten during system boot time.

The number/order of the ACPI thermal zones is stable accross reboots,
isn't it? That's all we really care about.

>  
> >  For example, all ACPI
> > thermal zones would be listed as one hwmon class device. If we later
> > add support for another type of thermal zones, all thermal zones of
> > this type would be listed as one (different) hwmon class device. This
> > makes each specific thermal zone driver responsible for the stability
> > of the numbering of the various thermal zones of a given type. This
> > would also let us give names to the different thermal zone types (e.g.
> > "acpitz" for ACPI thermal zones) so that the users and supporters have
> > an idea who is providing these temperature values and limits.
> If we really need to do this, I suggest we do this in the native driver.
> Say acpi thermal driver is responsible for registering a hwmon device
> for ACPI thermal zones, just like the other hwmon native sensor drivers.
> what do you think?

That's what I wanted to do originally, before you showed up with this
generic thermal driver. Of course each native thermal zone driver could
register its own hwmon interface. This will however cause code
duplication. I don't really care (I doubt there will be that many
different native thermal zone drivers anyway), it's really up to you
how you want to implement it, as long as it integrates properly with
libsensors.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
