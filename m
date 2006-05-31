From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Wed, 31 May 2006 03:21:18 +0000
Subject: [lm-sensors] LM Sensors autoconfig tool project awarded as
Message-Id: <20060531032118.GC5739@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <44744596.40406@hhs.nl>
In-Reply-To: <44744596.40406@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean:

> > * Hans de Goede <j.w.r.degoede at hhs.nl> [2006-05-30 12:36:22 +0200]:
> > > They will, one cannot assume a internet connection and even if one
> > > assumes an internet connection, phoning home applications are evil!

* Jean Delvare <khali at linux-fr.org> [2006-05-30 14:32:33 +0200]:
> One could argue that a 4 MB database on my hard disk drive, when I need
> a single 3 kB file out of it, is evil. I have no problem with
> applications phoning home as long as they ask me before. For systems
> with no internet connection, people can download the file from the web
> and copy it manually.

A 4MB database is well into the noise for most distributions.  For any
that actually care, it should be easy to package the data separately.

> That being said, I am fine with both implementations, as long as it
> works and the maintenance workload is limited.
> 
> > > > Likewise, I don't like the hotplug/udev stuff you mention in point 2.
> > > > Configuration is only done once, so I don't quite see how hotplug is
> > > > relevant here. 
> > > 
> > > The idea behind this is to make things truely plug and play, so if I
> > > drop a new motherboard in my system the OS should reconfigure itself
> > > automaticly and everything should work as if nothing has changed. I've
> > > done this a couple of times and this currently works pretty well with
> > > Linux as OS, except for lm_sensors.
> > 
> > I agree with you (Hans) here and about the database.  Actually, I *really*
> > like the idea of having a little DMI/hotplug driver, because that means
> > we *won't* have to add all of that directly to hwmon drivers.
> 
> Why would we have to add anything to the drivers?
> 
> I don't argue with the idea of a plug'n'play system. I argue strongly
> against the proposed implementation. It really doesn't have anything
> to do with hotplug (until your motherboard becomes hotpluggable...) and
> the detection mechanism doesn't belong to the kernel. Userspace can
> identify the motherboard and load the required modules, then configure
> the chip(s) as needed. This only has to be done only once, at boot
> time, and can easily be made part of the init scripts.
> 
> Unless I'm missing something. What do we win with an hotplug event?

I had assumed that an auto-configurator would be driven by the kernel with
hotplug events.  But I guess you're right, it could be done just as well
without that.

> > > > It's more simple, and more efficient too, to integrate
> > > > the motherboard recognition code into sensors-detect. If enough DMI
> > > > data is available, propose to connect to the online database to find a
> > > > configuration file. If a configuration file is found, copy it, and skip
> > > > all the probing phase. This is how I'd do it, anyway.
> > > 
> > > See above, besides I want lm_sensors to just work (tm), having to run
> > > sensors-detect is not just working. I do agree that the detected
> > > motherboard should be stored somewhere and that the existing config
> > > should not be overwritten if the motherboard wasn't changed.
> 
> We agree on that second point. I don't agree with the statement that
> "sensors-detect is not just working" though. sensors-detect does its
> job well. If it fails on some systems, please report and we'll try to
> fix that. Some things cannot be detected though (e.g. unused super-I/O
> chips.) The real problem is that sensors-detect does only detect chips
> and knows about which drivers they need. It was never meant to handle
> the chips configuration, because this just can't be detected. The
> project you propose would complement, not replace, sensors-detect.

(If I may...) Hans is not saying that sensors-detect does not work.  For
the purpose of developers, it works well.  For the purpose of a user with
some courage or knowledge, it can also work.  But...

Go and give a talk to a local LUG about lm-sensors and you will find that
a lot of people will just wait for something like Hans' project to be
started and finished rather than wade into sensors-detect.  They're not
stupid either, and I don't blame them.  

Of course, free software being what it is... an automagic configurator
would have never made it to the top of my personal TODO list.  Anyone
who knows enough about lm-sensors to write a proper one doesn't actually
need it.  That said, once complete I probably will use it to save a tiny
amount of work (re-targeting a symlink or two) whenever I move a board
or a hard drive.

But for many users, something more automatic than sensors-detect could
mean the difference between using lm-sensors or not using it at all.

Regards,

-- 
Mark M. Hoffman
mhoffman at lightlink.com


