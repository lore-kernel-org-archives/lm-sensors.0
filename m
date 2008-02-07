From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Date: Thu, 07 Feb 2008 12:30:04 +0000
Subject: Re: [lm-sensors] The new thermal management sysfs class, and hwmon
Message-Id: <20080207123004.GA16524@khazad-dum.debian.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080203022622.GA995@khazad-dum.debian.net> <20080205135725.GO20687@jupiter.solarsys.private> <20080205145550.GA24128@khazad-dum.debian.net> <200802070201.36016.lenb@kernel.org>
In-Reply-To: <200802070201.36016.lenb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Len Brown <lenb@kernel.org>
Cc: "Mark M. Hoffman" <mhoffman@lightlink.com>, "Thomas, Sujith" <sujith.thomas@intel.com>, lm-sensors@lm-sensors.org, linux-acpi@vger.kernel.org, "Zhang, Rui" <rui.zhang@intel.com>

On Thu, 07 Feb 2008, Len Brown wrote:
> On Tuesday 05 February 2008 09:55, Henrique de Moraes Holschuh wrote:
> > > > The only duplication which I can see of is in the "reporting of
> > > > temperature", which is quite reasonable for a thermal management module
> > > > to have.
> > > 
> > > Well, HdMH and I apparently disagree about this.  All I really care
> > > about is that the temp info should be available through /sys/class/hwmon.
> > > Many people just want to check their temps, without diving into the fine
> > > details of a "thermal management solution".
> > 
> > Well, I strongly care for not having to duplicate the entire sysfs code of
> > the thinkpad-acpi thermal management subdrivers (fan control, thermal
> > readings) to a new interface AND maybe even finding myself in need to add a
> > *third* platform device and driver to thinkpad-acpi just because the new
> > interface didn't even try to be as compatible with hwmon as possible :-(
> 
> I expect that Thinpads will continue to be optimized primarily for
> Windows via ACPI.  I don't expect thinkpads to suddenly switch over
> to OSPM user-space thermal control -- because Windows doesn't do that.
> So I don't think any bad things will happen if thinkpad-acpi
> doesn't respond to this.

Nor do I.  But thinkpad users (Windows AND linux users alike) don't exactly
like the fan behaviour of the thinkpad EC, and they do override it with
userspace solutions (yes, even in Windows).  Either to speed the fan up
earlier, or to speed it up much later :p

Heck, I find myself kicking the T43 fan to level 7 (fastest normal fan mode)
every time I am doing a long kernel compile, just to make sure the
temperatures don't rise too much.  The T43 passive cooling ain't the best
(people even hardware-mod it to enhance it), and the chinese plants
manufacturing the planar cards for thinkpad have a long story of using
crappy time-bomb solder that breaks under thermal stress after a few years,
and I want my T43 to last without the need to reflow the entire planar card
(motherboard) every five years.  We *think* they started using better solder
since the 2686 and 2687 T43 models, but the machines are not yet old enough
to know this for sure, so better save than sorry.

So, you'd have a few users right there, including one that is a kernel
developer and can give you high-quality feedback with an outsider PoV :)
Heck, I keep getting requests to add a fan control loop in thinkpad-acpi...
I'd very much prefer to have the ACPI subsystem handle it.

> I do agree that we should make the I/F the same, where possible,
> (that was my original proposal)

Please do, then.  At least for the termal readings, which are a clear pain
right now for a driver writer to add to both hwmon and the new interfce.
Name the attributes for thermal reading as hwmon does, use 10^-3 C as the
unit, and if you want to give the thermal zone names from the ACPI tables,
use the hwmon "label" attribute.  That's not a big change, should take 1h
tops to write and debug.

I have nothing against the generalized "cooling control levels" the new
interface adds, and I wouldn't mind proposing the required hwmon changes,
and adding it to thinkpad-acpi...  it is just yet another attribute and
another way to control the fan, hwmon already has enough of them that one
extra won't matter at all.

> I'm delighted to hear that the hwmon community is open minded
> about expanding the capabilities of hwmon.  We should definately
> look into that.  While Menlo will likely start shipping with
> the current solution, there is no reason we can't evolve it over time --
> for we know the guys writing the software that will use this I/F...

It would be best to avoid changing the ABI too much, that's why I'd quite
like to see at least the thermal zones become hwmon-ABI-compatible as soon
as possible :(

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
