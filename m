From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 15 Jun 2008 07:35:13 +0000
Subject: Re: [lm-sensors] [Bug?] W83697: Broken readings for fan speed 10%
Message-Id: <20080615093513.3ce0002d@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080531220339.05dc83fd@neptune.home>
In-Reply-To: <20080531220339.05dc83fd@neptune.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Bruno,

On Sat, 14 Jun 2008 23:24:53 +0200, Bruno Pr=E9mont wrote:
> On Mon, 02 June 2008 Jean Delvare <khali@linux-fr.org> wrote:
> > One patch you may want to apply it this one:
> >   http://lists.lm-sensors.org/pipermail/lm-sensors/2008-May/023189.html
> > It will let you switch the W83697HG chip from automatic fan speed
> > control to manual control and back - might be useful to investigate
> > the issue you have.
>=20
> For automatic fan speed control (not limited to this chip), how much
> can automatic control be configured?

Depends on the chip and driver, as you might have expected.

> Some configuration options I do think about:
> - temperature thresholds
>   (e.g. to choose balance between cool and silent)
> - link between temperature input and controlled fan
>=20
> Are such features provided by the chips (chips of direct interest to me
> are IT8712F, nforce420, [W83697HG])

Have you read Documentation/hwmon/it87 and Documentation/hwmon/w83627hf
already? As far as I remember, both the it87 driver and the w83627hf
driver only allow switching from manual control to automatic control
and back. Neither gives control over the automatic mode settings. Both
families of chips can do it though, it's a driver issue.

I am not aware of the nforce420 having fan speed control capabilities.
If it does, we have no driver for it.

> Depending on what chips are capable of, how much of it does lm_sensors
> implement and how is it expected to be used?

For hardware-controlled fan speed, lm-sensors as a user-space package
doesn't matter. It's up to you to setup the chip in your BIOS (if it
allows this) or by writing to the driver's sysfs files (if it allows
this.)

For software-controlled fan speed, we have a little bash daemon named
fancontrol (and its helper configuration script named pwmconfig). This
should work with pretty much every hardware monitoring chip driver,
including it87 and w83627hf, and gives you control on temperature
thresholds and links between fan input, fan output and temperature
input channels.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

