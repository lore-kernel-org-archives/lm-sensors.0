From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 08 Jan 2013 15:18:56 +0000
Subject: Re: [lm-sensors] Help to make lm-sensors work with an Asus TUSL2-C
Message-Id: <20130108161856.22474480@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <50DB2017.8010403@tiscali.it>
In-Reply-To: <50DB2017.8010403@tiscali.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Mauro,

On Tue, 08 Jan 2013 15:54:27 +0100, Mauro Molinari wrote:
> Hi Jean,
> thank you for your help.
>=20
> Il 08/01/2013 14:50, Jean Delvare ha scritto:
> >> Trying family `VIA/Winbond/Nuvoton/Fintek'...               Yes
> >> Found unknown chip with ID 0x5953
> >>       (logical device 9 has address 0x290, could be sensors)
> >
> > Very strange, I wouldn't expected an unknown Super-I/O chip on such an
> > old board. Can you find the chip's name by visual inspection of the
> > board or from the documentation?
>=20
> The documentation (manual) just speaks about an "Asus ASIC" hardware.
> I will visually inspect the mainboard as soon as possible (I can't right =

> now).

"Asus ASIC" most certainly refers to the AS99127F, which isn't a
Super-I/O chip. I think you'll see another chip on the board when you
get to inspect it.

>=20
> > The above message means that sensors-detect knows which driver should
> > be used for the ICH2 SMBus. That doesn't mean the driver did
> > successfully bind to the device. And if device binding failed (as the
> > log messages pasted above suggest) then scanning isn't possible.
> >
> > The AS99127F is an SMBus chip. Please boot with
> > acpi_enforce_resources=3Dlax and run sensors-detect again, it should fi=
nd
> > your AS99127F chip then.
>=20
> Well, strange enough, I added the acpi_enforce_resources=3Dlax to the=20
> Kernel boot options, as dmesg demonstrates:
> [    0.000000] Kernel command line:=20
> BOOT_IMAGE=3D/boot/vmlinuz-2.6.32-5-686=20
> root=3DUUID=3D7034614e-0226-481e-99cb-9fe0789f0a57 ro quiet nomodeset=20
> acpi_enforce_resources=3Dlax
>=20
> However, the "conflict" message is still displayed:

Yes, that's what lax does. Pass acpi_enforce_resources=3Dno if you don't
want to see the warning.

> [   10.478084] i801_smbus 0000:00:1f.3: PCI INT B -> GSI 17 (level, low) =

> -> IRQ 17
> [   10.478099] ACPI: I/O resource 0000:00:1f.3 [0xe800-0xe80f] conflicts =

> with ACPI region SM00 [0xe800-0xe806]
> [   10.478105] ACPI: This conflict may cause random problems and system=20
> instability
> [   10.478110] ACPI: If an ACPI driver is available for this device, you =

> should use it instead of the native driver
>=20
> Nonetheless, now the sensors-detect script does find something:
> Probing for `Asus AS99127F (rev.1)'...                      Success!
>      (confidence 8, driver `w83781d', other addresses: 0x48 0x49)
> [...]
> Driver `w83781d':
>    * Bus `SMBus I801 adapter at e800'
>      Busdriver `i2c_i801', I2C address 0x2d (and 0x48 0x49)
>      Chip `Asus AS99127F (rev.1)' (confidence: 8)
>=20
> So, first question: am I forced to use the acpi_enforce_resources=3Dlax=20
> option to use lm_sensors on my system? No other option? (I read this is=20
> not optimal)

On such an old system, I doubt there is any other solution. I also
don't expect any problem with acpi_enforce_resources=3Dlax or no. After
all, "no" is the behavior the kernel had back then.

> Now, the sensors-detect script downloaded from=20
> http://www.lm-sensors.org/wiki/iwizard/NoSensorsDetected asks me to=20
> create /etc/sysconfig/lm_sensors: I reply "YES" and then I try to run=20
> "sensors", but it says it does not find any sensors. However, it does=20
> work after I run "modprobe w83781d".
>=20
> So, second question: what is /etc/sysconfig/lm_sensors for? I do have=20
> /etc/init.d/lm-sensors in my system (it's a Debian-based distribution)=20
> but even if I do a "/etc/init.d/lm-sensors restart", I still need to=20
> "modprobe w83781d" before being able to use "sensors". Maybe there's=20
> some Debian-specific way to do the same thing (instead of using=20
> /etc/sysconfig/lm_sensors)?

Don't use the script you downloaded, use the one provided by Debian
instead, and everything will be fine. The only reason for using the
latest version is for very recent hardware, which isn't your case at
all.

> Finally, among the output of sensors I find:
> CPU Temp:     +5.5=B0C  (high =3D +100.0=B0C, hyst =3D +92.0=B0C)
> which sounds quite funny. I think this has something to do with the=20
> configuration. I created the file /etc/sensors.d/asus.conf, by copying=20
> the example configuration file and uncommenting the sections that are=20
> meant for Asus TUSL2-C. But I'm not sure that this file is taken into=20
> consideration.
>
> Third question: is this asus.conf taken by sensors? Or do I have to=20
> specify a command-line parameter to sensors in order to take it? I read=20

It should be taken into consideration, yes. If you don't see any
effect, this may mean that you got the "chip" line wrong so the whole
section is ignored for your chip.

> the documentation on the lm_sensors wiki and the man page, but it's not=20
> clear to me whether configuration files in /etc/sensors.d should have=20
> specific names or whether any any name is ok (and configuration files=20
> are all automatically found and used by sensors command).

Any name is OK (for now.)

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
