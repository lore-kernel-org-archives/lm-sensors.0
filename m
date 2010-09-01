From: support RG <support@fidit.com>
Date: Wed, 01 Sep 2010 13:07:50 +0000
Subject: Re: [lm-sensors] i2c-i801 module conflict with 3400 Series Chipset
Message-Id: <4C7E5026.4040107@fidit.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============7897514962942612580=="
List-Id: <lm-sensors.vger.kernel.org>
References: <4C7934CC.4020902@fidit.com>
In-Reply-To: <4C7934CC.4020902@fidit.com>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--===============7897514962942612580==
Content-Type: multipart/alternative;
 boundary="------------040708000100070602030000"

This is a multi-part message in MIME format.
--------------040708000100070602030000
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable

as i read in Re: [lm-sensors] lmsensors doesn't detect core-i7 sensors

i launch latest release from svn
pass one step more than ever

Do you want to probe the I2C/SMBus adapters now? (YES/no):
Using driver `i2c-i801' for device 0000:00:1f.3: Intel 3400/5 Series (PCH)

as before
_>Do you want to probe the I2C/SMBus adapters now? (YES/no):
 >Found unknown SMBus adapter 8086:3b30 at 0000:00:1f.3._
 >Sorry, no supported PCI bus adapters found.

but sensors view no more and dmesg already says conflict

fidit@de100816A:~/lm-sensors-r5857-20100823/prog$ dmesg | grep conflict
[   17.201490] ACPI: resource 0000:00:1f.3 [0xf000-0xf01f] conflicts=20
with ACPI region SMBI [0xf000-0xf00f]

could you help me ?

fidit@de100816A:~/lm-sensors-r5857-20100823/prog$ ls /dev/i2c-*
/dev/i2c-0   /dev/i2c-11  /dev/i2c-14  /dev/i2c-17  /dev/i2c-2  =20
/dev/i2c-22  /dev/i2c-25  /dev/i2c-28  /dev/i2c-30  /dev/i2c-5  /dev/i2c-8
/dev/i2c-1   /dev/i2c-12  /dev/i2c-15  /dev/i2c-18  /dev/i2c-20 =20
/dev/i2c-23  /dev/i2c-26  /dev/i2c-29  /dev/i2c-31  /dev/i2c-6  /dev/i2c-9
/dev/i2c-10  /dev/i2c-13  /dev/i2c-16  /dev/i2c-19  /dev/i2c-21 =20
/dev/i2c-24  /dev/i2c-27  /dev/i2c-3   /dev/i2c-4   /dev/i2c-7

fidit@de100816A:~/lm-sensors-r5857-20100823/prog$ sudo sensors
acpitz-virtual-0
Adapter: Virtual device
temp1:       +36.5=B0C  (crit =3D +100.0=B0C)

fidit@de100816A:~/lm-sensors-r5857-20100823/prog$ sudo=20
detect/sensors-detect
# sensors-detect revision 5853 (2010-08-12 23:30:13 +0200)
# System: Dell Inc. Vostro 3500
# Board: Dell Inc. 0G2R51

This program will help you determine which kernel modules you need
to load to use lm_sensors most effectively. It is generally safe
and recommended to accept the default answers to all questions,
unless you know what you're doing.

Some south bridges, CPUs or memory controllers contain embedded sensors.
Do you want to scan for them? This is totally safe. (YES/no):
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
Do you want to scan for Super I/O sensors? (YES/no):
Probing for Super-I/O at 0x2e/0x2f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Nuvoton/Fintek'...               No
Trying family `ITE'...                                      No
Probing for Super-I/O at 0x4e/0x4f
Trying family `National Semiconductor'...                   Yes
Found unknown chip with ID 0xfc11

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
ISA slots! Do you want to scan the ISA I/O ports? (YES/no):
Probing for `National Semiconductor LM78' at 0x290...       No
Probing for `National Semiconductor LM79' at 0x290...       No
Probing for `Winbond W83781D' at 0x290...                   No
Probing for `Winbond W83782D' at 0x290...                   No

Lastly, we can probe the I2C/SMBus adapters for connected hardware
monitoring devices. This is the most risky part, and while it works
reasonably well on most systems, it has been reported to cause trouble
on some systems.
Do you want to probe the I2C/SMBus adapters now? (YES/no):
Using driver `i2c-i801' for device 0000:00:1f.3: Intel 3400/5 Series (PCH)

