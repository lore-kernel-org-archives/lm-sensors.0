From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 26 Oct 2010 10:59:45 +0000
Subject: Re: [lm-sensors] k10temp is detected but not shown
Message-Id: <20101026125945.2dcb20a9@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <578838.74607.qm@web111714.mail.gq1.yahoo.com>
In-Reply-To: <578838.74607.qm@web111714.mail.gq1.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Tue, 26 Oct 2010 03:38:21 -0700 (PDT), Mahmood Naderan wrote:
> I compiled the k10temp driver with these commands:
> mahmood@localhost:k10temp$ sudo make all
> make[1]: Entering directory `/usr/src/linux-headers-2.6.32-25-generic'
> /usr/src/linux-headers-2.6.32-25-generic/arch/x86/Makefile:81: stack prot=
ector=20
> enabled but no compiler support
>   Building modules, stage 2.
>   MODPOST 1 modules
> make[1]: Leaving directory `/usr/src/linux-headers-2.6.32-25-generic'
> mahmood@localhost:k10temp$ sudo make install
> test -d /lib/modules/2.6.32-25-generic/kernel/drivers/hwmon || mkdir=20
> /lib/modules/2.6.32-25-generic/kernel/drivers/hwmon
> cp k10temp.ko /lib/modules/2.6.32-25-generic/kernel/drivers/hwmon
> depmod -a -F /lib/modules/2.6.32-25-generic/build/System.map 2.6.32-25-ge=
neric
>=20
> I then restart the system and check the lsmod:
> mahmood@localhost:k10temp$ sudo lsmod | grep "k10temp"
> k10temp                 3543  0=20
>=20
> the output of "sensors" command is:
> k10temp-pci-00c3
> Adapter: PCI adapter
> temp1:       +28.0=B0C  (high =3D +70.0=B0C, crit =3D +70.0=B0C) =20
>=20
> k10temp-pci-00cb
> Adapter: PCI adapter
> temp1:       +27.0=B0C  (high =3D +70.0=B0C)                 =20
>=20
> k10temp-pci-00d3
> Adapter: PCI adapter
> temp1:       +26.0=B0C  (high =3D +70.0=B0C)                 =20
>=20
> k10temp-pci-00db
> Adapter: PCI adapter
> temp1:       +26.0=B0C  (high =3D +70.0=B0C, crit =3D +70.0=B0C) =20

Surprising that some CPUs have the critical limit and some don't... Do
you have several, different CPU models in your system?

> Is this correct? I should see 16 temperatures.

Why should you?

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
