From: Roman Mamedov <roman@rm.pp.ru>
Date: Sun, 28 Feb 2010 22:25:08 +0000
Subject: [lm-sensors] ASUS CUSL2: sensors work with 2.6.30, don't with 2.6.33
Message-Id: <20100301032508.0f41a581@natsu>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============1999196112549713138=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============1999196112549713138==
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/nMNgR69xIwmW8WdXvu3Of7n"; protocol="application/pgp-signature"

--Sig_/nMNgR69xIwmW8WdXvu3Of7n
Content-Type: multipart/mixed; boundary="MP_/b7_+eWl2kdRqLaOwD1iLGm="

--MP_/b7_+eWl2kdRqLaOwD1iLGm=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello.

I have a Pentium III with ASUS CUSL2 motherboard. When it is booted into
the kernel 2.6.30, the sensors are detected and work fine. But when the ker=
nel
is 2.6.33, no sensors are detected. I did not try any kernel versions in
between for now. Any idea what could be the cause? Attaching sensors-detect
outputs from under both kernels.

--=20
With respect,
Roman

--MP_/b7_+eWl2kdRqLaOwD1iLGm=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename=sensors-2.6.30.txt

# sensors-detect
# sensors-detect revision 5818 (2010-01-18 17:22:07 +0100)
# Board: ASUSTeK Computer INC. CUSL2

This program will help you determine which kernel modules you need
to load to use lm_sensors most effectively. It is generally safe
and recommended to accept the default answers to all questions,
unless you know what you're doing.

Some south bridges, CPUs or memory controllers contain embedded sensors.
Do you want to scan for them? This is totally safe. (YES/no):=20
Silicon Integrated Systems SIS5595...                       No
VIA VT82C686 Integrated Sensors...                          No
VIA VT8231 Integrated Sensors...                            No
AMD K8 thermal sensors...                                   No
AMD Family 10h thermal sensors...                           No
AMD Family 11h thermal sensors...                           No
Intel Core family thermal sensor...                         No
Intel Atom thermal sensor...                                No
Intel AMB FB-DIMM thermal sensor...                         No
VIA C7 thermal sensor...                                    No
VIA Nano thermal sensor...                                  No

Some Super I/O chips contain embedded sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no):=20
Probing for Super-I/O at 0x2e/0x2f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Nuvoton/Fintek'...               Yes
Found unknown chip with ID 0x8700
    (logical device 9 has address 0x290, could be sensors)
Probing for Super-I/O at 0x4e/0x4f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Nuvoton/Fintek'...               No
Trying family `ITE'...                                      No

Some systems (mainly servers) implement IPMI, a set of common interfaces
through which system health data may be retrieved, amongst other things.
We first try to get the information from SMBIOS. If we don't find it
there, we have to read from arbitrary I/O ports to probe for such
interfaces. This is normally safe. Do you want to scan for IPMI
interfaces? (YES/no):=20
Probing for `IPMI BMC KCS' at 0xca0...                      No
Probing for `IPMI BMC SMIC' at 0xca8...                     No

Some hardware monitoring chips are accessible through the ISA I/O ports.
We have to write to arbitrary I/O ports to probe them. This is usually
safe though. Yes, you do have ISA I/O ports even if you do not have any
ISA slots! Do you want to scan the ISA I/O ports? (YES/no):=20
Probing for `National Semiconductor LM78' at 0x290...       No
Probing for `National Semiconductor LM79' at 0x290...       No
Probing for `Winbond W83781D' at 0x290...                   No
Probing for `Winbond W83782D' at 0x290...                   No

Lastly, we can probe the I2C/SMBus adapters for connected hardware
monitoring devices. This is the most risky part, and while it works
reasonably well on most systems, it has been reported to cause trouble
on some systems.
Do you want to probe the I2C/SMBus adapters now? (YES/no):=20
Using driver `i2c-i801' for device 0000:00:1f.3: Intel 82801BA ICH2
Module i2c-dev loaded successfully.

Next adapter: SMBus I801 adapter at e800 (i2c-0)
Do you want to scan it? (YES/no/selectively):=20
Client found at address 0x2d
Handled by driver `w83781d' (already loaded), chip type `as99127f'
Client found at address 0x48
Handled by driver `i2c_core' (already loaded), chip type `dummy'
    (note: this is probably NOT a sensor chip!)
Client found at address 0x49
Handled by driver `i2c_core' (already loaded), chip type `dummy'
    (note: this is probably NOT a sensor chip!)

Now follows a summary of the probes I have just done.
Just press ENTER to continue:=20

Driver `w83781d':
  * Bus `SMBus I801 adapter at e800'
    Busdriver `i2c_i801', I2C address 0x2d
    Chip `as99127f' (confidence: 6)

To load everything that is needed, add this to /etc/modules:
#----cut here----
# Chip drivers
w83781d
#----cut here----
If you have some drivers built into your kernel, the list above will
contain too many modules. Skip the appropriate ones!

Do you want to add these lines automatically to /etc/modules? (yes/NO)NO

Unloading i2c-dev... OK