Next adapter: intel drm CRTDDC_A (i2c-0)
Do you want to scan it? (YES/no/selectively):
Client found at address 0x50
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 No
Probing for `EDID EEPROM'...                                Yes
     (confidence 8, not a hardware monitoring chip)
Client found at address 0x51
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 No
Client found at address 0x52
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 No
Client found at address 0x53
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 No

Next adapter: intel drm LVDSDDC_C (i2c-1)
Do you want to scan it? (YES/no/selectively):
Client found at address 0x50
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 No
Probing for `EDID EEPROM'...                                Yes
     (confidence 8, not a hardware monitoring chip)

Next adapter: intel drm HDMIB (i2c-2)
Do you want to scan it? (YES/no/selectively):

Next adapter: DPDDC-B (i2c-3)
Do you want to scan it? (YES/no/selectively):

Sorry, no sensors were detected.
Either your system has no sensors, or they are not supported, or
they are connected to an I2C or SMBus adapter that is not
supported. If you find out what chips are on your board, check
http://www.lm-sensors.org/wiki/Devices for driver status.
fidit@de100816A:~/lm-sensors-r5857-20100823/prog$ sudo sensors
acpitz-virtual-0
Adapter: Virtual device
temp1:       +35.5=B0C  (crit =3D +100.0=B0C)



