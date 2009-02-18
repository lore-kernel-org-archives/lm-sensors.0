From: Matt Roberds <mattroberds@cox.net>
Date: Wed, 18 Feb 2009 13:20:34 +0000
Subject: Re: [lm-sensors] [RFC] Support of chassis intrusion detection
Message-Id: <Pine.LNX.4.64.0902180653230.8056@birdbird.example.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090217230215.5106b6c0@hyperion.delvare>
In-Reply-To: <20090217230215.5106b6c0@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 17 Feb 2009, Jean Delvare wrote:
> sysfs interface
> =======>
> chassis_intrusion
> 		Chassis intrusion detection

Will the full name be something like chassis_intrusion0 (or .0 or -0) by
default, with the possibility for more (...sion1 or .1 or -1) later?  As
far as I can remember, I've only ever seen one bit of chassis intrusion
detection per computer, but if it doesn't cost much, it might be nice to
allow for expansion.

> sensors
> ===>
> [...] So we could add a dedicated flag to clear the chassis intrusion
> detection flag (e.g. "sensors --clear-chassis").

Are there any security implications here?  I am talking more about
physical security (somebody stealing a stick of RAM) more than computer
security (somebody getting root).  Do we want to somehow limit who can
clear the chassis intrusion flag?  On the other hand, a malicious user
can cause damage with the current code by (for example) shutting down
or slowing the fans, or deliberately setting voltage limits too low or
too high (to cause a monitoring daemon to reboot the system or
whatever).  So letting someone reset the chassis intrusion flag may not
be that big a deal.

Do the APM or ACPI specs say anything about how software is supposed to
deal with chassis intrusion, or do they just say "a hardware chassis
intrusion flag exists", or do they not care?  I know lm-sensors is not
ACPI, but if there is already some kind of standard, it might be good to
follow it.

Are there any problems availability of this feature "early" in the boot
process?  Somebody who is really paranoid might want to stop booting, or
take some other action, if the intrusion flag is on.  I think that
people who care about this mostly do it before the regular OS kernel
starts to load, though.  Either they tell the BIOS to treat intrusion as
an error and require a password to get past the "error, hit F1 to
continue" prompt that the BIOS puts up, or maybe they network boot a
small program over PXE that looks at the intrusion flag, dispatches the
SWAT team if required, and then boots the regular OS from the local hard
drive.

With parallel ports going away, eventually somebody is going to use the
chassis intrusion flag as a one-bit, relatively low speed digital input
pin.  I don't think there is any action for lm-sensors here other to
recognize the question when somebody asks about it.

Matt Roberds


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
