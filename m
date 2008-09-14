From: Marco Chiappero <marco.chiappero@fastwebnet.it>
Date: Sun, 14 Sep 2008 01:03:13 +0000
Subject: Re: [lm-sensors] New Asus board and multiple sensors chips
Message-Id: <48CC62D1.2070108@fastwebnet.it>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------020000070808050603080905"
List-Id: <lm-sensors.vger.kernel.org>
References: <48CA5C05.8040307@absence.it>
In-Reply-To: <48CA5C05.8040307@absence.it>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------020000070808050603080905
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jean Delvare ha scritto:
> Loading random drivers isn't going to help. The two interesting
> things are:
> 
> * What does sensors-detect see? Unidentified chips on the SMBus at
>   addresses typically used by monitoring chips (0x2c-0x2f or
>   0x48-0x4f)? Or nothing at all? If unidentified chips are seen then
>   we need the output of i2cdump for these chips to find out what
>   they are.

I attached the sensors-detect output, but I have never used i2cdump 
before, so I don't know exactly which parameters I should pass to it. 
Any help appreciated.

> * What makes you think there are "two other sensor chips" on the
>   board? Can you see them physically on the board?

A little search through the web. Let me explain. This board I own (Asus
Maximus II Formula) it's essentially a refreshment of the previous
Maximus Formula / Rampage Formula motherboard (which are exactly the
same board with different northbridge chip) and both share the same
temperature & voltage readings, fan and optional sensors headers. So I
think we can assume the hwmon section it's almost the same.
Unfortunately the only chip clearly visible is the Winbond W83667HG also
because the board comes with a wide heatsink that may cover some chips
(as it is for the ICS clock generator, half visible). As soon as I can
I'll try to get a closer look. However I've found these informations
about those "older" models:

- Sensor Type W83627DHG + W83791D + ADT7475 + ADP3228 (ISA 290h, SMB
2Ch/2Eh/20h)

It's all I know, but I think it's a good starting point. So let me know
how to investigate and do some tests.

Thank you,
Marco


--------------020000070808050603080905
Content-Type: text/plain;
 name="detect_output"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="detect_output"

# sensors-detect revision 5249 (2008-05-11 22:56:25 +0200)

This program will help you determine which kernel modules you need
to load to use lm_sensors most effectively. It is generally safe
and recommended to accept the default answers to all questions,
unless you know what you're doing.

We can start with probing for (PCI) I2C or SMBus adapters.
Do you want to probe now? (YES/no): 
Probing for PCI bus adapters...
Use driver `i2c-i801' for device 0000:00:1f.3: Intel ICH10

We will now try to load each adapter module in turn.
Load `i2c-i801' (say NO if built into your kernel)? (YES/no): 
Module loaded successfully.
If you have undetectable or unsupported I2C/SMBus adapters, you can have
them scanned by manually loading the modules before running this script.

To continue, we need module `i2c-dev' to be loaded.
Do you want to load `i2c-dev' now? (YES/no): 
Module loaded successfully.

We are now going to do the I2C/SMBus adapter probings. Some chips may
be double detected; we choose the one with the highest confidence
value in that case.
If you found that the adapter hung after probing a certain address,
you can specify that address to remain unprobed.

Next adapter: SMBus I801 adapter at 0400 (i2c-0)
Do you want to scan it? (YES/no/selectively): 
Client found at address 0x50
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 Yes
    (confidence 8, not a hardware monitoring chip)
Probing for `EDID EEPROM'...                                No
Client found at address 0x52
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 Yes
    (confidence 8, not a hardware monitoring chip)
Probing for `EDID EEPROM'...                                No

Some chips are also accessible through the ISA I/O ports. We have to
write to arbitrary I/O ports to probe them. This is usually safe though.
Yes, you do have ISA I/O ports even if you do not have any ISA slots!
Do you want to scan the ISA I/O ports? (YES/no): 
Probing for `National Semiconductor LM78' at 0x290...       No
Probing for `National Semiconductor LM78-J' at 0x290...     No
Probing for `National Semiconductor LM79' at 0x290...       No
Probing for `Winbond W83781D' at 0x290...                   No
Probing for `Winbond W83782D' at 0x290...                   No
Probing for `IPMI BMC KCS' at 0xca0...                      No
Probing for `IPMI BMC SMIC' at 0xca8...                     No

Some Super I/O chips may also contain sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no): 
Probing for Super-I/O at 0x2e/0x2f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Fintek'...                       Yes
Found `Nuvoton W83667HG Super IO Sensors'                   Success!
    (address 0x290, driver `w83627ehf')
Probing for Super-I/O at 0x4e/0x4f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Fintek'...                       No
Trying family `ITE'...                                      No

Some south bridges, CPUs or memory controllers may also contain
embedded sensors. Do you want to scan for them? (YES/no): 
Silicon Integrated Systems SIS5595...                       No
VIA VT82C686 Integrated Sensors...                          No
VIA VT8231 Integrated Sensors...                            No
AMD K8 thermal sensors...                                   No
AMD K10 thermal sensors...                                  No
Intel Core family thermal sensor...                         Success!
    (driver `coretemp')
Intel AMB FB-DIMM thermal sensor...                         No

Now follows a summary of the probes I have just done.
Just press ENTER to continue: 

Driver `w83627ehf' (should be inserted):
  Detects correctly:
  * ISA bus, address 0x290
    Chip `Nuvoton W83667HG Super IO Sensors' (confidence: 9)

Driver `coretemp' (should be inserted):
  Detects correctly:
  * Chip `Intel Core family thermal sensor' (confidence: 9)

Do you want to generate /etc/sysconfig/lm_sensors? (yes/NO): 
To load everything that is needed, add this to one of the system
initialization scripts (e.g. /etc/rc.d/rc.local):

#----cut here----
# Chip drivers
modprobe w83627ehf
modprobe coretemp
/usr/bin/sensors -s
#----cut here----

If you have some drivers built into your kernel, the list above will
contain too many modules. Skip the appropriate ones! You really
should try these commands right now to make sure everything is
working properly. Monitoring programs won't work until the needed
modules are loaded.

--------------020000070808050603080905
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------020000070808050603080905--