Le 01/09/2010 01:50, support RG a =E9crit :
> Hi
> is there a good place for this request ?
>
> i2c-801 module seem to be not working or conflict with  3400 Series=20
> Chipset SMBus Controller [8086:3b30]
>
>      dmesg | grep conflict
> [   17.552437] ACPI: resource 0000:00:1f.3 [0xf000-0xf01f] conflicts=20
> with ACPI region SMBI [0xf000-0xf00f]
>
> so sensors command return only one temp ?
>
> follow step by step manual from ubuntu with mkdev.sh script and launch=20
> sensors-detect
> what have i made wrong ?
>
>     sudo sensors
> acpitz-virtual-0
> Adapter: Virtual device
> temp1:       +39.5=B0C  (crit =3D +100.0=B0C)
>
>     sudo sensors-detect
> # sensors-detect revision 5818 (2010-01-18 17:22:07 +0100)
> # System: Dell Inc. Vostro 3500
> # Board: Dell Inc. 0G2R51
>
> This program will help you determine which kernel modules you need
> to load to use lm_sensors most effectively. It is generally safe
> and recommended to accept the default answers to all questions,
> unless you know what you're doing.
>
> Some south bridges, CPUs or memory controllers contain embedded sensors.
> Do you want to scan for them? This is totally safe. (YES/no):
> Silicon Integrated Systems SIS5595...                       No
> VIA VT82C686 Integrated Sensors...                          No
> VIA VT8231 Integrated Sensors...                            No
> AMD K8 thermal sensors...                                   No
> AMD Family 10h thermal sensors...                           No
> AMD Family 11h thermal sensors...                           No
> Intel Core family thermal sensor...                         No
> Intel Atom thermal sensor...                                No
> Intel AMB FB-DIMM thermal sensor...                         No
> VIA C7 thermal sensor...                                    No
> VIA Nano thermal sensor...                                  No
>
> Some Super I/O chips contain embedded sensors. We have to write to
> standard I/O ports to probe them. This is usually safe.
> Do you want to scan for Super I/O sensors? (YES/no):
> Probing for Super-I/O at 0x2e/0x2f
> Trying family `National Semiconductor'...                   No
> Trying family `SMSC'...                                     No
> Trying family `VIA/Winbond/Nuvoton/Fintek'...               No
> Trying family `ITE'...                                      No
> Probing for Super-I/O at 0x4e/0x4f
> _Trying family `National Semiconductor'...                   Yes
> Found unknown chip with ID 0xfc11_
>
> Some systems (mainly servers) implement IPMI, a set of common interfaces
> through which system health data may be retrieved, amongst other things.
> We first try to get the information from SMBIOS. If we don't find it
> there, we have to read from arbitrary I/O ports to probe for such
> interfaces. This is normally safe. Do you want to scan for IPMI
> interfaces? (YES/no):
> Probing for `IPMI BMC KCS' at 0xca0...                      No
> Probing for `IPMI BMC SMIC' at 0xca8...                     No
>
> Some hardware monitoring chips are accessible through the ISA I/O ports.
> We have to write to arbitrary I/O ports to probe them. This is usually
> safe though. Yes, you do have ISA I/O ports even if you do not have any
> ISA slots! Do you want to scan the ISA I/O ports? (YES/no):
> Probing for `National Semiconductor LM78' at 0x290...       No
> Probing for `National Semiconductor LM79' at 0x290...       No
> Probing for `Winbond W83781D' at 0x290...                   No
> Probing for `Winbond W83782D' at 0x290...                   No
>
> Lastly, we can probe the I2C/SMBus adapters for connected hardware
> monitoring devices. This is the most risky part, and while it works
> reasonably well on most systems, it has been reported to cause trouble
> on some systems.
> _Do you want to probe the I2C/SMBus adapters now? (YES/no):
> Found unknown SMBus adapter 8086:3b30 at 0000:00:1f.3._
> Sorry, no supported PCI bus adapters found.
> Module i2c-dev loaded successfully.
>
> Next adapter: intel drm CRTDDC_A (i2c-0)
> Do you want to scan it? (YES/no/selectively):
> Client found at address 0x50
> Probing for `Analog Devices ADM1033'...                     No
> Probing for `Analog Devices ADM1034'...                     No
> Probing for `SPD EEPROM'...                                 No
> Probing for `EDID EEPROM'...                                Yes
>     (confidence 8, not a hardware monitoring chip)
> Client found at address 0x51
> Probing for `Analog Devices ADM1033'...                     No
> Probing for `Analog Devices ADM1034'...                     No
> Probing for `SPD EEPROM'...                                 No
> Client found at address 0x52
> Probing for `Analog Devices ADM1033'...                     No
> Probing for `Analog Devices ADM1034'...                     No
> Probing for `SPD EEPROM'...                                 No
> Client found at address 0x53
> Probing for `Analog Devices ADM1033'...                     No
> Probing for `Analog Devices ADM1034'...                     No
> Probing for `SPD EEPROM'...                                 No
>
> Next adapter: intel drm LVDSDDC_C (i2c-1)
> Do you want to scan it? (YES/no/selectively):
> Client found at address 0x50
> Probing for `Analog Devices ADM1033'...                     No
> Probing for `Analog Devices ADM1034'...                     No
> Probing for `SPD EEPROM'...                                 No
> Probing for `EDID EEPROM'...                                Yes
>     (confidence 8, not a hardware monitoring chip)
>
> Next adapter: intel drm HDMIB (i2c-2)
> Do you want to scan it? (YES/no/selectively):
>
> Next adapter: DPDDC-B (i2c-3)
> Do you want to scan it? (YES/no/selectively):
>
> Sorry, no sensors were detected.
> Either your system has no sensors, or they are not supported, or
> they are connected to an I2C or SMBus adapter that is not
> supported. If you find out what chips are on your board, check
> http://www.lm-sensors.org/wiki/Devices for driver status.
>
>     sudo pwmconfig
> # pwmconfig revision 5770 (2009-09-16)
> This program will search your sensors for pulse width modulation (pwm)
> controls, and test each one to see if it controls a fan on
> your motherboard. Note that many motherboards do not have pwm
> circuitry installed, even if your sensor chip supports pwm.
>
> We will attempt to briefly stop each fan using the pwm controls.
> The program will attempt to restore each fan to full speed
> after testing. However, it is ** very important ** that you
> physically verify that the fans have been to full speed
> after the program has completed.
>
> /usr/sbin/pwmconfig: There are no pwm-capable sensor modules installed
>
>     lsmod | egrep -i "temp|core|i2c|dell"
> i2c_dev                 4970  0
> dell_wmi                1793  0
> i2c_algo_bit            5028  1 i915
> dell_laptop             6856  0
> dcdbas                  5422  1 dell_laptop
> soundcore               6620  1 snd
> i2c_i801                7722  0
> k8temp                  3024  0
>
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors


--------------040708000100070602030000
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html; charset=ISO-8859-1"
 http-equiv="Content-Type">
  <title></title>
