From: j.w.r.degoede@hhs.nl (Hans de Goede)
Date: Tue, 30 May 2006 10:36:22 +0000
Subject: [lm-sensors] LM Sensors autoconfig tool project awarded as
Message-Id: <447C2026.6080503@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <44744596.40406@hhs.nl>
In-Reply-To: <44744596.40406@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Jean Delvare wrote:
> Hi Hans,
> 
> A few comments about DMI tables:
> * Depending on the system, the DMI table may be conveniently and
> accurately filled, or empty, or useless. Systems with poor DMI tables
> won't be supportable.

Yes I just encountered the first of such a system, any idea for
alternative methods to identify these? I'm myself thinking about
memmapping the bios and getting info from the bios image, anyone got any
experience with this?

Here is what my pcchips M811 gives:
Handle 0x0002, DMI type 2, 8 bytes.
Base Board Information
        Manufacturer:
        Product Name: VT8367-8235
        Version:
        Serial Number:

Clearly the didn't change this from the VIA reference bios.

> * Some systems have no type 2 (Base Board Information) DMI record but
> do have type 1 (System Information) or type 3 (Chassis Information)
> records you can fall back on.
The above motherboard doesn't contain any usefull info there either.

> I don't think that being able to export the database is a key feature.
> End users shouldn't need this.
> 

They will, one cannot assume a internet connection and even if one
assumes an internet connection, phoning home applications are evil!

> Likewise, I don't like the hotplug/udev stuff you mention in point 2.
> Configuration is only done once, so I don't quite see how hotplug is
> relevant here. 

The idea behind this is to make things truely plug and play, so if I
drop a new motherboard in my system the OS should reconfigure itself
automaticly and everything should work as if nothing has changed. I've
done this a couple of times and this currently works pretty well with
Linux as OS, except for lm_sensors.

> It's more simple, and more efficient too, to integrate
> the motherboard recognition code into sensors-detect. If enough DMI
> data is available, propose to connect to the online database to find a
> configuration file. If a configuration file is found, copy it, and skip
> all the probing phase. This is how I'd do it, anyway.
> 

See above, besides I want lm_sensors to just work (tm), having to run
sensors-detect is not just working. I do agree that the detected
motherboard should be stored somewhere and that the existing config
should not be overwritten if the motherboard wasn't changed.


Regards,

Hans

