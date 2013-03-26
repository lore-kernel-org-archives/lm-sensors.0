From: Bryan Guidroz <bryanguidroz@hotmail.com>
Date: Tue, 26 Mar 2013 19:53:47 +0000
Subject: [lm-sensors] MSI MS-9821 Sensor Help
Message-Id: <BLU173-W922408091AE1E1E4EF4B1D1D00@phx.gbl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Looking for some help getting lm sensors working properly on my system.
I'm new to this, so please be gentle :)
I don't know what additional information may be needed.
It's an MSI MS-9832 (Intel Atom 330 - Intel 945GC Northbridge, ICH7 Southbr=
idge)
Detects Fintek F71882FG/F71883FG Super IO Sensors.
Best docs I can find are here:
http://www.orbitmicro.com/download/resources/MS-9832_2%20manual.pdf
Thanks...

------------------------------------------------
[root@gateway ~]# sensors-detect=20
 # sensors-detect revision 1.1
 # System: MICRO-STAR INTERNATIONAL CO.,LTD RX945GC
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
 AMD Family 11h thermal sensors...                           No
 Intel digital thermal sensor...                             Success!
     (driver `coretemp')
 Intel AMB FB-DIMM thermal sensor...                         No
 VIA C7 thermal and voltage sensors...                       No
 Some Super I/O chips contain embedded sensors. We have to write to
 standard I/O ports to probe them. This is usually safe.
 Do you want to scan for Super I/O sensors? (YES/no):=20
 Probing for Super-I/O at 0x2e/0x2f
 Trying family `National Semiconductor'...                   No
 Trying family `SMSC'...                                     No
 Trying family `VIA/Winbond/Nuvoton/Fintek'...               No
 Trying family `ITE'...                                      No
 Probing for Super-I/O at 0x4e/0x4f
 Trying family `National Semiconductor'...                   No
 Trying family `SMSC'...                                     No
 Trying family `VIA/Winbond/Nuvoton/Fintek'...               Yes
 Found `Fintek F71882FG/F71883FG Super IO Sensors'           Success!
     (address 0xa10, driver `f71882fg')
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
 ISA slots! Do you want to scan the ISA I/O ports? (yes/NO):=20
 Lastly, we can probe the I2C/SMBus adapters for connected hardware
 monitoring devices. This is the most risky part, and while it works
 reasonably well on most systems, it has been reported to cause trouble
 on some systems.
 Do you want to probe the I2C/SMBus adapters now? (YES/no):=20
 Using driver `i2c-i801' for device 0000:00:1f.3: Intel 82801G ICH7
 Module i2c-dev loaded successfully.
 Next adapter: i915 gmbus ssc (i2c-0)
 Do you want to scan it? (YES/no/selectively):=20
 Next adapter: i915 gmbus vga (i2c-1)
 Do you want to scan it? (YES/no/selectively):=20
 Next adapter: i915 gmbus panel (i2c-2)
 Do you want to scan it? (YES/no/selectively):=20
 Next adapter: i915 gmbus dpc (i2c-3)
 Do you want to scan it? (YES/no/selectively):=20
 Next adapter: i915 gmbus dpb (i2c-4)
 Do you want to scan it? (YES/no/selectively):=20
 Next adapter: i915 gmbus dpd (i2c-5)
 Do you want to scan it? (YES/no/selectively):=20
 Next adapter: SMBus I801 adapter at 0400 (i2c-6)
 Do you want to scan it? (yes/NO/selectively):=20
 Now follows a summary of the probes I have just done.
 Just press ENTER to continue:=20
 Driver `coretemp':
   * Chip `Intel digital thermal sensor' (confidence: 9)
 Driver `f71882fg':
   * ISA bus, address 0xa10
     Chip `Fintek F71882FG/F71883FG Super IO Sensors' (confidence: 9)
 Do you want to overwrite /etc/sysconfig/lm_sensors? (YES/no): yes
 Starting lm_sensors: loading module coretemp f71882fg      [  OK  ]
 Unloading i2c-dev... OK
 -----------------------------------------------------------------------

 Here is the output of sensors

 -------------------------------------------------------------------------
 [root@gateway ~]# sensors
 coretemp-isa-0000
 Adapter: ISA adapter
 Core 0:      +28.0=B0C  (high =3D +70.0=B0C, crit =3D +90.0=B0C) =20
 Core 1:      +29.0=B0C  (high =3D +70.0=B0C, crit =3D +90.0=B0C) =20
 f71882fg-isa-0a10
 Adapter: ISA adapter
 +3.3V:       +3.42 V
 in1:         +1.16 V  (max =3D  +2.04 V)  =20
 in2:         +2.04 V
 in3:         +2.04 V
 in4:         +0.97 V
 in5:         +1.11 V
 in6:         +2.04 V
 3VSB:        +3.39 V
 Vbat:        +3.41 V
 fan1:       4587 RPM
 fan2:       2890 RPM
 fan3:          0 RPM  ALARM
 fan4:          0 RPM  ALARM
 temp1:       +47.0=B0C  (high =3D +85.0=B0C, hyst =3D +81.0=B0C) =20
                       (crit =3D +100.0=B0C, hyst =3D +96.0=B0C)  sensor =
=3D transistor
 temp2:         FAULT  (high =3D +85.0=B0C, hyst =3D +81.0=B0C) =20
                       (crit =3D +100.0=B0C, hyst =3D +96.0=B0C)  sensor =
=3D transistor
 temp3:       +42.0=B0C  (high =3D +70.0=B0C, hyst =3D +68.0=B0C) =20
                       (crit =3D +85.0=B0C, hyst =3D +83.0=B0C)  sensor =3D=
 transistor
 -------------------------------------------------------------------

I=92m having trouble getting the correct information in /etc/sensors3.conf =
to correct the label and values of each sensor.  This is the default of /et=
c/sensors3.conf that I think applies to this system.

 --------------------------------------------------------------------
 chip "f71882fg-*"
     label in0 "+3.3V"
     label in7 "3VSB"
     label in8 "Vbat"
     compute in0  @*2, @/2
     compute in7  @*2, @/2
     compute in8  @*2, @/2
 ----------------------------------------------------------------------

I THINK I need to modify /etc/sensors3.conf to the following (or something =
similar.)
(would like some conformation before I start making changes.)

 ----------------------------------------------------------------------
 chip "f71862fg-*"
 # in5=3DVCore identified by watching changes consequent to CnQ
 # in6=3DNBVCC identified by watching changes consequent to BIOS changes
 # in4=3DVDIMM identified by watching changes consequent to BIOS changes
 # in0, in7 and in8 are apparently hordwired in the chip
 # A guess that in1=3D5V and in3=3D5VSB on their raw value being equal
 # A guess that in2=3D12V
 # Concerned that BIOS screen shows VLDT but nowhere in my guesses!
     label in0 " 3.3V"
     label in1 "  +5V"
     label in2 " +12V"
     label in3 " 5VSB"
     label in4 "VDIMM"
     label in5 "VCore"
     label in6 "NBVCC"
     label in7 " 3VSB"
     label in8 " VBat"
     label fan1 "CPUFAN"
     label fan2 "SYSFAN1"
     label fan3 "SYSFAN2"
     label temp1 "CPU Temp"
     label temp2 "NB Temp"
     label temp3 "Mobo Temp"
 # According to datasheet, 3VCC/VSB/VBAT
 # (ie. Vcc3V/VSB3V/Vbat, or in0/in7/in8)
 # use internal R1=3DR2=3D150K Ohm resistors
 #
 # remember V_in_to_chip =3D V_real * R2 / (R1 + R2)
 # (where V_real----R1---*----V_in_to_chip) [max 2.048V]
 # (                     |                )
 # (                    R2                )
 # (                     |                )
 # (                    GND               )
 #
 # The value of 10 for +12V is from comparison with multimeter
 # The value of 2.45 for +5V is from comparison with multimeter
 # The value of 1.48412 for VDIMM is from comparison with BIOS display

     compute in0 (@ * 2), (@ / 2)
     compute in1 (@ * 2.45), (@ / 2.45)
     compute in2 (@ * 10), (@ / 10)
     compute in3 (@ * 2.45), (@ / 2.45)
     compute in4 (@ *1.48412), (@ / 1.48412)
     compute in5 @, @
     compute in6 @, @
     compute in7 (@ * 2), (@ / 2)
     compute in8 (@ * 2), (@ / 2)
 #   set temp1_type 2
     set temp1_max        85
     set temp1_max_hyst   81
     set temp1_crit       65
 #   set temp1_crit_hyst  61
 #   set temp2_type 2
     set temp2_max        85
     set temp2_max_hyst   81
     set temp2_crit      100
 #   set temp2_crit_hyst  96
 #   set temp3_type 2
     set temp3_max        70
     set temp3_max_hyst   68
     set temp3_crit       85
 #   set temp3_crit_hyst  83
 --------------------------------------------------------------------------=
------

Can anyone help me out?
Once I get the correct info into /etc/sensors3.conf, do I just re-run senso=
rs-detect and all is good?
I'm a little confused.
Thanks! 		 	   		 =20
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