</head>
<body text="#000000" bgcolor="#ffffff">
as i read in Re: [lm-sensors] lmsensors doesn't detect core-i7 sensors<br>
<br>
i launch latest release from svn<br>
pass one step more than ever<br>
<br>
Do you want to probe the I2C/SMBus adapters now? (YES/no): <br>
Using driver `i2c-i801' for device 0000:00:1f.3: Intel 3400/5 Series
(PCH)<br>
<br>
as before<br>
<u>&gt;Do you want to probe the I2C/SMBus adapters now? (YES/no): <br>
&gt;Found unknown SMBus adapter 8086:3b30 at 0000:00:1f.3.</u><br>
&gt;Sorry, no supported PCI bus adapters found.<br>
<br>
but sensors view no more and dmesg already says conflict<br>
<br>
fidit@de100816A:~/lm-sensors-r5857-20100823/prog$ dmesg | grep conflict<br>
[&nbsp;&nbsp; 17.201490] ACPI: resource 0000:00:1f.3 [0xf000-0xf01f] conflicts
with ACPI region SMBI [0xf000-0xf00f]<br>
<br>
could you help me ?<br>
<br>
fidit@de100816A:~/lm-sensors-r5857-20100823/prog$ ls /dev/i2c-*<br>
/dev/i2c-0&nbsp;&nbsp; /dev/i2c-11&nbsp; /dev/i2c-14&nbsp; /dev/i2c-17&nbsp; /dev/i2c-2&nbsp;&nbsp;
/dev/i2c-22&nbsp; /dev/i2c-25&nbsp; /dev/i2c-28&nbsp; /dev/i2c-30&nbsp; /dev/i2c-5&nbsp;
/dev/i2c-8<br>
/dev/i2c-1&nbsp;&nbsp; /dev/i2c-12&nbsp; /dev/i2c-15&nbsp; /dev/i2c-18&nbsp; /dev/i2c-20&nbsp;
/dev/i2c-23&nbsp; /dev/i2c-26&nbsp; /dev/i2c-29&nbsp; /dev/i2c-31&nbsp; /dev/i2c-6&nbsp;
/dev/i2c-9<br>
/dev/i2c-10&nbsp; /dev/i2c-13&nbsp; /dev/i2c-16&nbsp; /dev/i2c-19&nbsp; /dev/i2c-21&nbsp;
/dev/i2c-24&nbsp; /dev/i2c-27&nbsp; /dev/i2c-3&nbsp;&nbsp; /dev/i2c-4&nbsp;&nbsp; /dev/i2c-7<br>
<br>
fidit@de100816A:~/lm-sensors-r5857-20100823/prog$ sudo sensors<br>
acpitz-virtual-0<br>
Adapter: Virtual device<br>
temp1:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +36.5&deg;C&nbsp; (crit = +100.0&deg;C)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
<br>
fidit@de100816A:~/lm-sensors-r5857-20100823/prog$ sudo
detect/sensors-detect <br>
# sensors-detect revision 5853 (2010-08-12 23:30:13 +0200)<br>
# System: Dell Inc. Vostro 3500<br>
# Board: Dell Inc. 0G2R51<br>
<br>
This program will help you determine which kernel modules you need<br>
to load to use lm_sensors most effectively. It is generally safe<br>
and recommended to accept the default answers to all questions,<br>
unless you know what you're doing.<br>
<br>
Some south bridges, CPUs or memory controllers contain embedded sensors.<br>
Do you want to scan for them? This is totally safe. (YES/no): <br>
Silicon Integrated Systems SIS5595...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
VIA VT82C686 Integrated Sensors...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
VIA VT8231 Integrated Sensors...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
AMD K8 thermal sensors...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
AMD Family 10h thermal sensors...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
AMD Family 11h thermal sensors...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
Intel Core family thermal sensor...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
Intel Atom thermal sensor...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
Intel AMB FB-DIMM thermal sensor...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
VIA C7 thermal sensor...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
VIA Nano thermal sensor...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
<br>
Some Super I/O chips contain embedded sensors. We have to write to<br>
standard I/O ports to probe them. This is usually safe.<br>
Do you want to scan for Super I/O sensors? (YES/no): <br>
Probing for Super-I/O at 0x2e/0x2f<br>
Trying family `National Semiconductor'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
Trying family `SMSC'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
Trying family `VIA/Winbond/Nuvoton/Fintek'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
Trying family `ITE'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
Probing for Super-I/O at 0x4e/0x4f<br>
Trying family `National Semiconductor'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Yes<br>
Found unknown chip with ID 0xfc11<br>
<br>
Some systems (mainly servers) implement IPMI, a set of common interfaces<br>
through which system health data may be retrieved, amongst other things.<br>
We first try to get the information from SMBIOS. If we don't find it<br>
there, we have to read from arbitrary I/O ports to probe for such<br>
interfaces. This is normally safe. Do you want to scan for IPMI<br>
interfaces? (YES/no): <br>
Probing for `IPMI BMC KCS' at 0xca0...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
Probing for `IPMI BMC SMIC' at 0xca8...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
<br>
Some hardware monitoring chips are accessible through the ISA I/O ports.<br>
We have to write to arbitrary I/O ports to probe them. This is usually<br>
safe though. Yes, you do have ISA I/O ports even if you do not have any<br>
ISA slots! Do you want to scan the ISA I/O ports? (YES/no): <br>
Probing for `National Semiconductor LM78' at 0x290...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
Probing for `National Semiconductor LM79' at 0x290...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
Probing for `Winbond W83781D' at 0x290...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
Probing for `Winbond W83782D' at 0x290...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
<br>
Lastly, we can probe the I2C/SMBus adapters for connected hardware<br>
monitoring devices. This is the most risky part, and while it works<br>
reasonably well on most systems, it has been reported to cause trouble<br>
on some systems.<br>
Do you want to probe the I2C/SMBus adapters now? (YES/no): <br>
Using driver `i2c-i801' for device 0000:00:1f.3: Intel 3400/5 Series
(PCH)<br>
<br>
Next adapter: intel drm CRTDDC_A (i2c-0)<br>
Do you want to scan it? (YES/no/selectively): <br>
Client found at address 0x50<br>
Probing for `Analog Devices ADM1033'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
Probing for `Analog Devices ADM1034'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
Probing for `SPD EEPROM'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
Probing for `EDID EEPROM'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Yes<br>
&nbsp;&nbsp;&nbsp; (confidence 8, not a hardware monitoring chip)<br>
Client found at address 0x51<br>
Probing for `Analog Devices ADM1033'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
Probing for `Analog Devices ADM1034'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
Probing for `SPD EEPROM'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
Client found at address 0x52<br>
Probing for `Analog Devices ADM1033'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
Probing for `Analog Devices ADM1034'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
Probing for `SPD EEPROM'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
Client found at address 0x53<br>
Probing for `Analog Devices ADM1033'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
Probing for `Analog Devices ADM1034'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
Probing for `SPD EEPROM'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
<br>
Next adapter: intel drm LVDSDDC_C (i2c-1)<br>
Do you want to scan it? (YES/no/selectively): <br>
Client found at address 0x50<br>
Probing for `Analog Devices ADM1033'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
Probing for `Analog Devices ADM1034'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
Probing for `SPD EEPROM'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
Probing for `EDID EEPROM'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Yes<br>
&nbsp;&nbsp;&nbsp; (confidence 8, not a hardware monitoring chip)<br>
<br>
Next adapter: intel drm HDMIB (i2c-2)<br>
Do you want to scan it? (YES/no/selectively): <br>
<br>
Next adapter: DPDDC-B (i2c-3)<br>
Do you want to scan it? (YES/no/selectively): <br>
<br>
Sorry, no sensors were detected.<br>
Either your system has no sensors, or they are not supported, or<br>
they are connected to an I2C or SMBus adapter that is not<br>
supported. If you find out what chips are on your board, check<br>
<a class="moz-txt-link-freetext" href="http://www.lm-sensors.org/wiki/Devices">http://www.lm-sensors.org/wiki/Devices</a> for driver status.<br>
fidit@de100816A:~/lm-sensors-r5857-20100823/prog$ sudo sensors<br>
acpitz-virtual-0<br>
Adapter: Virtual device<br>
temp1:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +35.5&deg;C&nbsp; (crit = +100.0&deg;C) <br>
<br>
<br>
<br>
Le 01/09/2010 01:50, support RG a &eacute;crit&nbsp;:
<blockquote cite="mid:4C7D9541.3030601@fidit.com" type="cite">
  <meta http-equiv="content-type"
 content="text/html; charset=ISO-8859-1">
