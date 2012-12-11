From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 11 Dec 2012 09:55:59 +0000
Subject: Re: [lm-sensors] Fried CPU?
Message-Id: <20121211105559.753b38bc@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <201212101840.qBAIe73K013644@mx1.lsn.net>
In-Reply-To: <201212101840.qBAIe73K013644@mx1.lsn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Leslie,

On Mon, 10 Dec 2012 12:40:07 -0600, Leslie Rhorer wrote:
> I fear I know the answer to this question before I ever ask it, but I'm
> going to ask anyway, just in case there is a better answer out there.
>=20
> 	I purchased a used AMD Phenom II x 6 CPU and installed it along with
> a water cooling system in one of my servers.  It was working perfectly,
> except that the sensors binary evidently does not support alarms for the
> atk0110-acpi-0 interface, so I could not trivially implement a shutdown in
> the case of cooling failure, and like an idiot I didn't take the time to
> write an interface at the time.  I put it on the back burner.  Unfortunat=
ely
> that burner was the CPU itself and it was lit three weeks later when the
> cooling pump failed while I was at work.  I came home to a CPU whose
> temperature was 101=B0C, and had failed processing several times during t=
he
> day.  Most of the fluid was boiled away inside the coolant feed tubes, and
> had I been gone longer, the CPU temp would have gone through the roof.  In
> any case, I pulled the water cooler and put the old aluminum fin cooler b=
ack
> on.  The system came up, and seemed to work fine for a couple of more wee=
ks,
> except that the atk0110-acpi-0 sensors were not quite stable.  I did not
> have a monitor on them previously, so had no way to know if this were an
> artifact of the CPU's having been excessively hot for a time, or not.  Wh=
en
> the replacement pump finally came in, I once again installed the water
> cooler and brought the system up.  It only worked for a few minutes, and
> then shut itself down, because the monitor was saying the CPU was
> ridiculously hot.  It was difficult to even get it to bring up the BIOS, =
but
> after letting the system sit without power overnight, I was able to get it
> back up and disable the monitor before it shut down the system again.

CPU temperature issues showing up right after changing the cooling
system usually indicates bad thermal contact between the CPU and the
heatsink (or whatever the equivalent part is for liquid-cooled
systems.) For example missing or improperly applied thermal paste, or
loose mounting.

> 	Processing seems stable, but the chip is reporting absurdly high
> temperatures to the sensors command.  At first boot, it reported a
> reasonable 36=B0C in the BIOS, but after coming up fully, the sensors com=
mand
> is reporting temperatures of 429496652.5=B0C.  It is interesting the chip

You will notice that 429496652.5 is 0xfffffcfd/10 i.e. this looks like a
negative value being improperly displayed as a positive value. This
could either be an error code being improperly processed as actual
data, or a dead thermal sensor.

> reported a correct temperature to the BIOS, but that `sensors` is reporti=
ng
> garbage.

Even more so when using the asus_atk0110 driver, which gets its
readings straight from the BIOS.

> I did run the `sensors-detect` command prior to shutting the
> system down in order to check something.

When did you do that exactly? sensors-detect is known to have caused
serious trouble on a small number of systems, but given the history of
your system this doesn't seem like the prime suspect for your specific
problem.

What motherboard is this? Which version of lm-sensors or sensors-detect
did you use?

> My forlorn hope is that may have
> caused some issue or that there is some other software fix for this.  I
> could run it without CPU temperature monitoring, but with an active cooli=
ng
> system, that does not seem wise.  (Hind sight is 20/20!)  I suppose I cou=
ld
> rig an external temperature probe.  The motherboard does have external
> thermal sensor inputs, but the case of the waterblock is plastic, making =
the
> measurement of the CPU temperature with a thermistor problematical.
>=20
> 	Is it at all possible this CPU is not fried, or that there is some
> software work-around?

I can't think of any workaround. If the weird temperature values
started being reported right after your first pump died, I'd say the
CPU is fried. If it started right after mounting the new pump, I'd say
it was improperly installed.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
