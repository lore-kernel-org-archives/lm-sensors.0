From: =?ISO-8859-1?Q?Rune_Kj=E6r_Svendsen?= <runesvend@gmail.com>
Date: Thu, 06 Feb 2014 14:54:33 +0000
Subject: Re: [lm-sensors] Missing fan speed readout for ASUS M5A97 EVO R2.0 motherboard
Message-Id: <CAH2=CKxgEv2DPhk=czNH_AZOXTR5zmU7OJH5SZXPQMKirXt_=w@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAH2=CKyXKgmCdNLDoa0_qnDTerrCS+S=5v39hCMJ4m7eQgnbig@mail.gmail.com>
In-Reply-To: <CAH2=CKyXKgmCdNLDoa0_qnDTerrCS+S=5v39hCMJ4m7eQgnbig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Jean

Here's the output of the version of sensors-detect you linked to:

# sensors-detect revision 6215 (2014-01-26 22:52:57 +0100)
 # Board: ASUSTeK COMPUTER INC. M5A97 EVO R2.0

This program will help you determine which kernel modules you need
 to load to use lm_sensors most effectively. It is generally safe
and recommended to accept the default answers to all questions,
 unless you know what you're doing.

Some south bridges, CPUs or memory controllers contain embedded sensors.
 Do you want to scan for them? This is totally safe. (YES/no):
Module cpuid loaded successfully.
Silicon Integrated Systems SIS5595...                       No
 VIA VT82C686 Integrated Sensors...                          No
VIA VT8231 Integrated Sensors...                            No
 AMD K8 thermal sensors...                                   No
AMD Family 10h thermal sensors...                           No
 AMD Family 11h thermal sensors...                           No
AMD Family 12h and 14h thermal sensors...                   No
 AMD Family 15h thermal sensors...                           Success!
 (driver `k10temp')
AMD Family 15h power sensors...                             Success!
 (driver `fam15h_power')
AMD Family 16h power sensors...                             No
Intel digital thermal sensor...                             No
 Intel AMB FB-DIMM thermal sensor...                         No
VIA C7 thermal sensor...                                    No
 VIA Nano thermal sensor...                                  No

Some Super I/O chips contain embedded sensors. We have to write to
 standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no):
 Probing for Super-I/O at 0x2e/0x2f
Trying family `National Semiconductor/ITE'...               No
 Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Nuvoton/Fintek'...               No
 Trying family `ITE'...                                      Yes
Found `ITE IT8721F/IT8758E Super IO Sensors'                Success!
 (address 0x290, driver `it87')
Probing for Super-I/O at 0x4e/0x4f
Trying family `National Semiconductor/ITE'...               No
 Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Nuvoton/Fintek'...               No
 Trying family `ITE'...                                      No

Some systems (mainly servers) implement IPMI, a set of common interfaces
 through which system health data may be retrieved, amongst other things.
We first try to get the information from SMBIOS. If we don't find it
 there, we have to read from arbitrary I/O ports to probe for such
interfaces. This is normally safe. Do you want to scan for IPMI
 interfaces? (YES/no):
Probing for `IPMI BMC KCS' at 0xca0...                      No
Probing for `IPMI BMC SMIC' at 0xca8...                     No

Some hardware monitoring chips are accessible through the ISA I/O ports.
We have to write to arbitrary I/O ports to probe them. This is usually
 safe though. Yes, you do have ISA I/O ports even if you do not have any
ISA slots! Do you want to scan the ISA I/O ports? (yes/NO): yes
 Probing for `National Semiconductor LM78' at 0x290...       No
Probing for `National Semiconductor LM79' at 0x290...       No
 Probing for `Winbond W83781D' at 0x290...                   No
Probing for `Winbond W83782D' at 0x290...                   No

Lastly, we can probe the I2C/SMBus adapters for connected hardware
monitoring devices. This is the most risky part, and while it works
 reasonably well on most systems, it has been reported to cause trouble
