From: mds@mds.gotdns.com (Mark Studebaker)
Date: Sat, 29 Oct 2005 21:27:19 +0000
Subject: [lm-sensors] 87431 update
Message-Id: <4363CCE2.8000607@mds.gotdns.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <435BD852.9040703@mds.gotdns.com>
In-Reply-To: <435BD852.9040703@mds.gotdns.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hmm it's basically working but the fan and temp values aren't read.
Perhaps there was a sysfs name change in 2.6.13?
Do you have sensors 2.9.2? (sensors -v)

For the labels in 'sensors', copy the label statements that appear in dmesg after bmcsensors module load
and copy it to the bmcsensors section of /etc/sensors.conf.

Sch?fer Raumgestaltung wrote:
> Hi,
> 
> 
> 
> I had only partial success :-((
> 
> 
> 
> Board: INTEL SE7320SP2  with mBMC PC87431 , 6300ESB SMBus
> 
> 
> 
> Suse Linux 10.0 Kernel 2.6.13-15-smp with the following patches
> 
> 
> 
> linux-i2c-2.6.13-v36.1-i801.diff
> linux-ipmi-2.6.13-v36.1-2.base.diff
> linux-ipmi-2.6.13-v36.1-2.emu.diff
> linux-ipmi-2.6.13-v36.1-2.smb.diff
> bmcsensors-20050809
> 
> 
> 
> 
> 
> The output from sensor (package ipmiutil) seems to be OK
> 
> but sensors  (and therefore all aplications based on it)
> 
> brings up a complete different assiociation of  Labels and  MIN/MAX Values
> 
> and isn't able to read FAN and Temperature Values
> 
> 
> 
> please see attached  output.........
> 
> 
> 
> btw
> 
> 
> 
> after updating the Board's mBMC  with FRUSDR to Ver. 1.50 (yes the Firmware
> was already 2.40)
> 
> ipmitool - I open fru list    still  'hangs'  ipmi_smb driver
> 
> but I'm able to read FRU-Data with FRUCONFIG  without problems
> 
> 
> 
> Any hints ?
> 
> 
> 
> Regards Uli
> 
> 
> 
> 
> 
> 
> 
> 
> 
> linux-server:~ # sensor
> 
> sensor: version 1.33
> 
> -- mBMC version 2.40, IPMI version 1.5
> 
> _ID_ SDR_Type_xx Sz Own Typ S_Num Sens_Description   Hex & Interp Reading
> 
> 0001 SDR EvtO 03 15 20 01 snum 01 LAN Scrty        = 00 00 00 00 OK
> 
> 0002 SDR EvtO 03 14 20 01 snum 02 Password         = 00 00 00 00 OK
> 
> 0003 SDR EvtO 03 14 20 01 snum 03 PWRGOOD#         = 00 00 00 00 OK
> 
> 0004 SDR EvtO 03 12 20 01 snum 04 Button           = 00 00 00 00 OK
> 
> 0005 SDR EvtO 03 15 20 01 snum 05 Watchdog2        = 00 00 00 00 OK
> 
> 0006 SDR EvtO 03 19 20 01 snum 06 SyS Boot Init    = 00 00 00 00 OK
> 
> 0007 SDR EvtO 03 14 20 01 snum 07 Sys Evnt         = 00 00 00 00 OK
> 
> 0008 SDR EvtO 03 17 20 01 snum 08 Pltfrm Evnt      = 00 00 00 00 OK
> 
> 0009 SDR IPMB 12 17 dev: 20 00 07 01 PC87431 mBMC
> 
> 000a SDR Comp 02 29 20 05 snum 09 Chassis Intru.   = 00 c0 01 00 Warn-lo
> 
> 000b SDR Full 01 33 20 02 snum 0a CPU1 12V         = c6 OK   12.37 Volts
> 
> 000c SDR Full 01 33 20 02 snum 0b CPU2 12V         = c6 OK   12.37 Volts
> 
> 000d SDR Full 01 39 20 02 snum 0c Baseboard 1.5V   = bf OK   1.49 Volts
> 
> 000e SDR Full 01 39 20 02 snum 0d Baseboard 2.5V   = be OK   2.49 Volts
> 
> 000f SDR Full 01 39 20 02 snum 0e Baseboard 3.3V   = c7 OK   3.42 Volts
> 
> 0010 SDR Full 01 39 20 02 snum 0f Baseboard 5.0V   = bf OK   4.97 Volts
> 
> 0011 SDR Full 01 38 20 02 snum 10 Baseboard 12V    = c7 OK   12.43 Volts
> 
> 0012 SDR Full 01 39 20 02 snum 11 Baseboard -12V   = 46 OK   -12.15 Volts
> 
> 0013 SDR Full 01 32 20 02 snum 12 FSB Vtt          = 00 OK   0.01 Volts
> 
> 0014 SDR Full 01 32 20 02 snum 13 MCH Vtt          = bd OK   1.24 Volts
> 
> 0015 SDR Comp 02 25 20 02 snum 15 Proc1 VCCP       = 00 c0 00 00 OK
> 
> 0016 SDR Comp 02 25 20 02 snum 16 Proc2 VCCP       = 00 c0 00 00 OK
> 
> 0017 SDR Full 01 34 20 04 snum 17 SYS Fan 3        = 23 OK   2341.92 RPM
> 
> 0018 SDR Full 01 34 20 04 snum 18 SYS Fan 4        = 1d OK   2826.46 RPM
> 
> 0019 SDR Full 01 34 20 04 snum 1b SYS Fan 1        = 21 OK   2546.47 RPM
> 
> 001a SDR Full 01 34 20 04 snum 25 Proc1 Fan        = 0f OK   5602.24 RPM
> 
> 001b SDR Full 01 34 20 04 snum 26 Proc2 Fan        = 10 OK   5252.10 RPM
> 
> 001c SDR Full 01 3a 20 01 snum 27 Proc1 Core Temp  = 1c OK   28.00 degrees C
> 
> 001d SDR Full 01 3a 20 01 snum 28 Proc2 Core Temp  = 20 OK   32.00 degrees C
> 
> 001e SDR Full 01 36 20 01 snum 2a System Temp      = 1b OK   27.00 degrees C
> 
> 001f SDR Comp 02 2b 20 13 snum 23 Interrupt Button = 00 c0 00 00 OK
> 
> 0020 SDR Comp 02 24 20 14 snum 24 ID Button        = 00 c0 00 00 OK
> 
> 0021 SDR Comp 02 2b 20 07 snum 29 CPU Config Error = 00 c0 00 00 OK
> 
> 0022 SDR Comp 02 25 20 07 snum 1d Proc1 IERR       = 00 c0 00 00 OK
> 
> 0023 SDR Comp 02 25 20 07 snum 1e Proc2 IERR       = 00 c0 00 00 OK
> 
> 0024 SDR Comp 02 2a 20 07 snum 1f P1 Thermal Trip  = 00 c0 00 00 OK
> 
> 0025 SDR Comp 02 2a 20 07 snum 20 P2 Thermal Trip  = 00 c0 00 00 OK
> 
> 0026 SDR Full 01 39 20 01 snum 21 Proc1 Throttle   = 00 OK   0.00
> unspecified
> 
> 0027 SDR Full 01 39 20 01 snum 22 Proc2 Throttle   = 00 OK   0.00
> unspecified
> 
> 0028 SDR FRU  11 13 dev: 20 01 80 00 07 01 HOST FRU
> 
> 0029 SDR OEM  c0 13 Intel: SDR Package 1.50
> 
> 
> 
> 
> 
> 
> 
> linux-server:~ # sensors
> 
> bmc-i2c-1-00
> 
> Adapter: IPMI adapter
> 
> in1:      +12.31 V  (min = +10.82 V, max = +13.55 V)
> 
> in2:      +12.25 V  (min = +10.82 V, max = +13.55 V)
> 
> in3:      +12.25 V  (min =  +1.38 V, max =  +1.63 V)
> 
> in4:       +1.50 V  (min =  +2.25 V, max =  +2.76 V)
> 
> in5:       +2.49 V  (min =  +3.03 V, max =  +3.64 V)
> 
> in6:       +3.42 V  (min =  +4.35 V, max =  +5.55 V)
> 
> in7:       +5.00 V  (min = +10.82 V, max = +13.55 V)
> 
> in8:      +12.37 V  (min = -13.53 V, max = -10.20 V)
> 
> in9:      -12.18 V  (min =  +1.10 V, max =  +1.30 V)
> 
> in10:      +0.01 V  (min =  +1.13 V, max =  +1.38 V)
> 
> fan1:        0 RPM  (min = 1343 RPM)
> 
> fan2:        0 RPM  (min = 1343 RPM)
> 
> fan3:        0 RPM  (min = 1750 RPM)
> 
> fan4:        0 RPM  (min =  700 RPM)
> 
> fan5:        0 RPM  (min =  700 RPM)
> 
> temp1:      +0.0?C  (high =   +88?C, hyst =    +2?C)
> 
> temp2:      +0.0?C  (high =   +88?C, hyst =    +2?C)
> 
> temp3:      +0.0?C  (high =   +65?C, hyst =    +1?C)
> 
> temp4:      +0.0?C  (high =    +0?C, hyst =    +0?C)
> 
> temp5:      +0.0?C  (high =    +0?C, hyst =    +0?C)
> 
> 
> 
> IPMI-i2c-0-42
> 
> Adapter: SMBus I801 adapter at 0400
> 
> 
> 
> eeprom-i2c-0-51
> 
> Adapter: SMBus I801 adapter at 0400
> 
> Memory type:            DDR SDRAM DIMM
> 
> Memory size (MB):       512
> 
> 
> 
> eeprom-i2c-0-50
> 
> Adapter: SMBus I801 adapter at 0400
> 
> Memory type:            DDR SDRAM DIMM
> 
> Memory size (MB):       512
> 
> 
> 
> 
> 
> linux-server:~ # lsmod |grep ipmi
> 
> i2c_ipmi               21904  0
> 
> ipmi_smb               35232  2
> 
> ipmi_devintf           27664  0
> 
> ipmi_msghandler        51840  4 bmcsensors,i2c_ipmi,ipmi_smb,ipmi_devintf
> 
> i2c_core               46720  7
> bmcsensors,i2c_ipmi,ipmi_smb,i2c_dev,eeprom,i2c_sensor,i2c_i801
> 
> 
> 
> 
> 
> linux-server:~ # lsmod |grep i2c
> 
> i2c_ipmi               21904  0
> 
> ipmi_msghandler        51840  4 bmcsensors,i2c_ipmi,ipmi_smb,ipmi_devintf
> 
> i2c_dev                29056  0
> 
> i2c_sensor             20096  1 eeprom
> 
> i2c_i801               27188  1
> 
> i2c_core               46720  7
> bmcsensors,i2c_ipmi,ipmi_smb,i2c_dev,eeprom,i2c_sensor,i2c_i801
> 
> 
> 
> 
> 
> ----- Original Message -----
> From: "Rudolf Marek" <r.marek@sh.cvut.cz>
> To: "Mark Studebaker" <mds@mds.gotdns.com>
> Cc: "LM Sensors" <lm-sensors@lm-sensors.org>; "Corey Minyard"
> <minyard@acm.org>; "Yani Ioannou" <yani.ioannou@gmail.com>; "Herman van
> Eijk" <hveijk@aweta.nl>; <mail@schaefer-raumgestaltung.de>
> Sent: Sunday, October 23, 2005 10:34 PM
> Subject: Re: [lm-sensors] 87431 update
> 
> 
> 
>>Mark Studebaker wrote:
>>
>>>Great news,
>>>I've successfully implemented bmcsensors-over-IPMI-over-SMB, working
>>>on the Intel Server donated by Aweta.
>>
>>Cool. Congrats :)
>>
>>
>>
>>>HW:
>>>    Intel Server Platform SR1325TP1-E w/ 6300ESB SMBus and PC87431 at
> 
> 0x42
> 
>>Please will you go through mailing list and notify other people that were
> 
> fighting with it?
> 
>>(I'm CCing Uli) and I think some of other asked in ticket system.
>>
>>Unfortunately I'm not very skilled on this IMPI/BMC field. Please could
> 
> you write the general HOWTO for
> 
>>people with server boards? (and for me to point them to this howto)
>>
>>1) How to know they have bmc, ipmi ..
>>2) what patches they need
>>3) how to obtain results.
>>
>>Thank you very much.
>>
>>Regards
>>Rudolf
>>
>>
> 
> 
> 



