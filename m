From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Date: Sat, 23 Feb 2008 20:39:53 +0000
Subject: Re: [lm-sensors] The new thermal management sysfs class, and hwmon
Message-Id: <20080223203953.GC5123@khazad-dum.debian.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080203164410.GL20687@jupiter.solarsys.private> <20080203175006.GB9159@khazad-dum.debian.net> <05B550FD4BD2014E841D83547B626008029899FE@bgsmsx411.gar.corp.intel.com> <20080205135725.GO20687@jupiter.solarsys.private> <05B550FD4BD2014E841D83547B626008029BF29B@bgsmsx411.gar.corp.intel.com> <1202915450.7977.607.camel@queen.suse.de> <20080214140855.GB12412@srcf.ucam.org> <1203659229.3210.45.camel@localhost.localdomain> <47BE8105.30301@hhs.nl> <1203669206.3210.68.camel@localhost.localdomain>
In-Reply-To: <1203669206.3210.68.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Zhang, Rui" <rui.zhang@intel.com>
Cc: Hans de Goede <j.w.r.degoede@hhs.nl>, Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org, "Thomas, Sujith" <sujith.thomas@intel.com>, Richard Hughes <hughsient@gmail.com>, lm-sensors@lm-sensors.org, "Mark M. Hoffman" <mhoffman@lightlink.com>, Thomas Renninger <trenn@suse.de>, Len Brown <lenb@kernel.org>

On Fri, 22 Feb 2008, Zhang, Rui wrote:
> pwm[1-*]_enable = 1 : manual fan control (using pwm[1-*])
> 		  2+: automatic fan control (by acpi thermal driver)

And pwm[1-*]_enable = 0 should try to bump the fan to the fasted speed
possible, BTW.  This is not very obvious :-)

Many hwmon devices already have a function assigned to lower values of
pwm_enable.  I suggest we define a static (high) value to the generic
software-based kernel-mode fan controllers (of which, ACPI thermal
management is the first one), so that the software-based fan-controllers can
control generic fans too.

say, reserve bits 7,6 and 5 to select the fan controller class:
 000 - 
     000 00000: disabled (fan at top speed)
     000 00001: manual pwm control
     000 001xx: device specific hw or sw strategies
     000 01xxx: reserved for future use
     000 1xxxx: reserved for future use

 001 -
     001 00000: ACPI thermal management controller
     001 00001: (foobar thermal management controller)
     ...

 01x - reserved for future use.
 1xx - reserved for future use.

Or something like that.  Note that the above is, AFAIK, fully backwards
compatible with all current hwmon devices.

> Yes, it can work for ACPI fan although I don't think the existing pwm
> hwmon I/F maps well to what we need and it seems like a "forced fit" to
> use it. Any better ideas? :)

Sure: we add a new "view" of the pwm controller.  hwmon drivers are allowed
to export either one or both.  If they export both, however, they MUST be
kept in complete sync.  Most hwmon devices will export either, but not both.
Stuff like thinkpad-acpi that is already complex enough anyway, can go
through the pain of providing both and keeping them in sync.

The new "view" could well use the ACPI thermal management idea, which is
nicely generic (if a bit less powerful) than hwmon's current view, and you
could very easily convert the current thermal management stuff to it.
Here's a proposal:

pwm[1-*]_max_level (RO):
   Maximum valid level for pwm[1-*]_level

pwm[1-*]_level (RO/RW):
   Alternate view of pwm[1-*].  0 means off. 1-pwm[1-*]_max_level means
   active.  The higher the level, the higher the speed.

However, that would only make sense for fans.  Using the pwm model to
control generic cooling properties of devices doesn't work well.

I propose we add an alternate "cooling power" set of attributes.  Fans could
use either one, or even both (as long as they are kept in sync):

cooling_mode (RO/RW):
   0 = disabled (no extra cooling effort)
   1 = manual
   2.. (same as pwm_enable)

   Note that this does NOT have the same behaviour of pwm_enable=0!

cooling[1-*]_max_level (RO):
   maximum cooling effort level available

cooling[1-*]_level (RW/RO):
   0 = no extra cooling
   1 = cooling effort level 1
   ...

   Increasing the cooling effort level, increases the cooling effect of the
   device (might mean downclocking buses at higher levels, etc).

I propose this, because it is actually a damn nice way to deal with fans in
most Linux platforms, as they are used only for cooling.  It has clearly
conceptual advantages over the pwm model we have right now.  And it could
be easily used by the ACPI thermal management stuff.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
