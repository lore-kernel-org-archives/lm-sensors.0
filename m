From: "Agarwal, Ramesh" <ramesh.agarwal@intel.com>
Date: Tue, 18 Aug 2009 10:58:22 +0000
Subject: Re: [lm-sensors] Intel Moorestown Analog Accelerometer driver
Message-Id: <DC9628ADC672424FAECF61709E90EDDE5C9FFC78@bgsmsx501.gar.corp.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <c632a690908130147j55df80fbmc96b5bec6f9927b4@mail.gmail.com>
In-Reply-To: <c632a690908130147j55df80fbmc96b5bec6f9927b4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org



> -----Original Message-----
> From: Alex Riesen [mailto:raa.lkml@gmail.com]
> Sent: Monday, August 17, 2009 2:21 PM
> To: Agarwal, Ramesh
> Cc: lm-sensors@lm-sensors.org; Mark Brown
> Subject: Re: Intel Moorestown Analog Accelerometer driver
>=20
> On Mon, Aug 17, 2009 at 10:07, Agarwal, Ramesh<ramesh.agarwal@intel.com>
> wrote:
> >> Ramesh Agarwal says:
> >> > +/* PMIC ADC INTERRUPT REGISTERS */
> >> > +#define PMIC_ADC_ACC_REG_ADCINT =A0 =A0 =A0 =A0 =A0 =A00x5F =A0 =A0=
/*ADC interrupt
> register
> >> */
> >>
> >> Does the accelerometer itself actually provide an interrupt for the
> >> data? Can the interrupt be used?
> >>
> >> The "ADC interrupt register" seem to hint at that.
> >>
> >> Forcing people to poll for interactive data (and that seems to be a
> >> very common use for accelerometers these days) is not very nice.
> > [Agarwal, Ramesh] The accelerometer unfortunately does not have
> > any interrupt. It just gives the voltage for the current value of the g
> > on the three co-ordinates. The Interrupt being referred to is for
> > the ADC. Once the ADC is started it will sample all the channels
> > (including others which are used by other analog devices) in a
> > round robin fashion. The interrupt is raised when one round of
> > sampling completes.
>=20
> So, the kernel could activate the line, but the interrupt will cause
> the ISR be called every sampling cycle irrespective of whether
> the measured g-values have changed?
> Still, it could be interesting to see how the register is programmed:
> maybe someone would like to know the values as soon as possible.
> Maybe someone even implements buffering/filtering of them in the driver,
> so that the sysfs file can send inotify notifications (or even be polled
> with poll(2)).
[Agarwal, Ramesh] You got it right. The interrupt will come no matter what.=
 Also the interrupt will come to the firmware and not directly to the OS si=
nce there are multiple devices using the ADC channels. As of now a read on =
the sysfs attribute will return the last sampled value.
>=20
> >> > +static unsigned int analog_accel_read(int offset)
> ...
> >> > + =A0 if (mrst_pmic_ioread(&ipc_data) !=3D 0) {
> >> > + =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR
> >> > + =A0 =A0 =A0 =A0 =A0 "mrst_analog_accel:PMIC reg read using IPC fai=
led\n");
> >> > + =A0 =A0 =A0 =A0 =A0 return -1;
> >>
> >> You return -1 in a function returning unsigned?
> >> And you don't handle the -1 anyway, so maybe a more useful value can
> >> be returned (like one you'd return when there is no acceleration).
> >> Or you can handle the error more sensibly, and return error (if it's
> >> possible) from sysfs' _show().
> >>
> > [Agarwal, Ramesh] Sending 0xffffffff was kind of my way of indicating an
> > error because the values coming out of the ADC are just 10 bits, so
>=20
> If they are just 10bits, they certainly fit into any int, so you can
> use negative
> values normally.
>=20
> > anything larger than that would indicate that there was an error
> > reading the values.
>=20
> It does not match the sprintf pattern you use.
[Agarwal, Ramesh] I realize that the values are not very explicit right now=
. I will make the modifications to make them a little more explicit.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
