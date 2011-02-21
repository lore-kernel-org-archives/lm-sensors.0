From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 21 Feb 2011 19:47:53 +0000
Subject: Re: [lm-sensors] [PATCH-v2:RFC][hwmon]:Merging_Pkgtemp_with_Coretemp
Message-Id: <20110221194753.GA10158@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1297637681-1275-1-git-send-email-durgadoss.r@intel.com>
In-Reply-To: <1297637681-1275-1-git-send-email-durgadoss.r@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Mon, Feb 21, 2011 at 04:33:49AM -0500, R, Durgadoss wrote:
> Hi Guenter,
>=20
> Sorry for the delayed response due to the weekend.
>=20
> > I tried to install your patch, but must have done something wrong - it =
crashes
> > for
> > me with a null pointer access. System is running 2.6.35, so it might no=
t be the
> > driver's fault but something I missed while backporting it.
> >=20
>=20
> Yes. This patch will apply cleanly on any kernel version above 2.6.36-sta=
ble.
> I prefer creating these patches on 2.6.38-rc4.
> I should have specified it while sending the patch..Sorry that I missed i=
t.
>=20
>=20
I applied the patch as-is to the latest kernel as of two hours ago and load=
ed it.
This resulted in a null pointer dereference crash - exactly the same as I g=
ot
when trying with 2.6.35. CPU is i3-540.

> > > +static DEFINE_MUTEX(update_lock);
> > >
> > Not a good idea. You don't want any global variables.
>=20
> Ok. Shall move it back into the structure.
>=20
> > > +/* Attributes per physical CPU */
> > > +static SENSOR_DEVICE_ATTR(name, S_IRUGO, show_name, NULL, DRV_NAME);
> > > +static SENSOR_DEVICE_ATTR(temp1_crit, S_IRUGO, show_tjmax, NULL, 0);
> > > +/* Coretemp attributes */
> > > +static SENSOR_DEVICE_ATTR(temp1_label, S_IRUGO, show_name, NULL, COR=
EID);
> > > +static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL, 0);
> > > +static SENSOR_DEVICE_ATTR(temp1_max, S_IRUGO, show_ttarget, NULL, 0);
> > > +static SENSOR_DEVICE_ATTR(temp1_crit_alarm, S_IRUGO, show_crit_alarm=
, NULL,
> > 0);
> > > +/* Packagetemp attributes */
> > > +static SENSOR_DEVICE_ATTR(temp2_label, S_IRUGO, show_name, NULL,
> > PHYS_PROCID);
> > > +static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, show_temp, NULL, 1);
> > > +static SENSOR_DEVICE_ATTR(temp2_max, S_IRUGO, show_ttarget, NULL, 1);
> > > +static SENSOR_DEVICE_ATTR(temp2_crit_alarm, S_IRUGO, show_crit_alarm=
, NULL,
> > 1);
> > >
> > Still not the right approach here. I could not test the driver, but sin=
ce you
> > only have two sets of sensors it can not do what it is supposed to do i=
f there
> > are multiple cores. Again, we would expect a single instance of the dri=
ver
> > to handle all cores plus the package sensor. Looks like you merged core=
 temp
> > with pkg temp, but you still create an instance of the driver per core.
> > And I am not sure if the package temp now shows up on each core.
>=20
> I think we are missing something here.
>=20
> In 2.6.35 version of the coretemp, there is no #ifdef CONFIG_SMP
> in the probe function. This creates a hwmon device for every core
> Of the CPU. (In fact I verified this in one board that was running
> 2.6.35 kernel. Though the board had only One physical CPU, there were
> two instances of the hwmon device, Created by Coretemp. And both of them
> showed exactly same temperature always.)
> The same board running a 2.6.37 showed only one hwmon device.
> Then I figured out that this is due to the SMP check in the probe
> function. This check eliminates the creation of redundant coretemp attrib=
utes.
> (These were created for all cores in a Physical CPU in older kernels)
> Hence, in newer kernels, there will be one set of attributes(temp1*) for =
all cores
> in a Physical CPU created by Coretemp and other set (temp2*) of attribute=
s for PKG temp.
>=20
> Kindly correct me if I am wrong.
>=20
Yes, you are. With a 4-core CPU, the assumption is that there would be eith=
er four=20
or five tempX_input attributes, one per core plus optionally another one fo=
r the package.
Your code only has temp1_input and temp2_input, thus it can not do what we =
expected to see
from the merged driver. This has nothing to do with CONFIG_SMP.

There is supposed to be one temperature reading per physical core.
On 2.6.38-r55+, output with i3-540 is

coretemp-isa-0000
Adapter: ISA adapter
Core 0:       +16.0=B0C  (high =3D +89.0=B0C, crit =3D +105.0=B0C)

coretemp-isa-0002
Adapter: ISA adapter
Core 2:       +23.0=B0C  (high =3D +89.0=B0C, crit =3D +105.0=B0C)

Again, expected output would be along the line of=20

coretemp-isa-0000
Adapter: ISA adapter
Core 0:       +16.0=B0C  (high =3D +89.0=B0C, crit =3D +105.0=B0C)
Core 2:       +23.0=B0C  (high =3D +89.0=B0C, crit =3D +105.0=B0C)

ie there should be only one instance of the driver instead of two for the t=
wo cores.
You don't see Core 1 and Core 3 because those are virtual (hyperthreading) =
cores,
not physical cores. This is the effect you are talking about above
(ie the change affects physical vs. virtual cores, not physical CPUs).

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