# sensors
as99127f-i2c-0-2d
Adapter: SMBus I801 adapter at e800
in0:         +1.66 V  (min =3D  +1.46 V, max =3D  +1.84 V)  =20
in1:         +1.66 V  (min =3D  +2.24 V, max =3D  +2.74 V)   ALARM
in2:         +3.28 V  (min =3D  +2.96 V, max =3D  +3.62 V)  =20
in3:         +2.91 V  (min =3D  +2.67 V, max =3D  +3.26 V)  =20
in4:         +3.10 V  (min =3D  +2.40 V, max =3D  +3.58 V)  =20
in5:         +2.90 V  (min =3D  +2.42 V, max =3D  +3.62 V)  =20
in6:         +3.17 V  (min =3D  +2.66 V, max =3D  +3.98 V)  =20
fan1:          0 RPM  (min =3D    0 RPM, div =3D 2)
fan2:          0 RPM  (min =3D    0 RPM, div =3D 2)
fan3:          0 RPM  (min =3D    0 RPM, div =3D 2)
temp1:       +32.0=C2=B0C  (high =3D +105.0=C2=B0C, hyst =3D  +0.0=C2=B0C) =
=20
temp2:       +23.5=C2=B0C  (high =3D +100.0=C2=B0C, hyst =3D +92.0=C2=B0C) =
=20
temp3:       -31.5=C2=B0C  (high =3D +122.0=C2=B0C, hyst =3D +121.0=C2=B0C)=
 =20
cpu0_vid:   +1.650 V
beep_enable:enabled

--MP_/b7_+eWl2kdRqLaOwD1iLGm=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename=sensors-2.6.33.txt

# sensors-detect=20
# sensors-detect revision 5818 (2010-01-18 17:22:07 +0100)
# Board: ASUSTeK Computer INC. CUSL2

This program will help you determine which kernel modules you need
to load to use lm_sensors most effectively. It is generally safe
and recommended to accept the default answers to all questions,
unless you know what you're doing.

Some south bridges, CPUs or memory controllers contain embedded sensors.
Do you want to scan for them? This is totally safe. (YES/no):=20
Silicon Integrated Systems SIS5595...                       No
VIA VT82C686 Integrated Sensors...                          No
VIA VT8231 Integrated Sensors...                            No
AMD K8 thermal sensors...                                   No
AMD Family 10h thermal sensors...                           No
AMD Family 11h thermal sensors...                           No
Intel Core family thermal sensor...                         No
Intel Atom thermal sensor...                                No
Intel AMB FB-DIMM thermal sensor...                         No
VIA C7 thermal sensor...                                    No
VIA Nano thermal sensor...                                  No

Some Super I/O chips contain embedded sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no):=20
Probing for Super-I/O at 0x2e/0x2f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Nuvoton/Fintek'...               Yes
Found unknown chip with ID 0x8700
    (logical device 9 has address 0x290, could be sensors)
Probing for Super-I/O at 0x4e/0x4f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Nuvoton/Fintek'...               No
Trying family `ITE'...                                      No

Some systems (mainly servers) implement IPMI, a set of common interfaces
through which system health data may be retrieved, amongst other things.
We first try to get the information from SMBIOS. If we don't find it
there, we have to read from arbitrary I/O ports to probe for such
interfaces. This is normally safe. Do you want to scan for IPMI
interfaces? (YES/no):=20
Probing for `IPMI BMC KCS' at 0xca0...                      No
Probing for `IPMI BMC SMIC' at 0xca8...                     No

Some hardware monitoring chips are accessible through the ISA I/O ports.
We have to write to arbitrary I/O ports to probe them. This is usually
safe though. Yes, you do have ISA I/O ports even if you do not have any
ISA slots! Do you want to scan the ISA I/O ports? (YES/no):=20
Probing for `National Semiconductor LM78' at 0x290...       No
Probing for `National Semiconductor LM79' at 0x290...       No
Probing for `Winbond W83781D' at 0x290...                   No
Probing for `Winbond W83782D' at 0x290...                   No

Lastly, we can probe the I2C/SMBus adapters for connected hardware
monitoring devices. This is the most risky part, and while it works
reasonably well on most systems, it has been reported to cause trouble
on some systems.
Do you want to probe the I2C/SMBus adapters now? (YES/no):=20
Using driver `i2c-i801' for device 0000:00:1f.3: Intel 82801BA ICH2

Sorry, no sensors were detected.
Either your system has no sensors, or they are not supported, or
they are connected to an I2C or SMBus adapter that is not
supported. If you find out what chips are on your board, check
http://www.lm-sensors.org/wiki/Devices for driver status.

--MP_/b7_+eWl2kdRqLaOwD1iLGm=--

--Sig_/nMNgR69xIwmW8WdXvu3Of7n
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkuK7UQACgkQTLKSvz+PZwj6eACgkJgf8PWE9N2B9Htv1pHjRYLQ
RY4An1E/7g/azdVB0UX/NWwHT/eSJTuK
=rBT+
-----END PGP SIGNATURE-----

--Sig_/nMNgR69xIwmW8WdXvu3Of7n--


--===============1999196112549713138==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============1999196112549713138==--