Hi<br>
is there a good place for this request ?<br>
  <br>
i2c-801 module seem to be not working or conflict with&nbsp; 3400 Series
Chipset SMBus Controller [8086:3b30]<br>
  <br>
&nbsp;&nbsp;&nbsp;&nbsp; dmesg | grep conflict<br>
[&nbsp;&nbsp; 17.552437] ACPI: resource 0000:00:1f.3 [0xf000-0xf01f] conflicts
with ACPI region SMBI [0xf000-0xf00f]<br>
  <br>
so sensors command return only one temp ?<br>
  <br>
follow step by step manual from ubuntu with mkdev.sh script and launch
sensors-detect<br>
what have i made wrong ?<br>
  <br>
&nbsp;&nbsp;&nbsp; sudo sensors<br>
acpitz-virtual-0<br>
Adapter: Virtual device<br>
temp1:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +39.5&deg;C&nbsp; (crit = +100.0&deg;C)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp; sudo sensors-detect <br>
# sensors-detect revision 5818 (2010-01-18 17:22:07 +0100)<br>
# System: Dell Inc. Vostro 3500<br>
# Board: Dell Inc. 0G2R51<br>
  <br>
This program will help you determine which kernel modules you need<br>
to load to use lm_sensors most effectively. It is generally safe<br>
and recommended to accept the default answers to all questions,<br>
unless you know what you're doing.<br>
  <br>
