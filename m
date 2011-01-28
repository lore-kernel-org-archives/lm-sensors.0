From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 28 Jan 2011 09:39:09 +0000
Subject: Re: [lm-sensors] Identifying i2c devices on Asus P8P67 sandybridge
Message-Id: <20110128103909.46ceb3f6@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4D40E39E.4030406@cfl.rr.com>
In-Reply-To: <4D40E39E.4030406@cfl.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Phillip,

On Thu, 27 Jan 2011 13:47:39 -0500, Phillip Susi wrote:
> On 1/27/2011 12:14 PM, Jean Delvare wrote:
> > I wholeheartedly agree that pwmconfig and fancontrol suck. They are
> > afternoon hacks that have grown too old, and I wouldn't recommend
> > anyone to use them. I wish someone interested would write a proper tool
> > (i.e. not written in bash to start with) to deal with manual fan speed
> > control. And automatic fan speed control, too.
>=20
> Frequency control started off in user space too, then moved to the
> kernel.  Maybe it is time for the same to be done with fan speed.  A
> generic fan control driver could be written to interface with the hwmon
> devices.

Well, if you thought that the CPU frequency scaling case was difficult
and that explained why it took so long to get right, please realize
that thermal regulation is one order of magnitude more complex.

> The problem is that it still would require manual configuration of which
> temperature sensors should govern which fan pwm controls, since the
> platform does not provide that information.

Yes, this is the problem exactly. Except for embedded design and vendor
machines (e.g. Apple), the kernel has no clue how fan inputs, fan
outputs and temperature inputs relate to each other. Nor does it have a
clue on what each temperature sensor is measuring, or which part of the
machine each fan is cooling.

This is the reason why configuration is difficult, and why it has to
happen in user-space. The only way this could be addressed in the PC
world is if ACPI (or any similarly broadly adopted specification) was
to give vendors a way to describe all these relations in a simple and
unambiguous way. But then again I don't expect it to happen anytime
soon, as PC board manufacturers use their proprietary tuning software
as differentiators on the market.

OTOH, I strongly believe that thermal management should NOT be
OS-dependent in the first place. We have chips which can do automatic
fan speed control, it's up to the BIOS to program them at start-up to
avoid any overheating of the system. Letting the user select a profile
(as Asus is doing) is nice, and as long as the BIOS does its job
properly and gives enough flexibility, it should be enough in practice
for 95% of the users. Fine-tuning at run-time would be nice to have,
but I don't expect my parents to use it. Maybe not even me.

> > And even with the two statements above, I still claim that native
> > hwmon drivers are doing a much better job than any ACPI implementation
> > I've seen. And don't believe it makes me happy: I would love all
> > systems to have hardware monitoring support working out of the box
> > thanks to a brilliant ACPI specification and no-less brilliant
> > implementations. But I don't expect this to happen any time soon :(
>=20
> Indeed.  It seems to me that vendors just don't care to do it right in
> the standard way since they can just ship a windows driver that will
> make 99% of their customers happy.

Sad but true :(

> That is another reason I was
> wondering about doing it with an SSDT.  If I could, it would show
> clearly that it CAN be done, and pressure could be put on vendors to
> start doing it the right way.

Sure, but I'm not holding my breath. Once I reported to a board vendor
(Jetway) that their TZ code was reading the temperature from the wrong
register, returning a constant 9=B0C instead of the actual temperature
value. It would have been fixed with changing one constant in the DSDT.
I never got any reply, and they never fixed it.

But well, one can certainly hope that some vendors are better than
others, and dream that the trend is for them to get more open to their
customers.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
