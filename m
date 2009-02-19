From: Matt Roberds <mattroberds@cox.net>
Date: Thu, 19 Feb 2009 13:00:23 +0000
Subject: Re: [lm-sensors] [RFC] Support of chassis intrusion detection
Message-Id: <Pine.LNX.4.64.0902190700070.11207@birdbird.example.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090217230215.5106b6c0@hyperion.delvare>
In-Reply-To: <20090217230215.5106b6c0@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 18 Feb 2009, Jean Delvare wrote:
> On Wed, 18 Feb 2009 07:20:34 -0600 (CST), Matt Roberds wrote:

> The question is, what point would there be in having more than one
> chassis intrusion detector?

This is only hypothetical - I haven't seen a case with more than one
switch.  Having said that: I *have* used a rackmount server case that had
a lockable door on the front that covered the drive bays.  If you wanted
to add or remove hardware, though, you had to slide the case out of the
rack on its rails, and remove the top of the case.  I could see somebody
wanting to have two switches: one on the drive bay door and one on the
top.  In normal operation, maybe somebody comes along every so often and
swaps a CD/DVD or something, so you want a notification or maybe a
warning when the drive bay door is open.  But nobody is supposed to be
taking the top off of the case, so you want to scream and stop the world
when the top of the case is open.  (On the other hand, who switches
disks anymore?  Get your updates from the network, and have a backup
server instead of local backups.)

>> Do the APM or ACPI specs say anything about how software is supposed
>> to deal with chassis intrusion, or do they just say "a hardware
>> chassis intrusion flag exists", or do they not care?
>
> APM is so old that I doubt we want to care about it at all.

ISA dates to 1980-1981 and we still have to look for sensors there.  :)

> And I'm not sure why a power management specification would have
> anything to do with chassis intrusion.

As far as I remember, power management stuff started showing up in the
BIOS / on motherboards at around the same time as chassis intrusion
detection did.  I thought maybe that was because intrusion was part of
the specification.

In a later message, you wrote:

> The point which makes me reluctant to go for multiple inputs is how
> we are going to handle clearing them with "sensors". Should "sensors
> --clear-intrusion" clear them all? Or do we need to provide a
> parameter specifying which intrusion detector needs to be cleared?

Is it possible for sensors to know how many there are?  That way, if
there's just one, "sensors --clear-intrusion" just clears that one,
but if there's more than one, it says "error: which one do you want?"
Or maybe --clear-intrusion, by default, always clears the "first"
sensor found, only clearing a different one if given an argument.
(This might lead to surprises if the sensors get enumerated in a
different order with a reboot or new driver or whatever.)

Back to the first message:

>> With parallel ports going away, eventually somebody is going to use
>> the chassis intrusion flag as a one-bit, relatively low speed digital
>> input pin.
>
> Whatever you drink in the morning... please consider changing that ;)

I tried to get something stronger, but the guy at the store mumbled
something about azeotropes.  Not sure what the problem is there.  :)

Matt Roberds


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
