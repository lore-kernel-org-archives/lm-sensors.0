From: "Tomas Larsson" <tomas@tlec.se>
Date: Sun, 08 Sep 2013 16:33:28 +0000
Subject: Re: [lm-sensors] Whats wrong with LM-Sensors
Message-Id: <!&!AAAAAAAAAAAYAAAAAAAAAGE4UvMgtwJIpJJKF65P6VPCgAAAEAAAAI4UZsffHD5JtNFllI/bQBsBAAAAAA==@tlec.se>
List-Id: <lm-sensors.vger.kernel.org>
References: <!&!AAAAAAAAAAAYAAAAAAAAAGE4UvMgtwJIpJJKF65P6VPCgAAAEAAAAEchc8MJx35LlZC8CEJITyEBAAAAAA==@tlec.se>
In-Reply-To: <!&!AAAAAAAAAAAYAAAAAAAAAGE4UvMgtwJIpJJKF65P6VPCgAAAEAAAAEchc8MJx35LlZC8CEJITyEBAAAAAA==@tlec.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

lsmod sayas that they are loaded

dmesg
i801_smbus 0000:00:1f.3: PCI INT B -> GSI 19 (level, low) -> IRQ 19
ACPI: resource 0000:00:1f.3 [io  0x2000-0x201f] conflicts with ACPI region
SMB1 [io 0x2000-0x2016]
ACPI: If an ACPI driver is available for this device, you should use it
instead of the native driver
coretemp coretemp.0: Unable to read TjMax from CPU.
coretemp coretemp.0: Unable to read TjMax from CPU.
smsc47m1: Found SMSC LPC47M15x/LPC47M192/LPC47M997
ACPI: resource smsc47m1 [io  0x0680-0x06ff] conflicts with ACPI region RTIO
[io 0x680-0x6ff]
ACPI: If an ACPI driver is available for this device, you should use it
instead of the native driver


With best regards
Tomas Larsson
TL Engineering & Consultants (TLEC)
Engelbrektsgatan 121
SE 50639 Bor=E5s
Sweden
+46 (0)739-932673
tomas@tlec.se
www.tlec.se


> -----Original Message-----
> From: Guenter Roeck [mailto:linux@roeck-us.net]
> Sent: Sunday, September 08, 2013 5:56 PM
> To: Tomas Larsson
> Cc: lm-sensors@lm-sensors.org
> Subject: Re: [lm-sensors] Whats wrong with LM-Sensors
>=20
> On 09/08/2013 07:07 AM, Tomas Larsson wrote:
> > I have 2 motherboards, both of the same type.
> > They are INTEL D945 with ATOM 330 processor.
> > One of them is running CENTOS 5.9, the other one is running CENTOS
> > 6.4, both 32-bit versions
> >
> > After installing lm_sensors and running sensors-detect I have the
> > following output:
> >
> > CENTOS 5.9 sensors version 2.10.7 with libsensors version 2.10.7
> >
> > [root@BLATUNGA ~]# /etc/rc.d/init.d/lm_sensors status
> > smsc47m192-i2c-0-2d
> > Adapter: SMBus I801 adapter at 3000
> > +2.5V:     +2.53 V  (min =3D  +0.00 V, max =3D  +3.32 V)
> > Vcore:     +1.15 V  (min =3D  +0.00 V, max =3D  +2.99 V)
> > +3.3V:     +3.23 V  (min =3D  +0.00 V, max =3D  +4.38 V)
> > +5V:       +4.92 V  (min =3D  +0.00 V, max =3D  +6.64 V)
> > +12V:     +11.94 V  (min =3D  +0.00 V, max =3D +15.94 V)
> > VCC:       +3.25 V  (min =3D  +0.00 V, max =3D  +4.38 V)
> > +1.5V:     +1.56 V  (min =3D  +0.00 V, max =3D  +1.99 V)
> > +1.8V:     +1.76 V  (min =3D  +0.00 V, max =3D  +2.39 V)
> > Chipset Temp:  +44.0=C2=B0C  (low  =3D  -127=C2=B0C, high =3D  +127=C2=
=B0C) CPU Temp:
> > +69.0=C2=B0C  (low  =3D  -127=C2=B0C, high =3D  +127=C2=B0C) System Tem=
p:  +55.0=C2=B0C
> > (low  =3D  -127=C2=B0C, high =3D  +127=C2=B0C)
> > vid:      +2.050 V  (VRM Version 8.2)
> >
> > smsc47m1-isa-0680
> > Adapter: ISA adapter
> > Case Fan:    0 RPM  (min =3D 1280 RPM, div =3D 4)          ALARM
> > CPU Fan:     0 RPM  (min =3D 1280 RPM, div =3D 4)          ALARM
> > [root@BLATUNGA ~]# sensors -v
> > sensors version 2.10.7 with libsensors version 2.10.7 [root@BLATUNGA
> > ~]#
> >
> > CENTOS 6.4 sensors version 3.1.1 with libsensors version 3.1.1
> >
> > [root@seedbox ~]# /etc/rc.d/init.d/lm_sensors status
> > coretemp-isa-0000
> > Adapter: ISA adapter
> > Core 0:      +36.0=C2=B0C  (high =3D +70.0=C2=B0C, crit =3D +90.0=C2=B0=
C)
> > Core 1:      +36.0=C2=B0C  (high =3D +70.0=C2=B0C, crit =3D +90.0=C2=B0=
C)
> > [root@seedbox ~]# sensors -v
> > sensors version 3.1.1 with libsensors version 3.1.1 [root@seedbox ~]#
> >
> >
> > Why is it that the outputs are different, It seems to be impossible to
get
> > the rest of the output in the 3.1.1 version
> >
>=20
> Hard to say without additional information. What is the output of sensors-
> detect ?
> Is it possible that you did not load the smsc47m1 and smsc47m192 modules
> on the
> second system ? What is the output of lsmod ? Is there anything
interesting in
> dmesg ?
>=20
> Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
