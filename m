From: "Juerg Haefliger" <juergh@gmail.com>
Date: Sat, 07 Jun 2008 19:42:32 +0000
Subject: Re: [lm-sensors] sensors on dell inspiron 1420
Message-Id: <191fb4ca0806071242g4a4068qe66bab7cb389bfa9@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080607135219.GD18192@grulicueva.homelinux.net>
In-Reply-To: <20080607135219.GD18192@grulicueva.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Marcos,


>
>    hi everybody. first of all, I'm not suscribet to the list, so please
> cc: me any answer. I bought one of these laptops and run the latest
> sensors-detect and, besides the coretemp module, it found an unknown
> chip in the smc family:
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D> # sensors-detect revision $Revis=
ion$
>
> This program will help you determine which kernel modules you need
> to load to use lm_sensors most effectively. It is generally safe
> and recommended to accept the default answers to all questions,
> unless you know what you're doing.
>
> We can start with probing for (PCI) I2C or SMBus adapters.
> Do you want to probe now? (YES/no):
> Probing for PCI bus adapters...
> Use driver `i2c-i801' for device 0000:00:1f.3: Intel 82801H ICH8
>
> We will now try to load each adapter module in turn.
> Module `i2c-i801' already loaded.
> If you have undetectable or unsupported I2C/SMBus adapters, you can have
> them scanned by manually loading the modules before running this script.
>
> We are now going to do the I2C/SMBus adapter probings. Some chips may
> be double detected; we choose the one with the highest confidence
> value in that case.
> If you found that the adapter hung after probing a certain address,
> you can specify that address to remain unprobed.
>
> Next adapter: SMBus I801 adapter at 10c0 (i2c-0)
> Do you want to scan it? (YES/no/selectively):
> Client found at address 0x50
> Probing for `Analog Devices ADM1033'...                     No
> Probing for `Analog Devices ADM1034'...                     No
> Probing for `SPD EEPROM'...                                 Yes
>    (confidence 8, not a hardware monitoring chip)
> Probing for `EDID EEPROM'...                                No
> Client found at address 0x52
> Probing for `Analog Devices ADM1033'...                     No
> Probing for `Analog Devices ADM1034'...                     No
> Probing for `SPD EEPROM'...                                 Yes
>    (confidence 8, not a hardware monitoring chip)
> Probing for `EDID EEPROM'...                                No
>
> Some chips are also accessible through the ISA I/O ports. We have to
> write to arbitrary I/O ports to probe them. This is usually safe though.
> Yes, you do have ISA I/O ports even if you do not have any ISA slots!
> Do you want to scan the ISA I/O ports? (YES/no):
> Probing for `National Semiconductor LM78' at 0x290...       No
> Probing for `National Semiconductor LM78-J' at 0x290...     No
> Probing for `National Semiconductor LM79' at 0x290...       No
> Probing for `Winbond W83781D' at 0x290...                   No
> Probing for `Winbond W83782D' at 0x290...                   No
> Probing for `IPMI BMC KCS' at 0xca0...                      No
> Probing for `IPMI BMC SMIC' at 0xca8...                     No
>
> Some Super I/O chips may also contain sensors. We have to write to
> standard I/O ports to probe them. This is usually safe.
> Do you want to scan for Super I/O sensors? (YES/no):
> Probing for Super-I/O at 0x2e/0x2f
> Trying family `National Semiconductor'...                   No
> Trying family `SMSC'...                                     Yes
> Found unknown chip with ID 0x3201
> Probing for Super-I/O at 0x4e/0x4f
> Trying family `National Semiconductor'...                   No
> Trying family `SMSC'...                                     No
> Trying family `VIA/Winbond/Fintek'...                       No
> Trying family `ITE'...                                      No
>
> Some south bridges, CPUs or memory controllers may also contain
> embedded sensors. Do you want to scan for them? (YES/no):
> Silicon Integrated Systems SIS5595...                       No
> VIA VT82C686 Integrated Sensors...                          No
> VIA VT8231 Integrated Sensors...                            No
> AMD K8 thermal sensors...                                   No
> AMD K10 thermal sensors...                                  No
> Intel Core family thermal sensor...                         Success!
>    (driver `coretemp')
> Intel AMB FB-DIMM thermal sensor...                         No
>
> Now follows a summary of the probes I have just done.
> Just press ENTER to continue:
>
> Driver `coretemp' (should be inserted):
>  Detects correctly:
>  * Chip `Intel Core family thermal sensor' (confidence: 9)
>
> Do you want to generate /etc/sysconfig/lm_sensors? (yes/NO): no
> To load everything that is needed, add this to one of the system
> initialization scripts (e.g. /etc/rc.d/rc.local):
>
> #----cut here----
> # Chip drivers
> modprobe coretemp
> /usr/bin/sensors -s
> #----cut here----
>
> If you have some drivers built into your kernel, the list above will
> contain too many modules. Skip the appropriate ones! You really
> should try these commands right now to make sure everything is
> working properly. Monitoring programs won't work until the needed
> modules are loaded.
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D>
>    how do we continue?

Please run the following commands and send the output:
isadump -k 0x55 0x2e 0x2f 0x8
isadump -k 0x55 0x2e 0x2f 0x9
isadump -k 0x55 0x2e 0x2f 0xa

If you can run Windows on this machine, please run SpeedFan
(http://www.almico.com/sfdownload.php), it might tell us what chip
this is.

...juerg


> --
> (Not so) Random fortune:
> 19:01 < e-squizo> yogurt2ungue: por favor, recordame la =FAltima vez que
>    perd=ED datos...
> 19:01 < yogurt2ungue> Fue en el siglo pasado
> 19:02 < yogurt2ungue> Un adm nunca hace cd /dev ; rm -fr *
> 19:02 < e-squizo> yogurt2ungue: un adm bien macho s=ED
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
