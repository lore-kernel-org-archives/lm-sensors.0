From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 20 Apr 2008 20:33:59 +0000
Subject: Re: [lm-sensors] lm-sensors dme1737 driver
Message-Id: <20080420223359.78184a8d@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0804191351p1459f2c2g8d61e0170e32262e@mail.gmail.com>
In-Reply-To: <191fb4ca0804191351p1459f2c2g8d61e0170e32262e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Juerg, hi Antonio,

On Sun, 20 Apr 2008 12:00:39 -0700, Juerg Haefliger wrote:
> On Sun, Apr 20, 2008 at 1:07 AM, Antonio Exp=F3sito <aelorenzo@gmail.com>=
 wrote:
> > So I decided to restart server because I was making a lot of testing wi=
th
> > ipmi and sensors last day.
> >
> > Now, everything is fine (but it is only by now, later we recover the ra=
re
> > behaviour):
> >
> > eye4:~# sensors
> > k8temp-pci-00c3
> > Adapter: PCI adapter
> > Core0 Temp:  +28.0=B0C
> > Core1 Temp:  +31.0=B0C
> >
> > dme1737-i2c-0-2e
> > Adapter: SMBus nForce2 adapter at 1c00
> > V5stby:      +2.61 V  (min =3D  +0.00 V, max =3D  +6.64 V)
> > Vccp:        +1.38 V  (min =3D  +0.00 V, max =3D  +2.99 V)
> > V3.3:        +3.38 V  (min =3D  +0.00 V, max =3D  +4.38 V)
> >
> >  V5:          +5.07 V  (min =3D  +0.00 V, max =3D  +6.64 V)
> > V12:        +11.95 V  (min =3D  +0.00 V, max =3D +15.94 V)
> >
> > V3.3stby:    +3.32 V  (min =3D  +0.00 V, max =3D  +4.38 V)
> > Vbat:        +3.02 V  (min =3D  +0.00 V, max =3D  +4.38 V)
> >  CPU_Fan:    9591 RPM  (min =3D  800 RPM)
> > Fan2:       2952 RPM  (min =3D  800 RPM)
> > Fan3:       4147 RPM  (min =3D  800 RPM)
> > Fan4:       9326 RPM  (min =3D  800 RPM)
> > RD1 Temp:    +39.2=B0C  (low  =3D -20.0=B0C, high =3D +80.0=B0C)
> >  Int Temp:    +27.2=B0C  (low  =3D -20.0=B0C, high =3D +60.0=B0C)
> > CPU Temp:    +24.1=B0C  (low  =3D -20.0=B0C, high =3D +60.0=B0C)
> >
> > cpu0_vid:   +1.550 V
> >
> >
> > Only a big temperature offset between k8 and dme drivers, May I calibra=
te it
> > using as reference ipmitool readings?
>=20
> Some AMD chips are broken and report incorrect temps via the k8
> driver. You have to ignore those values and trust ipmi or the dme1737
> driver. (...)

Broken AMD K8s usually report way weirder temperatures. The ones
reported above look relatively sane in comparison. Just because they
don't match exactly what the DME1737 reports doesn't mean they are
wrong.

> > (...)
> > Is there any way to know the moduled loading sequence?
>=20
> Not that I'm aware of. Watch the log for driver messages.

lsmod (and /proc/modules) list the modules in reverse order of loading
(i.e. last loaded is listed first, first loaded is listed last.)

> > (...)
> > AAAAAAAAAAAAAGGGGGGGGGGGGGGGGGG!!!!!!!!!!!!!!!!!!
> >
> > Same bogus readings, two chips!
> >
> > Is it random?
>=20
> I don't think it's random we just don't know yet what causes this
> behavior. My guess is it's the ipmi driver.

My own random guess is that the IPMI hardware module is bridging the 2
SMBuses. Maybe the driver is incorrectly instructing it to do so, I
really don't know anything about IPMI so I don't know how realistic my
guess is.

Anyway, using IPMI together with native hardware monitoring drivers
doesn't make sense, so I would advise that you just don't do it.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
