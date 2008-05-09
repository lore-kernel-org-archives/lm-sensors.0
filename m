From: achim <achim@ag-web.biz>
Date: Fri, 09 May 2008 11:51:30 +0000
Subject: Re: [lm-sensors] [PATCH] sensors-detect: Check for 1-register-only
Message-Id: <1210333890.3509.17.camel@debian-9850.ag-home.muc>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080508224145.41cfa3ef@hyperion.delvare>
In-Reply-To: <20080508224145.41cfa3ef@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Jean,

I tried the patch here. The 1-register chips got detected.
There still seem to be other chips causing the smbus master to stop
working after the sensors-detect run. I tried to exclude the chips
I could not i2cdump correct (0x47 (some oncpu device) ,0x6e (pcie) and
0x70(sensors chip?) ) and also added 0x52, 0x53 amd 0x57 but still no
luck. After the sensors-detect i can not i2dump chips till a new cold
start.
The detection program hangs for a few (2-3) seconds at the LM75 probing=20
line on chip at 0x4e (cpu's thermal interface).

A sidenote about my dead chip. When phenoms came out end last year, a
few of the early steppings stopped working after a short time if the
cpu's northbridge ran at low voltage (~1.2V) and the memory ran at
relative high voltage (>2.2V). So the onchip IMC seems to be affected by
high memory voltages.=20
Also the mayority of phenoms dying during overclocking die while running
low io accessing applications like everest, sandra or speedfan. Not many
really die from too high voltages or temperatures. Unfortunately all
those applications are closed source, but i expect they use similar
probing methods or smbus/i2c devices whom might cause voltage or
frequency peaks which harm the cpu's more than the higher frequencies
and voltages we apply during overclocking.

BTW: I still got no response from Sapphire support about the device at
0x2e, maybe i should tell em. :)

=EF=BB=BFdebian-9850:/home/achim/sensors-patch# i2cdetect 0

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          -- -- -- -- -- -- -- -- -- -- -- -- --=20
10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --=20
20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- 2e --=20
30: -- -- -- -- -- -- -- -- 38 -- -- -- -- -- -- --=20
40: -- -- -- -- -- -- -- 47 -- -- -- -- 4c -- 4e --=20
50: -- -- 52 53 -- -- -- 57 -- -- -- -- -- -- -- --=20
60: -- -- -- -- -- -- -- -- -- 69 -- -- -- -- 6e --=20
70: 70 -- -- -- -- -- -- --                        =20

debian-9850:/home/achim/sensors-patch# sensors-detect=20

# sensors-detect revision 5108 (2008-01-22 13:22:47 +0100)

This program will help you determine which kernel modules you need
to load to use lm_sensors most effectively. It is generally safe
and recommended to accept the default answers to all questions,
unless you know what you're doing.

We can start with probing for (PCI) I2C or SMBus adapters.
Do you want to probe now? (YES/no):=20
Probing for PCI bus adapters...
Use driver `i2c-piix4' for device 0000:00:14.0: ATI Technologies Inc
SB600 SMBus

We will now try to load each adapter module in turn.
Module `i2c-piix4' already loaded.
If you have undetectable or unsupported adapters, you can have them
scanned by manually loading the modules before running this script.

We are now going to do the I2C/SMBus adapter probings. Some chips may
be double detected; we choose the one with the highest confidence
value in that case.
If you found that the adapter hung after probing a certain address,
you can specify that address to remain unprobed.

