From: "Zhang, Rui" <rui.zhang@intel.com>
Date: Sun, 24 Feb 2008 22:52:45 +0000
Subject: Re: [lm-sensors] The new thermal management sysfs class, and hwmon
Message-Id: <1203893565.10256.21.camel@localhost.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080203022622.GA995@khazad-dum.debian.net>
	 <1202031072.3042.54.camel@acpi-sony.sh.intel.com>
	 <20080203164410.GL20687@jupiter.solarsys.private>
	 <20080203175006.GB9159@khazad-dum.debian.net>
	 <05B550FD4BD2014E841D83547B626008029899FE@bgsmsx411.gar.corp.intel.com>
	 <20080205135725.GO20687@jupiter.solarsys.private>
	 <05B550FD4BD2014E841D83547B626008029BF29B@bgsmsx411.gar.corp.intel.com>
	 <1202915450.7977.607.camel@queen.suse.de>
	 <20080214140855.GB12412@srcf.ucam.org>
	 <1203659229.3210.45.camel@localhost.localdomain><47BE8105.30301@hhs.nl>
	 <1203669206.3210.68.camel@localhost.localdomain><47BEA9CE.7030802@hhs.nl>
	 <20080223092958.5d1c4471@hyperion.delvare>
In-Reply-To: <20080223092958.5d1c4471@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Hans de Goede <j.w.r.degoede@hhs.nl>, Matthew Garrett <mjg59@srcf.ucam.org>, Thomas Renninger <trenn@suse.de>, "Thomas, Sujith" <sujith.thomas@intel.com>, "Mark M. Hoffman" <mhoffman@lightlink.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-acpi@vger.kernel.org, lm-sensors@lm-sensors.org, Len Brown <lenb@kernel.org>, Richard Hughes <hughsient@gmail.com>


On Sat, 2008-02-23 at 16:29 +0800, Jean Delvare wrote:
> On Fri, 22 Feb 2008 11:54:06 +0100, Hans de Goede wrote:
> > Zhang, Rui wrote:
> > > Hi, Hans,
> > >
> > > On Fri, 2008-02-22 at 16:00 +0800, Hans de Goede wrote:
> > >
> > >> I think all that is really needed and asked for is for the new
> thermal
> > >> ACPI
> > >> code to:
> > >> 1) provide temp readings in the same format as hwmon (so milli
> degrees
> > >> celcius,
> > >> not degrees celcius
> > > Agree.
> > >> 2) provide a hwmon interface so that tools like (but not limited
> too):
> > >> * net-snmp
> > >> * mrtg
> > >> * sensors
> > >> * sensors-applet (gnome)
> > >> * xfce-sensors-applet
> > >> * ksysguard
> > >> * ksensors
> > >> * gkrellm
> > >>
> > >> Can provide temp and fan readings without having to be modified.
> > > hmm, for fan device, maybe something like this?
> > > pwm[1-*]_enable = 1 : manual fan control (using pwm[1-*])
> > >               2+: automatic fan control (by acpi thermal driver)
> > > pwm[1-*] = 0  : fan is off.
> > > pwm[1-*] = 255: fan is on.
> > > pwm[1-*] has only two valid values as ACPI fan only support
> > > two states, ON/OFF. and it doesn't need fan[1-*]_input because the
> fan
> > > speed is not available.
> > > Yes, it can work for ACPI fan although I don't think the existing
> pwm
> > > hwmon I/F maps well to what we need and it seems like a "forced
> fit" to
> > > use it. Any better ideas? :)
> > >
> >
> > I wouldn't expose a pwm interface, doing so isn't that important as
> none of the
> > above listed apps actually use it, the pwm interface really only is
> for people
> 
> Note: libsensors itself doesn't care about the pwm files.
> 
> > who want to manually tweak their fan speed and / or use some scripts
> to control
> > the fan speed based on temp when the hardware doesn't support it, as
> such it
> > doesn't get widely used, also since there isn't a really good
> mapping between
> > acpi thermalzone stuff and the hwmon pwm interface I wouldn't add a
> pwm
> > interface to a hwmon interface the the thermal zone code.
> >
> > And if fan speeds aren't available (aren't they?) then I would only
> add a hwmon
> >   class reference to a sysfs dir containing tempX_input's and a name
> atrribute
> > and leave it at that.
> >
> > But thats just my 2 euro-cents
> 
> FWIW, I agree with pretty much everything Hans said.
> 
> Additionally, we could map the critical trip point to tempX_crit
> (read-only).
> 
> Note that since lm-sensors 3.0.1, libsensors accepts hardware
> monitoring attributes in the hwmon "class" device directory, and I
> recommend doing this so as to have a separate namespace. This will
> ensure that we don't get name collisions, and it makes things cleaner
> anyway.
then we'll have have duplicate attributes for temperature and critical
trip point, like:
/sys/class/hwmon/
|hwmon0
	|---name
	|---temp1_input
	|---temp1_crit
	|device		--->/sys/class/thermal/thermal_zone1
		|---type
		|---temp(in millidegree Celsius)
		|---trip_point_0_type:	critical
		|---trip_point_0_temp(in millidegree Celsius)
		...
It's okay if we always keep these them in sync, right?

thanks,
rui


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
