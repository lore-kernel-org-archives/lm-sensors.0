From: Len Brown <lenb@kernel.org>
Date: Sat, 23 Feb 2008 07:43:14 +0000
Subject: Re: [lm-sensors] The new thermal management sysfs class, and hwmon
Message-Id: <200802230243.15156.lenb@kernel.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080203022622.GA995@khazad-dum.debian.net> <1203669206.3210.68.camel@localhost.localdomain> <47BEA9CE.7030802@hhs.nl>
In-Reply-To: <47BEA9CE.7030802@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hans de Goede <j.w.r.degoede@hhs.nl>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, Matthew Garrett <mjg59@srcf.ucam.org>, Thomas Renninger <trenn@suse.de>, "Thomas, Sujith" <sujith.thomas@intel.com>, "Mark M. Hoffman" <mhoffman@lightlink.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-acpi@vger.kernel.org, lm-sensors@lm-sensors.org, Jean Delvare <khali@linux-fr.org>, Richard Hughes <hughsient@gmail.com>

On Friday 22 February 2008 05:54, Hans de Goede wrote:
> Zhang, Rui wrote:
> > Hi, Hans,
> > 
> > On Fri, 2008-02-22 at 16:00 +0800, Hans de Goede wrote:
> > 
> >> I think all that is really needed and asked for is for the new thermal
> >> ACPI
> >> code to:
> >> 1) provide temp readings in the same format as hwmon (so milli degrees
> >> celcius,
> >> not degrees celcius

> > Agree.

/me looks for the "temp = temp * 1000" patch from Rui, as nobody disagrees
that we should implement the original plan of being as hwmon compatible as possbile.

(actually, ACPI always works with 1/10th degree Kelvin internall, so someplace
 it should actually be temp = temp * 100)

> >> 2) provide a hwmon interface so that tools like (but not limited too):
> >> * net-snmp
> >> * mrtg
> >> * sensors
> >> * sensors-applet (gnome)
> >> * xfce-sensors-applet
> >> * ksysguard
> >> * ksensors
> >> * gkrellm
> >>
> >> Can provide temp and fan readings without having to be modified.

> > hmm, for fan device, maybe something like this?
> > pwm[1-*]_enable = 1 : manual fan control (using pwm[1-*])
> > 		  2+: automatic fan control (by acpi thermal driver)
> > pwm[1-*] = 0  : fan is off.
> > pwm[1-*] = 255: fan is on.
> > pwm[1-*] has only two valid values as ACPI fan only support 
> > two states, ON/OFF. and it doesn't need fan[1-*]_input because the fan
> > speed is not available.
> > Yes, it can work for ACPI fan although I don't think the existing pwm
> > hwmon I/F maps well to what we need and it seems like a "forced fit" to
> > use it. Any better ideas? :)
> > 
> 
> I wouldn't expose a pwm interface, doing so isn't that important as none of the 
> above listed apps actually use it, the pwm interface really only is for people 
> who want to manually tweak their fan speed and / or use some scripts to control 
> the fan speed based on temp when the hardware doesn't support it, as such it 
> doesn't get widely used, also since there isn't a really good mapping between 
> acpi thermalzone stuff and the hwmon pwm interface I wouldn't add a pwm 
> interface to a hwmon interface the the thermal zone code.
> 
> And if fan speeds aren't available (aren't they?) then I would only add a hwmon 
>   class reference to a sysfs dir containing tempX_input's and a name atrribute 
> and leave it at that.

Right, ACPI doesn't supply fan speeds -- ACPI abstracts fans so that that
they are just on/off.  Systems that support multi-speed ACPI fans
do it with with multiple logical fans to indicate the different speeds
of the same physical fan.

Yeah, i know, this abstraction is distasteful to hwmon folks
who are used to talking to the real hw and knowing what it is doing.
Needless to say, that simply isn't the model these system designers had in mind.
The good news only laptops from hp, acer, fsc tend to implement
acpi fan control.  Laptops from other vendors do not, and I've
never seen a desktop or server with ACPI fan control.

per the paper at the beginning of this thread, the actual
focus of the new generic thermal I/F isn't ACPI fans at all.
it is really being driven by upcoming systems that
have no fans.  Indeed, it not an "ACPI thermal I/F",
for we fully intend that it to be a generic I/F that
non-ACPI devices can use too.

thanks,
-Len


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
