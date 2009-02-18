From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 18 Feb 2009 13:54:36 +0000
Subject: Re: [lm-sensors] [RFC] Support of chassis intrusion detection
Message-Id: <20090218145436.2026d795@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090217230215.5106b6c0@hyperion.delvare>
In-Reply-To: <20090217230215.5106b6c0@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Matt,

On Wed, 18 Feb 2009 07:20:34 -0600 (CST), Matt Roberds wrote:
> On Tue, 17 Feb 2009, Jean Delvare wrote:
> > sysfs interface
> > =======> >
> > chassis_intrusion
> > 		Chassis intrusion detection
> 
> Will the full name be something like chassis_intrusion0 (or .0 or -0) by
> default, with the possibility for more (...sion1 or .1 or -1) later?  As
> far as I can remember, I've only ever seen one bit of chassis intrusion
> detection per computer, but if it doesn't cost much, it might be nice to
> allow for expansion.

This is a good point, I've been thinking about it. The question is,
what point would there be in having more than one chassis intrusion
detector? If the case has been opened, you can't trust the system, no
matter how it has been opened. So even if there are several sensors,
merging them into a single information bit (either in hardware or
software) seems to make sense.

The only situation where this could make a difference is if a computer
case has several internal compartments, isolated from each other, so
depending on what exactly was opened, the intruder would have access to
different parts. But honestly, I've never seen any computer case like
this, and I fail to see the point of building such cases. So at this
point I don't think we have to handle multiple chassis_intrusion
entries in sysfs.

> 
> > sensors
> > ===> >
> > [...] So we could add a dedicated flag to clear the chassis intrusion
> > detection flag (e.g. "sensors --clear-chassis").
> 
> Are there any security implications here?  I am talking more about
> physical security (somebody stealing a stick of RAM) more than computer
> security (somebody getting root).  Do we want to somehow limit who can
> clear the chassis intrusion flag?

Of course we want. Only root will be allowed to run "sensors
--clear-chassis". Same as "sensors -s" today.

>                                   On the other hand, a malicious user
> can cause damage with the current code by (for example) shutting down
> or slowing the fans, or deliberately setting voltage limits too low or
> too high (to cause a monitoring daemon to reboot the system or
> whatever).

No, users can't do that, thankfully. Unless the admin is stupid enough
to suid the sensors binary, but then what can we do...

>             So letting someone reset the chassis intrusion flag may not
> be that big a deal.
> 
> Do the APM or ACPI specs say anything about how software is supposed to
> deal with chassis intrusion, or do they just say "a hardware chassis
> intrusion flag exists", or do they not care?  I know lm-sensors is not
> ACPI, but if there is already some kind of standard, it might be good to
> follow it.

APM is so old that I doubt we want to care about it at all. I couldn't
even find a PDF of the specification, only a RTF, that says a lot
doesn't it? And I'm not sure why a power management specification would
have anything to do with chassis intrusion.

ACPI v2 doesn't say anything about chassis intrusion as far as I can
see.

> Are there any problems availability of this feature "early" in the boot
> process?  Somebody who is really paranoid might want to stop booting, or
> take some other action, if the intrusion flag is on.  I think that
> people who care about this mostly do it before the regular OS kernel
> starts to load, though.  Either they tell the BIOS to treat intrusion as
> an error and require a password to get past the "error, hit F1 to
> continue" prompt that the BIOS puts up, or maybe they network boot a
> small program over PXE that looks at the intrusion flag, dispatches the
> SWAT team if required, and then boots the regular OS from the local hard
> drive.

In the typical case of modular drivers, we can't provide the feature
before the lm_sensors service is started, which is by definition late
in the boot process (root file system is already mounted.)
Distributions may still want to check it at this point in time and for
example fallback to runlevel 2 if an intrusion has been detected. But I
agree that anyway this is something that should be checked earlier,
before the OS is started.

> With parallel ports going away, eventually somebody is going to use the
> chassis intrusion flag as a one-bit, relatively low speed digital input
> pin.  I don't think there is any action for lm-sensors here other to
> recognize the question when somebody asks about it.

Whatever you drink in the morning... please consider changing that ;)

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
