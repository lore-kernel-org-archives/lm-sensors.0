From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 30 May 2006 12:32:33 +0000
Subject: [lm-sensors] LM Sensors autoconfig tool project awarded as
Message-Id: <20060530143233.b7f4d0b6.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <44744596.40406@hhs.nl>
In-Reply-To: <44744596.40406@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans, Mark,

> * Hans de Goede <j.w.r.degoede at hhs.nl> [2006-05-30 12:36:22 +0200]:
> > Yes I just encountered the first of such a system, any idea for
> > alternative methods to identify these? I'm myself thinking about
> > memmapping the bios and getting info from the bios image, anyone got any
> > experience with this?

I don't know of any alternative method. Best to fix the problem at its
root, and make the manufacturer fill in the DMI table properly in the
first place. A slow process, I know.

Mark Hoffman wrote:
> It might be useful to enhance libsensors so that it can process
> '#include' lines in the configuration file.  Since I have been
> working on the analyzer & parser lately... if it turns out that
> such functionality would be useful to you, I would offer to add it.

This would come in handy if we extend the database to contain not only
motherboards but also graphic adapters, for example.

> > Here is what my pcchips M811 gives:
> > Handle 0x0002, DMI type 2, 8 bytes.
> > Base Board Information
> >         Manufacturer:
> >         Product Name: VT8367-8235
> >         Version:
> >         Serial Number:
> > 
> > Clearly the didn't change this from the VIA reference bios.

Yup, same for my Fintek board:

Handle 0x0002
        DMI type 2, 8 bytes.
        Base Board Information
                Manufacturer:  
                Product Name: K8M800-8237
                Version:  
                Serial Number:  

I know there are BIOS updates available so I'll try this first. If the
latest BIOS doesn't fix it I'll contact Fintek.

> > > I don't think that being able to export the database is a key feature.
> > > End users shouldn't need this.
> > 
> > They will, one cannot assume a internet connection and even if one
> > assumes an internet connection, phoning home applications are evil!

One could argue that a 4 MB database on my hard disk drive, when I need
a single 3 kB file out of it, is evil. I have no problem with
applications phoning home as long as they ask me before. For systems
with no internet connection, people can download the file from the web
and copy it manually.

That being said, I am fine with both implementations, as long as it
works and the maintenance workload is limited.

> > > Likewise, I don't like the hotplug/udev stuff you mention in point 2.
> > > Configuration is only done once, so I don't quite see how hotplug is
> > > relevant here. 
> > 
> > The idea behind this is to make things truely plug and play, so if I
> > drop a new motherboard in my system the OS should reconfigure itself
> > automaticly and everything should work as if nothing has changed. I've
> > done this a couple of times and this currently works pretty well with
> > Linux as OS, except for lm_sensors.
> 
> I agree with you (Hans) here and about the database.  Actually, I *really*
> like the idea of having a little DMI/hotplug driver, because that means
> we *won't* have to add all of that directly to hwmon drivers.

Why would we have to add anything to the drivers?

I don't argue with the idea of a plug'n'play system. I argue strongly
against the proposed implementation. It really doesn't have anything
to do with hotplug (until your motherboard becomes hotpluggable...) and
the detection mechanism doesn't belong to the kernel. Userspace can
identify the motherboard and load the required modules, then configure
the chip(s) as needed. This only has to be done only once, at boot
time, and can easily be made part of the init scripts.

Unless I'm missing something. What do we win with an hotplug event?

> > > It's more simple, and more efficient too, to integrate
> > > the motherboard recognition code into sensors-detect. If enough DMI
> > > data is available, propose to connect to the online database to find a
> > > configuration file. If a configuration file is found, copy it, and skip
> > > all the probing phase. This is how I'd do it, anyway.
> > 
> > See above, besides I want lm_sensors to just work (tm), having to run
> > sensors-detect is not just working. I do agree that the detected
> > motherboard should be stored somewhere and that the existing config
> > should not be overwritten if the motherboard wasn't changed.

We agree on that second point. I don't agree with the statement that
"sensors-detect is not just working" though. sensors-detect does its
job well. If it fails on some systems, please report and we'll try to
fix that. Some things cannot be detected though (e.g. unused super-I/O
chips.) The real problem is that sensors-detect does only detect chips
and knows about which drivers they need. It was never meant to handle
the chips configuration, because this just can't be detected. The
project you propose would complement, not replace, sensors-detect.

-- 
Jean Delvare