Next adapter: SMBus PIIX4 adapter at 0b00 (i2c-0)
Do you want to scan it? (YES/no/selectively): selectively
Please enter one or more addresses not to scan. Separate them with
comma's.
You can specify a range by using dashes. Addresses may be decimal (like
54)
or hexadecimal (like 0x33).
Addresses: 0x47,0x57,0x6e,0x70,0x52,0x53
Client found at address 0x2e
Seems to be a 1-register-only device, skipping.
Client found at address 0x4c
Probing for `National Semiconductor LM75'...                No
Probing for `Dallas Semiconductor DS75'...                  No
Probing for `Analog Devices ADT7466'...                     No
Probing for `Andigilog aSC7511'...                          No
Probing for `Dallas Semiconductor DS1621'...                No
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
Probing for `Maxim MAX1619'...                              No
Probing for `National Semiconductor LM82/LM83'...           No
Probing for `National Semiconductor LM90'...                No
Probing for `National Semiconductor LM89/LM99'...           No
Probing for `National Semiconductor LM86'...                No
Probing for `Analog Devices ADM1032'...                     No
Probing for `Maxim MAX6657/MAX6658/MAX6659'...              No
Probing for `Maxim MAX6648/MAX6692'...                      No
Probing for `Maxim MAX6680/MAX6681'...                      No
Probing for `Winbond W83L771W/G'...                         No
Probing for `Texas Instruments TMP401'...                   No
Probing for `National Semiconductor LM63'...                No
Probing for `Fintek F75363SG'...                            No
Probing for `Maxim MAX6633/MAX6634/MAX6635'...              No
Probing for `Analog Devices ADT7461'...                     No
Probing for `Fintek F75383S/M'...                           No

Some chips are also accessible through the ISA I/O ports. We have to
write to arbitrary I/O ports to probe them. This is usually safe though.
Yes, you do have ISA I/O ports even if you do not have any ISA slots!
Do you want to scan the ISA I/O ports? (YES/no):=20
Probing for `National Semiconductor LM78' at 0x290...       No
Probing for `National Semiconductor LM78-J' at 0x290...     No
Probing for `National Semiconductor LM79' at 0x290...       No
Probing for `Winbond W83781D' at 0x290...                   No
Probing for `Winbond W83782D' at 0x290...                   No
Probing for `Silicon Integrated Systems SIS5595'...         No
Probing for `VIA VT82C686 Integrated Sensors'...            No
Probing for `VIA VT8231 Integrated Sensors'...              No
Probing for `IPMI BMC KCS' at 0xca0...                      No
Probing for `IPMI BMC SMIC' at 0xca8...                     No

Some Super I/O chips may also contain sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no):=20
Probing for Super-I/O at 0x2e/0x2f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Fintek'...                       No
Trying family `ITE'...                                      Yes
Found `ITE IT8716F Super IO Sensors'                        Success!
    (address 0x228, driver `it87')
Probing for Super-I/O at 0x4e/0x4f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Fintek'...                       No
Trying family `ITE'...                                      No

Some CPUs or memory controllers may also contain embedded sensors.
Do you want to scan for them? (YES/no):=20
AMD K8 thermal sensors...                                   No
AMD K10 thermal sensors...                                  Success!
    (driver `to-be-written')
Intel Core family thermal sensor...                         No
Intel AMB FB-DIMM thermal sensor...                         No

Now follows a summary of the probes I have just done.
Just press ENTER to continue:=20

Driver `it87' (should be inserted):
  Detects correctly:
  * ISA bus, address 0x228
    Chip `ITE IT8716F Super IO Sensors' (confidence: 9)

Driver `to-be-written' (should be inserted):
  Detects correctly:
  * Chip `AMD K10 thermal sensors' (confidence: 9)

I will now generate the commands needed to load the required modules.
Just press ENTER to continue:=20

To load everything that is needed, add this to /etc/modules:

#----cut here----
# Chip drivers
it87
# no driver for AMD K10 thermal sensors yet
#----cut here----

Do you want to add these lines automatically? (yes/NO)
debian-9850:/home/achim/sensors-patch# i2cdump 0 0x38
No size specified (using byte-data access)
WARNING! This program can confuse your I2C bus, cause data loss and
worse!
I will probe file /dev/i2c-0, address 0x38, mode byte
Continue? [Y/n]=20
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
50: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
80: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
90: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
a0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
b0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
c0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
d0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
e0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
f0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
