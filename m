From: "David Mathog" <mathog@caltech.edu>
Date: Sun, 08 Feb 2009 20:42:15 +0000
Subject: Re: [lm-sensors] AMD 690G motherboards?
Message-Id: <E1LWGTn-00066q-HG@mendel.bio.caltech.edu>
List-Id: <lm-sensors.vger.kernel.org>
References: <E1LUlss-0003yf-U8@mendel.bio.caltech.edu>
In-Reply-To: <E1LUlss-0003yf-U8@mendel.bio.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Jean Delvare <khali@linux-fr.org>, wrote:
> On Wed, 04 Feb 2009 09:49:58 -0800, David Mathog wrote:
> >=20
> > Here is the full output of "sensors"
> > acpitz-virtual-0
> > Adapter: Virtual device
> > temp1:        +8.0 =B0C  (crit =3D +75.0 =B0C)                 =20
>=20
> Apparently the ACPI thermal zone reads the temperature from the
> IT8716F's temp1, but it happens to be incorrect. Note that accessing
> the sensors from both ACPI and native drivers is dangerous, so you
> should load either thermal or it87 but not both.

How does one disable this acpitz-virtual-0 method?  sensors is reporting
it, but I don't see that sensors configured it.  /etc/modules only has:

fuse
lp
it87
k8temp

None of which seem related to acpitz-virtual-0

>=20
> > k8temp-pci-00c3
> > Adapter: PCI adapter
> > Core0 Temp:  +10.0 =B0C                                   =20
> > Core0 Temp:   +0.0 =B0C                                   =20
> > Core1 Temp:   -4.0 =B0C                                   =20
> > Core1 Temp:   +1.0 =B0C                                   =20
>=20
> Please see:
> http://www.lm-sensors.org/ticket/2278
> Executive summary: K8 rev. F+ hardware sensors are unreliable, fix in
> 2.6.29 will make the readings look better but still not perfect.

Ok.

>=20
> > it8716-isa-0228

(snip)
> You may also contact the vendor support and ask them
> for additional information.

That would be pretty close to pointless, at least from what I've seen so
far of ECS "support".

> But I suspect this is a hardware problem
> and not much can be done at the software level. If temp1 climbs on CPU
> load then you can add an arbitrary offset to that value and consider it
> a rough approximation of your CPU temperature.

Ok, I'll try that.

Thank you,

David Mathog
mathog@caltech.edu
Manager, Sequence Analysis Facility, Biology Division, Caltech

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