on some systems.
Do you want to probe the I2C/SMBus adapters now? (YES/no):
 Using driver `i2c-piix4' for device 0000:00:14.0: ATI Technologies Inc
SB600/SB700/SB800 SMBus
Module i2c-dev loaded successfully.

Next adapter: Radeon i2c bit bus 0x90 (i2c-0)
Do you want to scan it? (yes/NO/selectively): yes

Next adapter: Radeon i2c bit bus 0x91 (i2c-1)
Do you want to scan it? (yes/NO/selectively): yes

Next adapter: Radeon i2c bit bus 0x92 (i2c-2)
Do you want to scan it? (yes/NO/selectively): yes

Next adapter: Radeon i2c bit bus 0x93 (i2c-3)
Do you want to scan it? (yes/NO/selectively): yes
 Client found at address 0x4a
Probing for `National Semiconductor LM75'...                No
Probing for `National Semiconductor LM75A'...               No
 Probing for `Dallas Semiconductor DS75'...                  No
Probing for `National Semiconductor LM77'...                No
 Probing for `Analog Devices ADT7410/ADT7420'...             No
Probing for `Analog Devices ADT7411'...                     No
 Probing for `Maxim MAX6642'...                              No
Probing for `National Semiconductor LM73'...                No
 Probing for `National Semiconductor LM92'...                No
Probing for `National Semiconductor LM76'...                No
 Probing for `Maxim MAX6633/MAX6634/MAX6635'...              No
Probing for `NXP/Philips SA56004'...                        No
 Client found at address 0x4b
Probing for `National Semiconductor LM75'...                No
Probing for `National Semiconductor LM75A'...               No
 Probing for `Dallas Semiconductor DS75'...                  No
Probing for `National Semiconductor LM77'...                No
 Probing for `Analog Devices ADT7410/ADT7420'...             No
Probing for `Analog Devices ADT7411'...                     No
 Probing for `Maxim MAX6642'...                              No
Probing for `National Semiconductor LM92'...                No
 Probing for `National Semiconductor LM76'...                No
Probing for `Maxim MAX6633/MAX6634/MAX6635'...              No
 Probing for `NXP/Philips SA56004'...                        No