Some south bridges, CPUs or memory controllers contain embedded sensors.<br>
Do you want to scan for them? This is totally safe. (YES/no): <br>
Silicon Integrated Systems SIS5595...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
VIA VT82C686 Integrated Sensors...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
VIA VT8231 Integrated Sensors...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
AMD K8 thermal sensors...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
AMD Family 10h thermal sensors...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
AMD Family 11h thermal sensors...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
Intel Core family thermal sensor...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
Intel Atom thermal sensor...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
Intel AMB FB-DIMM thermal sensor...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
VIA C7 thermal sensor...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
VIA Nano thermal sensor...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
  <br>
Some Super I/O chips contain embedded sensors. We have to write to<br>
standard I/O ports to probe them. This is usually safe.<br>
Do you want to scan for Super I/O sensors? (YES/no): <br>
Probing for Super-I/O at 0x2e/0x2f<br>
Trying family `National Semiconductor'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
Trying family `SMSC'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
Trying family `VIA/Winbond/Nuvoton/Fintek'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
Trying family `ITE'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
Probing for Super-I/O at 0x4e/0x4f<br>
  <u>Trying family `National Semiconductor'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Yes<br>
Found unknown chip with ID 0xfc11</u><br>
  <br>
Some systems (mainly servers) implement IPMI, a set of common interfaces<br>
through which system health data may be retrieved, amongst other things.<br>
We first try to get the information from SMBIOS. If we don't find it<br>
there, we have to read from arbitrary I/O ports to probe for such<br>
interfaces. This is normally safe. Do you want to scan for IPMI<br>
interfaces? (YES/no): <br>
Probing for `IPMI BMC KCS' at 0xca0...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
Probing for `IPMI BMC SMIC' at 0xca8...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
  <br>
Some hardware monitoring chips are accessible through the ISA I/O ports.<br>
We have to write to arbitrary I/O ports to probe them. This is usually<br>
safe though. Yes, you do have ISA I/O ports even if you do not have any<br>
ISA slots! Do you want to scan the ISA I/O ports? (YES/no): <br>
Probing for `National Semiconductor LM78' at 0x290...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
Probing for `National Semiconductor LM79' at 0x290...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
Probing for `Winbond W83781D' at 0x290...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
Probing for `Winbond W83782D' at 0x290...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
  <br>
Lastly, we can probe the I2C/SMBus adapters for connected hardware<br>
monitoring devices. This is the most risky part, and while it works<br>
reasonably well on most systems, it has been reported to cause trouble<br>
on some systems.<br>
  <u>Do you want to probe the I2C/SMBus adapters now? (YES/no): <br>
Found unknown SMBus adapter 8086:3b30 at 0000:00:1f.3.</u><br>
Sorry, no supported PCI bus adapters found.<br>
Module i2c-dev loaded successfully.<br>
  <br>
Next adapter: intel drm CRTDDC_A (i2c-0)<br>
Do you want to scan it? (YES/no/selectively): <br>
Client found at address 0x50<br>
Probing for `Analog Devices ADM1033'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
Probing for `Analog Devices ADM1034'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
Probing for `SPD EEPROM'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
Probing for `EDID EEPROM'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Yes<br>
&nbsp;&nbsp;&nbsp; (confidence 8, not a hardware monitoring chip)<br>
Client found at address 0x51<br>
Probing for `Analog Devices ADM1033'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
Probing for `Analog Devices ADM1034'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
Probing for `SPD EEPROM'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
Client found at address 0x52<br>
Probing for `Analog Devices ADM1033'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
Probing for `Analog Devices ADM1034'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
Probing for `SPD EEPROM'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
Client found at address 0x53<br>
Probing for `Analog Devices ADM1033'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
Probing for `Analog Devices ADM1034'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
Probing for `SPD EEPROM'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
  <br>
