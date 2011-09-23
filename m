From: Josu Lazkano <josu.lazkano@gmail.com>
Date: Fri, 23 Sep 2011 15:57:01 +0000
Subject: Re: [lm-sensors] Zotac ION ITX-G Synergy Edition
Message-Id: <CAL9G6WXAGXUaV27UWkf1-tx1viEFJkFpDzroyg6rWeQ-gJZS+g@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAL9G6WVbiEnRtAoA0Wzf7TLn0hXj3AQMtQrzSbC7keLFN795ow@mail.gmail.com>
In-Reply-To: <CAL9G6WVbiEnRtAoA0Wzf7TLn0hXj3AQMtQrzSbC7keLFN795ow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

2011/9/23 Guenter Roeck <guenter.roeck@ericsson.com>:
> On Fri, 2011-09-23 at 07:28 -0400, Josu Lazkano wrote:
>> Hello all, this is my first post on the list. I am searching for some
>> help to check my board sensors. I have a ZOTAC ION ITX-G Synergy
>> Edition board with Debian Squeeze (2.6.32), it has MCP79 and it is
>> supported by lm-sensors.
>>
>> I have some problems with my board voltage and I want to check all
>> sensors available. When I execute "sensors" this is the output:
>>
>> # sensors
>> coretemp-isa-0000
>> Adapter: ISA adapter
>> Core 0: =A0 =A0 =A0+27.0=B0C =A0(crit =3D +90.0=B0C)
>>
>> coretemp-isa-0001
>> Adapter: ISA adapter
>> Core 1: =A0 =A0 =A0+29.0=B0C =A0(crit =3D +90.0=B0C)
>>
>> This is just CPU temperature. Is it possible to get more info about my b=
oard?
>>
>> I read some forums and I found this interesting things:
>>
>> # modprobe i2c-dev
>> # modprobe i2c-nforce2
>> # echo "10de 0aa2" > /sys/bus/pci/drivers/nForce2_smbus/new_id
>> # i2cdetect -l
>> i2c-0 smbus =A0 =A0 =A0 =A0 =A0 SMBus nForce2 adapter at 4d00 =A0 =A0 =
=A0 =A0 =A0 SMBus adapter
>> i2c-1 i2c =A0 =A0 =A0 =A0 =A0 =A0 cx23885[0] =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0I2C adapter
>> i2c-2 i2c =A0 =A0 =A0 =A0 =A0 =A0 cx23885[0] =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0I2C adapter
>> i2c-3 i2c =A0 =A0 =A0 =A0 =A0 =A0 cx23885[0] =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0I2C adapter
>> i2c-4 i2c =A0 =A0 =A0 =A0 =A0 =A0 NVIDIA i2c adapter 0 at 3:00.0 =A0 =A0=
 =A0 =A0 =A0I2C adapter
>> i2c-5 i2c =A0 =A0 =A0 =A0 =A0 =A0 NVIDIA i2c adapter 2 at 3:00.0 =A0 =A0=
 =A0 =A0 =A0I2C adapter
>> i2c-6 i2c =A0 =A0 =A0 =A0 =A0 =A0 NVIDIA i2c adapter 3 at 3:00.0 =A0 =A0=
 =A0 =A0 =A0I2C adapter
>>
>> I don't know what I am doing with the echo command, but it looks like
>> it found some i2c devices.
>>
>> I will appreciate any help on this, I read lots of webs but I don't
>> understand kernel/module compiling.
>>
> Did you try to run sensors-detect ?
>
> Guenter
>
>
>

Thanks for the reply, yes, I run it:

