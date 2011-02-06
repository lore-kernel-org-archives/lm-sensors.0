From: Daniil Ivanov <daniil.ivanov@gmail.com>
Date: Sun, 06 Feb 2011 17:46:57 +0000
Subject: Re: [lm-sensors] cannot start lm_sensors daemon on Fedora 14 on AMD
Message-Id: <AANLkTin48+JEH+xk1QPmfcF+Eb-XuCboBCVMWB5nCc3F@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <AANLkTim1aYMz+PGQnBLVkcZjmgRKa_HOS86rgQsDM-58@mail.gmail.com>
In-Reply-To: <AANLkTim1aYMz+PGQnBLVkcZjmgRKa_HOS86rgQsDM-58@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Just forgot to mention that adding
HWMON_MODULES=3D"k10temp"
to the /etc/sysconfig/lm_sensors solved the problem,
but I should not edit configuration files manually.

~Daniil.

On Sun, Feb 6, 2011 at 7:35 PM, Daniil Ivanov <daniil.ivanov@gmail.com> wro=
te:
> Hi!
>
> I'm using Fedora 14 and having an issue with lm_sensors deamon.
> Attempt to start it fails.x: lm-sensors <at> lm-sensors <dot> org.
> /etc/init.d/lm_sensors start
> Starting lm_sensors: not configured, run sensors-detect =A0 =A0[WARNING]
>
> Then I use sensors-detect:
>
> # =A0sensors-detect
> # sensors-detect revision 5861 (2010-09-21 17:21:05 +0200)
> # System: Hewlett-Packard HP Pavilion dv6 Notebook PC (laptop)
> # Board: Hewlett-Packard 1440
>
> This program will help you determine which kernel modules you need
> to load to use lm_sensors most effectively. It is generally safe
> and recommended to accept the default answers to all questions,
> unless you know what you're doing.
>
> Some south bridges, CPUs or memory controllers contain embedded sensors.
> Do you want to scan for them? This is totally safe. (YES/no):
> Silicon Integrated Systems SIS5595... =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 No
> VIA VT82C686 Integrated Sensors... =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0No
> VIA VT8231 Integrated Sensors... =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0No
> AMD K8 thermal sensors... =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 No
> AMD Family 10h thermal sensors... =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 Success!
> =A0 =A0(driver `k10temp')
> AMD Family 11h thermal sensors... =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 No
> Intel Core family thermal sensor... =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 No
> Intel Atom thermal sensor... =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0No
> Intel AMB FB-DIMM thermal sensor... =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 No
> VIA C7 thermal sensor... =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0No
> VIA Nano thermal sensor... =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0No
>
> Some Super I/O chips contain embedded sensors. We have to write to
> standard I/O ports to probe them. This is usually safe.
> Do you want to scan for Super I/O sensors? (YES/no):
> Probing for Super-I/O at 0x2e/0x2f
> Trying family `National Semiconductor'... =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 No
> Trying family `SMSC'... =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 No
> Trying family `VIA/Winbond/Nuvoton/Fintek'... =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 No
> Trying family `ITE'... =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0No
> Probing for Super-I/O at 0x4e/0x4f
> Trying family `National Semiconductor'... =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 No
> Trying family `SMSC'... =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 No
> Trying family `VIA/Winbond/Nuvoton/Fintek'... =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 No
> Trying family `ITE'... =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0No
>
> Some hardware monitoring chips are accessible through the ISA I/O ports.
> We have to write to arbitrary I/O ports to probe them. This is usually
> safe though. Yes, you do have ISA I/O ports even if you do not have any
> ISA slots! Do you want to scan the ISA I/O ports? (YES/no):
> Probing for `National Semiconductor LM78' at 0x290... =A0 =A0 =A0 No
> Probing for `National Semiconductor LM79' at 0x290... =A0 =A0 =A0 No
> Probing for `Winbond W83781D' at 0x290... =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 No
> Probing for `Winbond W83782D' at 0x290... =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 No
>
> Lastly, we can probe the I2C/SMBus adapters for connected hardware
> monitoring devices. This is the most risky part, and while it works
> reasonably well on most systems, it has been reported to cause trouble
> on some systems.
> Do you want to probe the I2C/SMBus adapters now? (YES/no):
> Using driver `i2c-piix4' for device 0000:00:14.0: ATI Technologies Inc
> SB600/SB700/SB800 SMBus
> Module i2c-dev loaded successfully.
>
> Next adapter: Radeon i2c bit bus VGA (i2c-0)
> Do you want to scan it? (YES/no/selectively):
>
> Next adapter: Radeon i2c bit bus LVDS (i2c-1)
> Do you want to scan it? (YES/no/selectively):
> Client found at address 0x4f
> Probing for `National Semiconductor LM75'... =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0No
> Probing for `Dallas Semiconductor DS75'... =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0No
> Probing for `Dallas Semiconductor DS1621/DS1631'... =A0 =A0 =A0 =A0 No
> Probing for `Texas Instruments TMP421'... =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 No
> Probing for `Texas Instruments TMP422'... =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 No
> Probing for `Maxim MAX6633/MAX6634/MAX6635'... =A0 =A0 =A0 =A0 =A0 =A0 =
=A0No
> Client found at address 0x50
> Probing for `Analog Devices ADM1033'... =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 No
> Probing for `Analog Devices ADM1034'... =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 No
> Probing for `SPD EEPROM'...
> No
> Probing for `EDID EEPROM'... =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0Yes
> =A0 =A0(confidence 8, not a hardware monitoring chip)
>
> Next adapter: Radeon i2c bit bus LVDS (i2c-2)
> Do you want to scan it? (YES/no/selectively):
>
> Next adapter: Radeon i2c bit bus HDMI (i2c-3)
> Do you want to scan it? (YES/no/selectively):
> Now follows a summary of the probes I have just done.
> Just press ENTER to continue:
>
> Driver `k10temp' (autoloaded):
> =A0* Chip `AMD Family 10h thermal sensors' (confidence: 9)
>
> No modules to load, skipping modules configuration.
>
> Unloading i2c-dev... OK
>
> k10temp is autoloaded module, so my /etc/sysconfig/lm_sensors is empty
> # cat /etc/sysconfig/lm_sensors
> # =A0 =A0/etc/sysconfig/sensors - Defines modules loaded by
> /etc/rc.d/init.d/lm_sensors
> # Run sensors-detect to generate this config file
>
> However, lm_sensors.init checks, if there is an occurrence of
> HWMON_MODULES in /etc/sysconfig/lm_sensors
> http://www.lm-sensors.org/browser/lm-sensors/trunk/prog/init/lm_sensors.i=
nit#L48
> resulting in impossibility to start daemon.
>
> Thanks, Daniil.
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