Probing for `Analog Devices ADT7481'...                     No

Next adapter: Radeon i2c bit bus 0x94 (i2c-4)
Do you want to scan it? (yes/NO/selectively): yes

Next adapter: Radeon i2c bit bus 0x95 (i2c-5)
Do you want to scan it? (yes/NO/selectively): yes

Next adapter: Radeon i2c bit bus 0x96 (i2c-6)
Do you want to scan it? (yes/NO/selectively): yes

Next adapter: Radeon i2c bit bus 0x97 (i2c-7)
Do you want to scan it? (yes/NO/selectively): yes

Next adapter: Radeon aux bus DP-auxch (i2c-8)
Do you want to scan it? (yes/NO/selectively): yes

Next adapter: SMBus PIIX4 adapter at 0b00 (i2c-9)
Do you want to scan it? (YES/no/selectively): yes
 Client found at address 0x52
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
 Probing for `SPD EEPROM'...                                 Yes
 (confidence 8, not a hardware monitoring chip)
 Client found at address 0x53
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
 Probing for `SPD EEPROM'...                                 Yes
 (confidence 8, not a hardware monitoring chip)


Now follows a summary of the probes I have just done.
Just press ENTER to continue:

Driver `it87':
  * ISA bus, address 0x290
 Chip `ITE IT8721F/IT8758E Super IO Sensors' (confidence: 9)

Driver `fam15h_power' (autoloaded):
  * Chip `AMD Family 15h power sensors' (confidence: 9)

Driver `k10temp' (autoloaded):
  * Chip `AMD Family 15h thermal sensors' (confidence: 9)

Do you want to generate /etc/sysconfig/lm_sensors? (yes/NO): yes
Copy prog/init/lm_sensors.init to /etc/init.d/lm_sensors
 for initialization at boot time.
You should now start the lm_sensors service to load the required
kernel modules.

Unloading i2c-dev... OK
Unloading cpuid... OK

dmesg has the following to say about the monitoring chip (I think this is
the information you want when you ask about "which monitoring chip was
detected"):

[   16.382872] it87: Found IT8721F chip at 0x290, revision 3

and the output of 'sensors -u -c /dev/null' is the following:

radeon-pci-0100
Adapter: PCI adapter
temp1:
  temp1_input: 57.000

it8721-isa-0290
Adapter: ISA adapter
 in0:
  in0_input: 2.748
  in0_min: 1.212
  in0_max: 2.280
  in0_alarm: 1.000
in1:
  in1_input: 2.772
  in1_min: 2.616
  in1_max: 1.260
  in1_alarm: 1.000
in2:
  in2_input: 0.924
  in2_min: 2.856
  in2_max: 0.600
  in2_alarm: 1.000
 +3.3V:
  in3_input: 3.216
  in3_min: 2.520
  in3_max: 3.504
  in3_alarm: 0.000
in4:
  in4_input: 0.684
  in4_min: 2.280
  in4_max: 1.608
  in4_alarm: 1.000
in5:
  in5_input: 2.460
  in5_min: 0.312
  in5_max: 0.792
  in5_alarm: 1.000
 in6:
  in6_input: 0.192
  in6_min: 0.000
  in6_max: 1.332
  in6_alarm: 0.000
3VSB:
  in7_input: 0.600
  in7_min: 1.992
  in7_max: 1.008
  in7_alarm: 1.000
Vbat:
  in8_input: 3.288
 fan1:
  fan1_input: 617.000
  fan1_min: 10.000
  fan1_alarm: 0.000
fan2:
  fan2_input: 900.000
  fan2_min: 41.000
  fan2_alarm: 0.000
fan3:
  fan3_input: 690.000
  fan3_min: 13.000
  fan3_alarm: 0.000
temp1:
  temp1_input: 37.000
  temp1_max: 111.000
  temp1_min: -72.000
  temp1_alarm: 0.000
  temp1_type: 4.000
  temp1_offset: 0.000
temp2:
  temp2_input: 33.000
  temp2_max: -25.000
  temp2_min: 104.000
  temp2_alarm: 1.000
  temp2_type: 4.000
  temp2_offset: 0.000
 temp3:
  temp3_input: -128.000
  temp3_max: 99.000
  temp3_min: -123.000
  temp3_alarm: 0.000
  temp3_type: 0.000
  temp3_offset: 0.000
intrusion0:
  intrusion0_alarm: 0.000

k10temp-pci-00c3
Adapter: PCI adapter
temp1:
  temp1_input: 16.500
  temp1_max: 70.000
  temp1_crit: 90.000
  temp1_crit_hyst: 87.000

fam15h_power-pci-00c4
Adapter: PCI adapter
 power1:
  power1_input: 41.329
  power1_crit: 125.016

Also, this is the output of 'uname -a':

Linux rune-desktop 3.8.0-35-generic #50-Ubuntu SMP Tue Dec 3 01:24:59 UTC
2013 x86_64 x86_64 x86_64 GNU/Linux

(Running Ubuntu 13.04 with its stock kernel)

Let me know if you need anything else.

Cheers!


On Thu, Feb 6, 2014 at 8:04 AM, Jean Delvare <khali@linux-fr.org> wrote:

> Hi Rune,
>
> On Thu, 6 Feb 2014 03:02:00 +0100, Rune Kj=E6r Svendsen wrote:
> > I recently purchased an ASUS M5A97 EVO R2.0 motherboard, which has four
> fan
> > connectors on it: CPU_FAN, CHA_FAN1, CHA_FAN2 and CHA_FAN3.
> >
> > I can only get the fan speeds of the first three of these fans, however,
> > which appear as fan1, fan2 and fan3 in /sys/devices/platform/it87.656
> >
> > Is there any chance I might be able to get the speed of the last,
> CHA_FAN3,
> > fan?
> >
> > I'm using fancontrol to control the fans, and this works wonderfully. T=
he
> > BIOS can't handle it, but it works perfectly with fancontrol - complete=
ly
> > silent. The CPU is controlled by pwm1 and the chassis fans by pwm3, pwm2
> > seems to do nothing.
> >
> > I'd really like to get a reading on the third fan. Any tips on where I
> can
> > go from here? I'm willing to do some hacking to get it to work.
>
> There can be three reasons:
>
> * The last fan is connected to a different monitoring chip. Run a
>   recent version of sensors-detect again:
>   http://dl.lm-sensors.org/lm-sensors/files/sensors-detect
>   and share the results with us.
>
> * One of the fan inputs is multiplexed (two or more fans connected to
>   the same input.) We do not currently support this and do not plan to
>   support it in a near feature, as we don't have the board-specific
>   information needed to do so.
>
> * The monitoring chip driver (it87 in your case) has a bug and it
>   should really display 4 fans instead of 3. Tell us which monitoring
>   chip was detected, and show us the output of "sensors -u
>   -c /dev/null". Also tell us which kernel version you are running.
>
> --
> Jean Delvare
> http://jdelvare.nerim.net/wishlist.html
>
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
