From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Mon, 17 Mar 2008 12:55:00 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] thermal: add hwmon sys I/F for thermal
Message-Id: <47DE6A24.7040705@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <1203975102.10256.82.camel@acpi-hp-zz.sh.intel.com>	<47C3D04E.6090609@hhs.nl> <20080317133732.05b79f4d@hyperion.delvare>
In-Reply-To: <20080317133732.05b79f4d@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Thomas Renninger <trenn@suse.de>, "Thomas, Sujith" <sujith.thomas@intel.com>, "Mark M. Hoffman" <mhoffman@lightlink.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <lenb@kernel.org>, Richard Hughes <hughsient@gmail.com>

Jean Delvare wrote:
> Hi Hans,
> 
> On Tue, 26 Feb 2008 09:39:42 +0100, Hans de Goede wrote:
>> Zhang, Rui wrote:
>>> Add hwmon sys I/F for the generic thermal device.
>>>
>> Great!
>>
>> But I have several remarks:
>> 1) Looking at the new code, you only add temp1_input, so I'm guessing that you
>> are registering a seperate hwmon class entry per zone? Please don't do that, 
>> please register one hwmon class entry, and add multiple temp#_input attr to it 
>> (and the same for crit).
> 
> I am sorry that I did not notice when you suggested this. I disagree,
> but now Rui's code is upstream so I guess it's too late to complain.
> Still here are my reasons:
> 
> One of the great things about libsensors is that it gives unique names
> to hardware monitoring devices, and for each device, each feature has a
> unique name as well. This makes it possible to ignore or label a
> specific feature in /etc/sensors.conf in a way that is stable over
> reboot and addition of new hardware.
> 
> By going with a single virtual device for all thermal zones, you break
> this model. Depending on which thermal zone drivers are loaded and in
> which order they are loaded, there will be more or less temp* files in
> the hwmon directory and you also can't predict their order. The
> labelling issue could be solved by adding temp*_label files, but this
> still prevents the user from overriding a label. And there's no way to
> reliably ignore a specific thermal zone or to ask for information about
> a specific thermal zone with the current model.
> 
> For this reason, I think it would be much better to have one hwmon
> class device for each _type_ of thermal zone. For example, all ACPI
> thermal zones would be listed as one hwmon class device. If we later
> add support for another type of thermal zones, all thermal zones of
> this type would be listed as one (different) hwmon class device. This
> makes each specific thermal zone driver responsible for the stability
> of the numbering of the various thermal zones of a given type. This
> would also let us give names to the different thermal zone types (e.g.
> "acpitz" for ACPI thermal zones) so that the users and supporters have
> an idea who is providing these temperature values and limits.
> 

I fully agree, I didn't know there was a generic thermal zone model, and that 
there could be multiple drivers implementing it (let alone multiple thermal 
zone drivers active for one system ??) I thought this was all ACPI only,

If this (multiple thermal zone drivers active for one system) can really happen 
then we really should fix it so that there is one hwmon class entry per thermal 
zone driver. This can be done without changing the ABI, as things would still 
follow the standard hwmon ABI.

Regards,

Hans


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
