From: "Juerg Haefliger" <juergh@gmail.com>
Date: Wed, 09 Jul 2008 17:05:22 +0000
Subject: Re: [lm-sensors] Unknown sensors on HP Compaq nx7400
Message-Id: <191fb4ca0807091005i6c433caeh6c3374da7b174675@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Alessandro,

Sorry for the late reply.


> Hi guys,
>
> I'm using Linux Arch on my business laptop.

What model?


>  I can read temperatures
> through ACPI and the coretemp driver seems to work good but
> sensor-detect shows two additional unknown sensors. Here is the
> sensors-detect output:
>
> [alessandro@blackmoon Desktop]$ sudo sensors-detect
> # sensors-detect revision 5249 (2008-05-11 22:56:25 +0200)
>
> This program will help you determine which kernel modules you need
> to load to use lm_sensors most effectively. It is generally safe
> and recommended to accept the default answers to all questions,
> unless you know what you're doing.
>
> We can start with probing for (PCI) I2C or SMBus adapters.
> Do you want to probe now? (YES/no):
> Probing for PCI bus adapters...
> Sorry, no supported PCI bus adapters found.
>
> If you have undetectable or unsupported I2C/SMBus adapters, you can have
> them scanned by manually loading the modules before running this script.
>
> To continue, we need module `i2c-dev' to be loaded.
> Do you want to load `i2c-dev' now? (YES/no):
> Module loaded successfully.
>
> We are now going to do the I2C/SMBus adapter probings. Some chips may
> be double detected; we choose the one with the highest confidence
> value in that case.
> If you found that the adapter hung after probing a certain address,
> you can specify that address to remain unprobed.
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
> Found unknown chip with ID 0x2600

Yes, we don't know this chip.


> Probing for Super-I/O at 0x4e/0x4f
> Trying family `National Semiconductor'...                   No
> Trying family `SMSC'...                                     Yes
> Found unknown non-standard chip with ID 0x7a

That's probably just a misdetection of the previous chip.

Please run the following commands and send the output
isadump -k 0x55 0x2e 0x2f 0x8
isadump -k 0x55 0x2e 0x2f 0x9
isadump -k 0x55 0x2e 0x2f 0xa

...juerg




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
> Do you want to generate /etc/sysconfig/lm_sensors? (yes/NO): yes
> Copy prog/init/lm_sensors.init to /etc/init.d/lm_sensors
> for initialization at boot time.
> You should now start the lm_sensors service to load the required
> kernel modules.
>
> [alessandro@blackmoon Desktop]$ sudo modprobe coretemp
> [alessandro@blackmoon Desktop]$ sensors
> coretemp-isa-0000
> Adapter: ISA adapter
> Core 0:      +54.0=B0C  (crit =3D +100.0=B0C)
>
> coretemp-isa-0001
> Adapter: ISA adapter
> Core 1:      +55.0=B0C  (crit =3D +100.0=B0C)
>
> As said before, I can read most of the thermal information through
> /proc/acpi/thermal_zone but it would be very comfortable to read them
> directly with lm-sensors.
>
> Thank you, Alessandro.
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