# sensors-detect
# sensors-detect revision 5818 (2010-01-18 17:22:07 +0100)
# System: To Be Filled By O.E.M. To Be Filled By O.E.M.
# Board: To be filled by O.E.M. To be filled by O.E.M.

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
Intel Atom thermal sensor...                                Success!
    (driver `coretemp')
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
Trying family `National Semiconductor'...                   No
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
Using driver `i2c-nforce2' for device 0000:00:03.2: nVidia Corporation
nForce SMBus (MCP79)

Next adapter: SMBus nForce2 adapter at 4d00 (i2c-0)
Do you want to scan it? (YES/no/selectively):
Client found at address 0x4c
Probing for `National Semiconductor LM75'...                No
Probing for `Dallas Semiconductor DS75'...                  No
Probing for `Analog Devices ADT7466'...                     No
Probing for `Andigilog aSC7511'...                          No
Probing for `Dallas Semiconductor DS1621/DS1631'...         No
Probing for `Analog Devices ADM1021'...                     No
Probing for `Analog Devices ADM1021A/ADM1023'...            No
Probing for `Maxim MAX1617'...                              No
Probing for `Maxim MAX1617A'...                             No
Probing for `Maxim MAX1668'...                              No
Probing for `Maxim MAX1805'...                              No
Probing for `Maxim MAX1989'...                              No
Probing for `Maxim MAX6655/MAX6656'...                      No
Probing for `TI THMC10'...                                  No
Probing for `National Semiconductor LM84'...                No
Probing for `Genesys Logic GL523SM'...                      No
Probing for `Onsemi MC1066'...                              No
Probing for `Maxim MAX1618'...                              No
Probing for `Maxim MAX1619'...                              No
Probing for `National Semiconductor LM82/LM83'...           No
Probing for `National Semiconductor LM90'...                No
Probing for `National Semiconductor LM89/LM99'...           No
Probing for `National Semiconductor LM86'...                No
Probing for `Analog Devices ADM1032'...                     No
Probing for `Maxim MAX6654/MAX6690'...                      No
Probing for `Maxim MAX6657/MAX6658/MAX6659'...              No
Probing for `Maxim MAX6648/MAX6649/MAX6692'...              No
Probing for `Maxim MAX6680/MAX6681'...                      No
Probing for `Winbond W83L771W/G'...                         No
Probing for `Winbond W83L771AWG/ASG'...                     Success!
    (confidence 6, driver `lm90')
Probing for `Texas Instruments TMP401'...                   No
Probing for `Texas Instruments TMP411'...                   No
Probing for `Texas Instruments TMP421'...                   No
Probing for `Texas Instruments TMP422'...                   No
Probing for `Texas Instruments TMP423'...                   No
Probing for `Texas Instruments AMC6821'...                  No
Probing for `National Semiconductor LM63'...                No
Probing for `Fintek F75363SG'...                            No
Probing for `National Semiconductor LM73'...                No
Probing for `Maxim MAX6633/MAX6634/MAX6635'...              No
Probing for `Analog Devices ADT7461'...                     No
Probing for `Analog Devices ADT7481'...                     No
Probing for `Fintek F75383S/M'...                           No
Client found at address 0x50
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 No
Probing for `EDID EEPROM'...                                No
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

Next adapter: cx23885[0] (i2c-1)
Do you want to scan it? (yes/NO/selectively):

Next adapter: cx23885[0] (i2c-2)
Do you want to scan it? (yes/NO/selectively):

Next adapter: cx23885[0] (i2c-3)
Do you want to scan it? (yes/NO/selectively):

Next adapter: NVIDIA i2c adapter 0 at 3:00.0 (i2c-4)
Do you want to scan it? (YES/no/selectively):

Next adapter: NVIDIA i2c adapter 2 at 3:00.0 (i2c-5)
Do you want to scan it? (YES/no/selectively):

Next adapter: NVIDIA i2c adapter 3 at 3:00.0 (i2c-6)
Do you want to scan it? (YES/no/selectively):
Client found at address 0x50
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 No
Probing for `EDID EEPROM'...                                Yes
    (confidence 8, not a hardware monitoring chip)

Now follows a summary of the probes I have just done.
Just press ENTER to continue:

Driver `coretemp':
  * Chip `Intel Atom thermal sensor' (confidence: 9)

Driver `lm90':
  * Bus `SMBus nForce2 adapter at 4d00'
    Busdriver `i2c_nforce2', I2C address 0x4c
    Chip `Winbond W83L771AWG/ASG' (confidence: 6)

To load everything that is needed, add this to /etc/modules:
#----cut here----
# Chip drivers
coretemp
lm90
#----cut here----
If you have some drivers built into your kernel, the list above will
contain too many modules. Skip the appropriate ones!

Do you want to add these lines automatically to /etc/modules? (yes/NO)yes
Successful!

Monitoring programs won't work until the needed modules are
loaded. You may want to run '/etc/init.d/module-init-tools start'
to load them.

# /etc/init.d/module-init-tools
Loading kernel modules...done.

But it just is showing the CPU temperature.

Thanks and best regards.

--=20
Josu Lazkano

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
