From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 26 Oct 2010 13:21:56 +0000
Subject: Re: [lm-sensors] k10temp is detected but not shown
Message-Id: <20101026152156.0f407f80@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <578838.74607.qm@web111714.mail.gq1.yahoo.com>
In-Reply-To: <578838.74607.qm@web111714.mail.gq1.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Please keep Clemens Cc'd, he wrote the k10temp driver.

On Tue, 26 Oct 2010 06:06:53 -0700 (PDT), Mahmood Naderan wrote:
> >Please provide the output of:
> >lspci -xxx -d 1022:1203
>=20
> mahmood@localhost:~$ lspci -xxx -d 1022:1203
> 00:18.3 Host bridge: Advanced Micro Devices [AMD] K10 [Opteron, Athlon64,=
=20
> Sempron] Miscellaneous Control
> 00: 22 10 03 12 00 00 10 00 00 00 00 06 00 00 80 00
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 30: 00 00 00 00 f0 00 00 00 00 00 00 00 00 00 00 00
> 00:19.3 Host bridge: Advanced Micro Devices [AMD] K10 [Opteron, Athlon64,=
=20
> Sempron] Miscellaneous Control
> 00: 22 10 03 12 00 00 10 00 00 00 00 06 00 00 80 00
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 30: 00 00 00 00 f0 00 00 00 00 00 00 00 00 00 00 00
> 00:1a.3 Host bridge: Advanced Micro Devices [AMD] K10 [Opteron, Athlon64,=
=20
> Sempron] Miscellaneous Control
> 00: 22 10 03 12 00 00 10 00 00 00 00 06 00 00 80 00
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 30: 00 00 00 00 f0 00 00 00 00 00 00 00 00 00 00 00
> 00:1b.3 Host bridge: Advanced Micro Devices [AMD] K10 [Opteron, Athlon64,=
=20
> Sempron] Miscellaneous Control
> 00: 22 10 03 12 00 00 10 00 00 00 00 06 00 00 80 00
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 30: 00 00 00 00 f0 00 00 00 00 00 00 00 00 00 00 00

Sorry, I forgot to mention that you had to run this command as root.
Once again please.

> One more question, Is it possible to find out which two modules are tied =
to one=20
> processor?

Modules?

> Currently there are:
> k10temp-pci-00c3
> Adapter: PCI adapter
> temp1:=A0=A0=A0=A0=A0=A0 +27.0=B0C=A0 (high =3D +70.0=B0C, crit =3D +70.0=
=B0C)
> k10temp-pci-00cb
> Adapter: PCI adapter
> temp1:=A0=A0=A0=A0=A0=A0 +27.0=B0C=A0 (high =3D +70.0=B0C)
> k10temp-pci-00d3
> Adapter: PCI adapter
> temp1:=A0=A0=A0=A0=A0=A0 +26.0=B0C=A0 (high =3D +70.0=B0C)
> k10temp-pci-00db
> Adapter: PCI adapter
> temp1:=A0=A0=A0=A0=A0=A0 +26.0=B0C=A0 (high =3D +70.0=B0C, crit =3D +70.0=
=B0C)
> =A0
> Is it true that [00c3 and 00cb] are for one physical cpu and [00d3 and=A0=
00db] are=20
> for the other cpu?

I have no idea, sorry. All the k10temp driver sees are PCI devices, it
doesn't know about the CPUs behind them.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
