From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Tue, 30 May 2006 11:25:12 +0000
Subject: [lm-sensors] LM Sensors autoconfig tool project awarded as
Message-Id: <20060530112512.GB5739@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <44744596.40406@hhs.nl>
In-Reply-To: <44744596.40406@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans:

First of all, thanks for taking the initiative to work on this.  It does
sound like a nice project for a student, and it is something that would
make lm-sensors usable for many more people.

> Jean Delvare wrote:
> > A few comments about DMI tables:
> > * Depending on the system, the DMI table may be conveniently and
> > accurately filled, or empty, or useless. Systems with poor DMI tables
> > won't be supportable.

* Hans de Goede <j.w.r.degoede at hhs.nl> [2006-05-30 12:36:22 +0200]:
> Yes I just encountered the first of such a system, any idea for
> alternative methods to identify these? I'm myself thinking about
> memmapping the bios and getting info from the bios image, anyone got any
> experience with this?

I don't know of any better ways to automatically identify mainboards.
However, I've been mulling over an idea to make manual configuration
easier.  Rather than distribute a single giant sensors.conf.eg as we
do now, we could distribute a tree of conf files, one per board:

/etc/sensors/
/etc/sensors/asus/
/etc/sensors/asus/p4s333.conf
/etc/sensors/asus/p4c800-e-deluxe.conf

It might be useful to enhance libsensors so that it can process
'#include' lines in the configuration file.  Since I have been
working on the analyzer & parser lately... if it turns out that
such functionality would be useful to you, I would offer to add it.

> Here is what my pcchips M811 gives:
> Handle 0x0002, DMI type 2, 8 bytes.
> Base Board Information
>         Manufacturer:
>         Product Name: VT8367-8235
>         Version:
>         Serial Number:
> 
> Clearly the didn't change this from the VIA reference bios.
> 
> > * Some systems have no type 2 (Base Board Information) DMI record but
> > do have type 1 (System Information) or type 3 (Chassis Information)
> > records you can fall back on.
> The above motherboard doesn't contain any usefull info there either.
> 
> > I don't think that being able to export the database is a key feature.
> > End users shouldn't need this.
> > 
> 
> They will, one cannot assume a internet connection and even if one
> assumes an internet connection, phoning home applications are evil!
> 
> > Likewise, I don't like the hotplug/udev stuff you mention in point 2.
> > Configuration is only done once, so I don't quite see how hotplug is
> > relevant here. 
> 
> The idea behind this is to make things truely plug and play, so if I
> drop a new motherboard in my system the OS should reconfigure itself
> automaticly and everything should work as if nothing has changed. I've
> done this a couple of times and this currently works pretty well with
> Linux as OS, except for lm_sensors.

I agree with you (Hans) here and about the database.  Actually, I *really*
like the idea of having a little DMI/hotplug driver, because that means
we *won't* have to add all of that directly to hwmon drivers.

> > It's more simple, and more efficient too, to integrate
> > the motherboard recognition code into sensors-detect. If enough DMI
> > data is available, propose to connect to the online database to find a
> > configuration file. If a configuration file is found, copy it, and skip
> > all the probing phase. This is how I'd do it, anyway.
> > 
> 
> See above, besides I want lm_sensors to just work (tm), having to run
> sensors-detect is not just working. I do agree that the detected
> motherboard should be stored somewhere and that the existing config
> should not be overwritten if the motherboard wasn't changed.

Thanks & regards,

-- 
Mark M. Hoffman
mhoffman at lightlink.com