Next adapter: intel drm LVDSDDC_C (i2c-1)<br>
Do you want to scan it? (YES/no/selectively): <br>
Client found at address 0x50<br>
Probing for `Analog Devices ADM1033'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
Probing for `Analog Devices ADM1034'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
Probing for `SPD EEPROM'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No<br>
Probing for `EDID EEPROM'...&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Yes<br>
&nbsp;&nbsp;&nbsp; (confidence 8, not a hardware monitoring chip)<br>
  <br>
Next adapter: intel drm HDMIB (i2c-2)<br>
Do you want to scan it? (YES/no/selectively): <br>
  <br>
Next adapter: DPDDC-B (i2c-3)<br>
Do you want to scan it? (YES/no/selectively): <br>
  <br>
Sorry, no sensors were detected.<br>
Either your system has no sensors, or they are not supported, or<br>
they are connected to an I2C or SMBus adapter that is not<br>
supported. If you find out what chips are on your board, check<br>
  <a moz-do-not-send="true" class="moz-txt-link-freetext"
 href="http://www.lm-sensors.org/wiki/Devices">http://www.lm-sensors.org/wiki/Devices</a>
for driver status.<br>
  <br>
&nbsp;&nbsp;&nbsp; sudo pwmconfig <br>
# pwmconfig revision 5770 (2009-09-16)<br>
This program will search your sensors for pulse width modulation (pwm)<br>
controls, and test each one to see if it controls a fan on<br>
your motherboard. Note that many motherboards do not have pwm<br>
circuitry installed, even if your sensor chip supports pwm.<br>
  <br>
We will attempt to briefly stop each fan using the pwm controls.<br>
The program will attempt to restore each fan to full speed<br>
after testing. However, it is ** very important ** that you<br>
physically verify that the fans have been to full speed<br>
after the program has completed.<br>
  <br>
/usr/sbin/pwmconfig: There are no pwm-capable sensor modules installed<br>
  <br>
&nbsp;&nbsp;&nbsp; lsmod | egrep -i "temp|core|i2c|dell"<br>
i2c_dev&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4970&nbsp; 0 <br>
dell_wmi&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1793&nbsp; 0 <br>
i2c_algo_bit&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5028&nbsp; 1 i915<br>
dell_laptop&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 6856&nbsp; 0 <br>
dcdbas&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5422&nbsp; 1 dell_laptop<br>
soundcore&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 6620&nbsp; 1 snd<br>
i2c_i801&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 7722&nbsp; 0 <br>
k8temp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3024&nbsp; 0 <br>
  <br>
  <pre wrap="">
<fieldset class="mimeAttachmentHeader"></fieldset>
_______________________________________________
lm-sensors mailing list
<a class="moz-txt-link-abbreviated" href="mailto:lm-sensors@lm-sensors.org">lm-sensors@lm-sensors.org</a>
<a class="moz-txt-link-freetext" href="http://lists.lm-sensors.org/mailman/listinfo/lm-sensors">http://lists.lm-sensors.org/mailman/listinfo/lm-sensors</a></pre>
</blockquote>
<br>
</body>
</html>

--------------040708000100070602030000--


--===============7897514962942612580==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============7897514962942612580==--
