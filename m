From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 18 Jan 2014 12:38:10 +0000
Subject: Re: [lm-sensors] Some questions from first user
Message-Id: <20140118133810.4ff79fe4@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CADR1r6jbaekgXZTJQ7n+5MJW13miQdtbGG=KimEqTT8t2BDKLg@mail.gmail.com>
In-Reply-To: <CADR1r6jbaekgXZTJQ7n+5MJW13miQdtbGG=KimEqTT8t2BDKLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Martin,

On Sat, 18 Jan 2014 11:06:52 +0100, Martin Herrman wrote:
> 2014/1/16 Jean Delvare <khali@linux-fr.org>:
> >> compute temp3 @+10,@+10
> >
> > Preferred way of doing this when the hardware supports it (and the
> > IT8728F does) is:
> >
> >     set temp3_offset 10
> >
> > That being said I am not 100% positive that this works when the
> > temperature sensor type is PECI. You'll have to try it out and see.
>=20
> I have did some testing, but I'm not sure yet what to report. I don't
> have a clear picture with repeatable results yet.
>=20
> Offset values are by default not 0,

It is possible that your BIOS does the right thing and presets the
offsets as appropriate.

> does lm_sensors init script reset
> offset values to default when removed from sensors.conf?,

The lm_sensors init script will typically run "sensors -s" when
starting the service. When stopping the service, it shouldn't change any
setting. "sensors -s" applies all relevant "set" statements in your
sensors.conf configuration files, taking offsets and compute statements
into account.

> should I
> compile sensor drivers as modules? (currently they are in the kernel,
> so my init script fails when it tries to reload the modules),

The init script (and sensors-detect until very recently) assumes that
every driver is a module, so this isn't surprising. Some work is still
needed to ensure a smooth user experience with monolithic kernels. I'm
fixing things slowly in this area, but this isn't a priority.

> sometimes I get negative values for _input when I switch from compute
> to offset statement, why does compute +10 add 20 to reported values?

It shouldn't. This might be an unexpected effect of conflicting set
statements, or offset and compute formula being applied to the same
temperature input, or a bug somewhere. I can't really say without more
details from you: complete configuration section from your chip
from /etc/sensors3.conf and any relevant configuration file
under /etc/sensors.d, output of "sensors", output of "sensors
-c /dev/null", output of "sensors -u".

> Actually, I think my most important question is: how does the compute
> statement work?

Originally the driver gets the raw temperature value reported by the
sensor. Then it applies the offset and presents the result to
user-space (through a sysfs attribute.) Libsensors gets that value and
applies the first half of the compute formula for this channel, and
presents the result to the user.

The second half of the compute formula should always be the inverse
function of the first half, and is applied by libsensors to the
matching set statements.

Let's take an example. You have a temperature sensor (temp1) which
reports a raw value of 50=B0C. If temp1_offset is defined as +5=B0C, the
driver will report temp1_input as 55=B0C.

If you happen to have a compute formula for temp1 such as:

    compute temp1 @+10, @-10

then "sensors" will display a temp1 input value of 65=B0C. The compute
formula applies to the limits as well, so if for example the driver
reported the min limit as 10=B0C and the max limit as 60=B0C, "sensors"
will show 20=B0C and 70=B0C as the limits instead.

In practice you typically use the offset attribute _instead of_ the
compute formula (assuming you only have to apply an offset), because it
is more efficient.

--=20
Jean Delvare
http://jdelvare.nerim.net/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
