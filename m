From: Stephen Clark <sclark46@earthlink.net>
Date: Thu, 08 Jan 2009 20:25:36 +0000
Subject: Re: [lm-sensors] Support for Intel DG33FB main board?
Message-Id: <49666140.5050706@earthlink.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <495C30EF.3090708@earthlink.net>
In-Reply-To: <495C30EF.3090708@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> On Thu, 08 Jan 2009 11:42:27 -0500, Stephen Clark wrote:
>> Thanks for the reply, here is the complete output of sensors-detect:
>>
>> # sensors-detect revision 5249 (2008-05-11 22:56:25 +0200)
>>
>> This program will help you determine which kernel modules you need
>> to load to use lm_sensors most effectively. It is generally safe
>> and recommended to accept the default answers to all questions,
>> unless you know what you're doing.
>>
>> We can start with probing for (PCI) I2C or SMBus adapters.
>> Do you want to probe now? (YES/no):
>> Probing for PCI bus adapters...
>> Use driver `i2c-i801' for device 0000:00:1f.3: Intel ICH9
>>
>> We will now try to load each adapter module in turn.
>> Module `i2c-i801' already loaded.
>> If you have undetectable or unsupported I2C/SMBus adapters, you can have
>> them scanned by manually loading the modules before running this script.
>>
>> We are now going to do the I2C/SMBus adapter probings. Some chips may
>> be double detected; we choose the one with the highest confidence
>> value in that case.
>> If you found that the adapter hung after probing a certain address,
>> you can specify that address to remain unprobed.
>>
>> Next adapter: SMBus I801 adapter at 3000 (i2c-0)
>> Do you want to scan it? (YES/no/selectively):
>=20
> SMBus adapter found, but...
>=20
>> Client found at address 0x50
>> Probing for `Analog Devices ADM1033'...                     No
>> Probing for `Analog Devices ADM1034'...                     No
>> Probing for `SPD EEPROM'...                                 Yes
>>      (confidence 8, not a hardware monitoring chip)
>> Probing for `EDID EEPROM'...                                No
>> Client found at address 0x51
>> Probing for `Analog Devices ADM1033'...                     No
>> Probing for `Analog Devices ADM1034'...                     No
>> Probing for `SPD EEPROM'...                                 Yes
>>      (confidence 8, not a hardware monitoring chip)
>> Probing for `EDID EEPROM'...                                No
>> Client found at address 0x52
>> Probing for `Analog Devices ADM1033'...                     No
>> Probing for `Analog Devices ADM1034'...                     No
>> Probing for `SPD EEPROM'...                                 Yes
>>      (confidence 8, not a hardware monitoring chip)
>> Probing for `EDID EEPROM'...                                No
>> Client found at address 0x53
>> Probing for `Analog Devices ADM1033'...                     No
>> Probing for `Analog Devices ADM1034'...                     No
>> Probing for `SPD EEPROM'...                                 Yes
>>      (confidence 8, not a hardware monitoring chip)
>> Probing for `EDID EEPROM'...                                No
>=20
> ... nothing on the SMBus that remotely looks like a hardware monitoring
> chip. This suggests the hardware monitoring is done by the ICH9,
> meaning you're out of luck, sorry.
>=20
> Maybe you can check the motherboard documentation (Intel make good
> ones) for confirmation.
>=20

 From the product guide:

"Intel Desktop Board DG33FB Product Guide


Hardware Management Features
The hardware management features of Desktop Board DG33FB enable the board t=
o be
compatible with the Wired for Management (WfM) specification. The board has=
=20
several hardware management features including the following:
=95 Fan speed monitoring and control
=95 Thermal and voltage monitoring
=95 Chassis intrusion detection

Hardware Monitoring and Fan Speed Control
The features of the hardware monitoring and fan speed control include:
=95 Monitoring of power supply voltages to detect levels above and below ac=
ceptable
values
=95 Intel Quiet System Technology fan speed control, delivering acousticall=
y-optimized
thermal management
NOTE
Memory must be installed in the Channel A, DIMM 0 socket to enable Intel
Quiet System Technology.
=95 Fan speed controllers and sensors integrated into the ICH9DH
=95 Thermal sensors in the processor, GMCH, and ICH9DH, plus an onboard rem=
ote
sensor
=95 Thermally monitored closed-loop fan control, for all onboard fans, that=
 can adjust
fan speed or switch the fans off as needed"


Doesn't mean much to me.

Anyway thanks for taking the time to respond and keep up the great work.

Regards,
Steve
--=20

"They that give up essential liberty to obtain temporary safety,
deserve neither liberty nor safety."  (Ben Franklin)

"The course of history shows that as a government grows, liberty
decreases."  (Thomas Jefferson)



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
