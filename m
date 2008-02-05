From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Date: Tue, 05 Feb 2008 14:55:50 +0000
Subject: Re: [lm-sensors] The new thermal management sysfs class, and hwmon
Message-Id: <20080205145550.GA24128@khazad-dum.debian.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080203022622.GA995@khazad-dum.debian.net> <1202031072.3042.54.camel@acpi-sony.sh.intel.com> <20080203164410.GL20687@jupiter.solarsys.private> <20080203175006.GB9159@khazad-dum.debian.net> <05B550FD4BD2014E841D83547B626008029899FE@bgsmsx411.gar.corp.intel.com> <20080205135725.GO20687@jupiter.solarsys.private>
In-Reply-To: <20080205135725.GO20687@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Mark M. Hoffman" <mhoffman@lightlink.com>
Cc: "Thomas, Sujith" <sujith.thomas@intel.com>, lm-sensors@lm-sensors.org, linux-acpi@vger.kernel.org, "Zhang, Rui" <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>

On Tue, 05 Feb 2008, Mark M. Hoffman wrote:
> * Henrique de Moraes Holschuh <hmh@hmh.eng.br>:
> > > I would really appreciate if the thermal zone ABI used a subset of the
> > > hwmon ABI.  There is absolutely no reason to have one return data in
> > > 10^-3 C while the other returns data in 10^0 C, for example.  IMO, if
> > > both ABIs need thermal readings, both should use the same attribute,
> > > defined in the same way.  The same goes for other attributes in the two
> > > interfaces that share a common concept.

Nobody seems to have paid attention to this detail so far.

At least *please* keep the two interfaces in sync for everything that is
common to the two.  As I driver author, I would appreciate that a LOT.

> Incorrect.  We support devices with a variety of hardware interfaces in
> addition to the I2C/SMBus.  Did you even look?

Heh.  I was the first to complain, and thinkpad-acpi is NOT a I2C or SMBus
driver.  In fact, it is an *ACPI* driver.  It talks to the thinkpad ACPI EC
using the APCI EC interface.

thinkpad-acpi uses the hwmon interface very effectively to export what would
ammount to up to 16 thermal zones (although I have not seen more than 11 of
them in use in any ThinkPad to date), one advanced fan controller that ACPI
can't even model properly AFAIK, etc.

> > These were all the facts which lead us to take a different route than
> > hwmon.
> 
> I don't actually mind having a thermal management interface that is
> outside of hwmon, if that's what you want to do.  But these "facts"
> (which are the premises of your rationale) are mostly bogus.

Well, I *do* mind a thermal management interface outside of hwmon *when* it
is duplicating functionality, but does it differently for no strong reason.
Otherwise, I don't strongly care either way, even if I do prefer a single
unified interface.

Please at least keep the same attribute naming and specification as hwmon
for everything that is common to the two interfaces.  That would make the
life a lot easier for us driver writers.

But extending hwmon to do all ACPI needs it to would be *much* better IMHO,
that would improve the hwmon interface, and give userspace a single generic
thermal management *and* monitoring interface to talk to.

> * Thomas, Sujith <sujith.thomas@intel.com> [2008-02-05 15:44:19 +0530]:
> > IMO the scope of hwmon is to monitor/report out temperature, voltage ,
> > current etc of the devices/platform . But the scope of these patches is
> 
> The scope of hwmon is to allow whatever the hardware allows.  Period.

I'd say that the scope of hwmon is to allow *all* capabilities of any
sensor/monitoring hardware/firmware to be exported to the kernel and
userspace, *while* making as much common functionality between the various
chips/firmwares/drivers as generic as possible.  Old hwmon didn't attempt to
do this, and it was hell to work with it.  The new one with generic
interfaces is a lot tougher on driver writers sometimes, but it paid off
very well in userspace IMO.

> > The only duplication which I can see of is in the "reporting of
> > temperature", which is quite reasonable for a thermal management module
> > to have.
> 
> Well, HdMH and I apparently disagree about this.  All I really care
> about is that the temp info should be available through /sys/class/hwmon.
> Many people just want to check their temps, without diving into the fine
> details of a "thermal management solution".

Well, I strongly care for not having to duplicate the entire sysfs code of
the thinkpad-acpi thermal management subdrivers (fan control, thermal
readings) to a new interface AND maybe even finding myself in need to add a
*third* platform device and driver to thinkpad-acpi just because the new
interface didn't even try to be as compatible with hwmon as possible :-(

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
