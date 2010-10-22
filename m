From: Karsten de Freese <karsten@maxi-dsl.de>
Date: Fri, 22 Oct 2010 20:51:46 +0000
Subject: Re: [lm-sensors] looking for help with W83795ADG
Message-Id: <4CC1F962.8020904@maxi-dsl.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------070406020005010305080505"
List-Id: <lm-sensors.vger.kernel.org>
References: <20101022135607.6996731s0m2gcr48@webmail.mnet-online.de>
In-Reply-To: <20101022135607.6996731s0m2gcr48@webmail.mnet-online.de>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------070406020005010305080505
Content-Type: multipart/alternative;
 boundary="------------070600080606020508030507"


--------------070600080606020508030507
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

hi Jean,

seems the attachment was deleted (I was using a web mail interface), so 
I'll try again to send the output from sensors-detect. (sensors-detect.txt)

regards -

Karsten



Am 22.10.2010 16:04, schrieb karsten@maxi-dsl.de:
> hi Jean,
>
>>
>> The w83795 driver uses the same detection mechanism used in
>> sensors-detect. So if sensors-detect doesn't see your chip, I am not
>> surprised that the driver didn't either.
>
>> The full output of sensors-detect is needed to diagnose your problem
>> further. It could be that your SMBus controller isn't supported, or
>> maybe you are supposed to access the chip through IPMI.
>
> IPMI is probably the key..
>
> From the sensors-detect output:
> "Warning: the required module ipmisensors is not currently installed
> on your system. If it is built into the kernel then it's OK.
> Otherwise, check http://www.lm-sensors.org/wiki/Devices for
> driver availability" (full ouput attached)
>
> I did see the output before, but didn't really understand the 
> implications (IPMI seems to be an alternative way of accessing the 
> monitoring chips?)
>
> The suggested ipmisensors driver however does not seem to be 
> available, right?
> (http://lm-sensors.org/wiki/Devices says "(2004-12-12)  Port to Linux 
> 2.6 in progress by Yani Ioannou")
>
>
> regards -
>
> Karsten
>
>
>
> [Anhang entfernt: Ehemaliger Anhangstyp: "application/octet-stream", Name: "sensors-detect.out"]


--------------070600080606020508030507
Content-Type: text/html; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content=3D"text/html; charset=3DISO-8859-15"
 http-equiv=3D"Content-Type">
  <title></title>
</head>
<body text=3D"#000000" bgcolor=3D"#ffffff">
hi Jean,<br>
<br>
seems the attachment was deleted (I was using a web mail interface), so
I'll try again to send the output from sensors-detect.
(sensors-detect.txt)<br>
<br>
regards -<br>
<br>
Karsten<br>
<br>
<br>
<br>
Am 22.10.2010 16:04, schrieb <a class=3D"moz-txt-link-abbreviated" href=3D=
"mailto:karsten@maxi-dsl.de:">karsten@maxi-dsl.de:</a>
<blockquote
 cite=3D"mid:20101022160410.48153qy4igwkl0is@webmail.mnet-online.de"
 type=3D"cite">hi Jean,
  <br>
  <br>
  <blockquote type=3D"cite"><br>
The w83795 driver uses the same detection mechanism used in
    <br>
sensors-detect. So if sensors-detect doesn't see your chip, I am not
    <br>
surprised that the driver didn't either.
    <br>
  </blockquote>
  <br>
  <blockquote type=3D"cite">The full output of sensors-detect is needed
to diagnose your problem
    <br>
further. It could be that your SMBus controller isn't supported, or
    <br>
maybe you are supposed to access the chip through IPMI.
    <br>
  </blockquote>
  <br>
IPMI is probably the key..
  <br>
  <br>
From the sensors-detect output:
  <br>
"Warning: the required module ipmisensors is not currently installed
  <br>
on your system. If it is built into the kernel then it's OK.
  <br>
Otherwise, check <a class=3D"moz-txt-link-freetext" href=3D"http://www.lm=
-sensors.org/wiki/Devices">http://www.lm-sensors.org/wiki/Devices</a> for
  <br>
driver availability" (full ouput attached)
  <br>
  <br>
I did see the output before, but didn't really understand the
implications (IPMI seems to be an alternative way of accessing the
monitoring chips?)
  <br>
  <br>
The suggested ipmisensors driver however does not seem to be available,
right?
  <br>
(<a class=3D"moz-txt-link-freetext" href=3D"http://lm-sensors.org/wiki/De=
vices">http://lm-sensors.org/wiki/Devices</a> says "(2004-12-12)=A0 Port =
to Linux
2.6 in progress by Yani Ioannou")
  <br>
  <br>
  <br>
regards -
  <br>
  <br>
Karsten
  <br>
  <br>
  <br>
  <pre wrap=3D"">
<fieldset class=3D"mimeAttachmentHeader"></fieldset>
[Anhang entfernt: Ehemaliger Anhangstyp: "application/octet-stream", Name=
: "sensors-detect.out"]</pre>
</blockquote>
<br>
</body>
</html>

--------------070600080606020508030507--

--------------070406020005010305080505
Content-Type: text/plain;
 name="sensors-detect.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="sensors-detect.txt"

# sensors-detect revision 5818 (2010-01-18 17:22:07 +0100)
# System: HP ProLiant Micro Server

This program will help you determine which kernel modules you need
to load to use lm_sensors most effectively. It is generally safe
and recommended to accept the default answers to all questions,
unless you know what you're doing.

Some south bridges, CPUs or memory controllers contain embedded sensors.
Do you want to scan for them? This is totally safe. (YES/no): Silicon Integrated Systems SIS5595...                       No
VIA VT82C686 Integrated Sensors...                          No
VIA VT8231 Integrated Sensors...                            No
AMD K8 thermal sensors...                                   No
AMD Family 10h thermal sensors...                           Success!
    (driver `k10temp')
AMD Family 11h thermal sensors...                           No
Intel Core family thermal sensor...                         No
Intel Atom thermal sensor...                                No
Intel AMB FB-DIMM thermal sensor...                         No
VIA C7 thermal sensor...                                    No
VIA Nano thermal sensor...                                  No

Some Super I/O chips contain embedded sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no): Probing for Super-I/O at 0x2e/0x2f
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
interfaces? (YES/no): Found `IPMI BMC KCS'...                                     Success!
    (confidence 8, driver `ipmisensors')

Some hardware monitoring chips are accessible through the ISA I/O ports.
We have to write to arbitrary I/O ports to probe them. This is usually
safe though. Yes, you do have ISA I/O ports even if you do not have any
ISA slots! Do you want to scan the ISA I/O ports? (YES/no): Probing for `National Semiconductor LM78' at 0x290...       No
Probing for `National Semiconductor LM79' at 0x290...       No
Probing for `Winbond W83781D' at 0x290...                   No
Probing for `Winbond W83782D' at 0x290...                   No

Lastly, we can probe the I2C/SMBus adapters for connected hardware
monitoring devices. This is the most risky part, and while it works
reasonably well on most systems, it has been reported to cause trouble
on some systems.
Do you want to probe the I2C/SMBus adapters now? (YES/no): Using driver `i2c-piix4' for device 0000:00:14.0: ATI Technologies Inc SB600/SB700/SB800 SMBus
Module i2c-dev loaded successfully.

Next adapter: SMBus PIIX4 adapter at 0b00 (i2c-0)
Do you want to scan it? (YES/no/selectively): Client found at address 0x18
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
Probing for `Maxim MAX6654/MAX6690'...                      No
Probing for `Maxim MAX6680/MAX6681'...                      No
Probing for `Texas Instruments AMC6821'...                  No
Probing for `National Semiconductor LM64'...                No
Client found at address 0x19
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
Probing for `Maxim MAX6654/MAX6690'...                      No
Probing for `Maxim MAX6680/MAX6681'...                      No
Probing for `Texas Instruments AMC6821'...                  No
Probing for `National Semiconductor LM95231'...             No
Probing for `National Semiconductor LM95241'...             No
Client found at address 0x50
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 No
Probing for `EDID EEPROM'...                                No
Client found at address 0x51
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 No

Next adapter:  (i2c-1)
Do you want to scan it? (YES/no/selectively): 
Now follows a summary of the probes I have just done.
Just press ENTER to continue: 
Driver `ipmisensors':
  * ISA bus
    Chip `IPMI BMC KCS' (confidence: 8)

Driver `k10temp':
  * Chip `AMD Family 10h thermal sensors' (confidence: 9)

Warning: the required module ipmisensors is not currently installed
on your system. If it is built into the kernel then it's OK.
Otherwise, check http://www.lm-sensors.org/wiki/Devices for
driver availability.

Warning: the required module k10temp is not currently installed
on your system. If it is built into the kernel then it's OK.
Otherwise, check http://www.lm-sensors.org/wiki/Devices for
driver availability.

No modules to load, skipping modules configuration.

Unloading i2c-dev... OK


--------------070406020005010305080505
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------070406020005010305080505--
