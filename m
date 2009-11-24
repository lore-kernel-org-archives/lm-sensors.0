From: daniel.solgalov@medicalmart.ru
Date: Tue, 24 Nov 2009 12:27:02 +0000
Subject: [lm-sensors] Found unknown chip with ID 0x8700
Message-Id: <8d7042a0d09388fda56b06824479d5ab.squirrel@webmail.timeweb.ru>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi!
I am using opensuse 11.2 with factory kernel-desktop 2.6.32 with my MSI
WIND U210 netbook.
There is no fan control under Opensuse so i guess it is because of the
following sensors-detect output ("Found unknown chip with ID 0x8700"):

sensors-detect
# sensors-detect revision 5729 (2009-06-02 15:51:29 +0200)
# System: Micro-Star International U210 (laptop)
# Board: MSI MS-1241

This program will help you determine which kernel modules you need
to load to use lm_sensors most effectively. It is generally safe
and recommended to accept the default answers to all questions,
unless you know what you're doing.

Some south bridges, CPUs or memory controllers contain embedded sensors.
Do you want to scan for them? This is totally safe. (YES/no): y
Silicon Integrated Systems SIS5595...                       No
VIA VT82C686 Integrated Sensors...                          No
VIA VT8231 Integrated Sensors...                            No
AMD K8 thermal sensors...                                   Success!
    (driver `k8temp')
AMD K10 thermal sensors...                                  No
Intel Core family thermal sensor...                         No
Intel AMB FB-DIMM thermal sensor...                         No
VIA C7 thermal and voltage sensors...                       No

Some Super I/O chips contain embedded sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no): y
Probing for Super-I/O at 0x2e/0x2f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Fintek'...                       No
Trying family `ITE'...                                      No
Probing for Super-I/O at 0x4e/0x4f
Trying family `National Semiconductor'...                   Yes
Found unknown chip with ID 0x8700

Some hardware monitoring chips are accessible through the ISA I/O ports.
We have to write to arbitrary I/O ports to probe them. This is usually
safe though. Yes, you do have ISA I/O ports even if you do not have any
ISA slots! Do you want to scan the ISA I/O ports? (YES/no): y
Probing for `National Semiconductor LM78' at 0x290...       No
Probing for `National Semiconductor LM79' at 0x290...       No
Probing for `Winbond W83781D' at 0x290...                   No
Probing for `Winbond W83782D' at 0x290...                   No

Lastly, we can probe the I2C/SMBus adapters for connected hardware
monitoring devices. This is the most risky part, and while it works
reasonably well on most systems, it has been reported to cause trouble
on some systems.
Do you want to probe the I2C/SMBus adapters now? (YES/no): y
Using driver `i2c-piix4' for device 0000:00:14.0: ATI Technologies Inc
SB600 SMBus
Module i2c-dev loaded successfully.

Next adapter: SMBus PIIX4 adapter at 0b00 (i2c-0)
Do you want to scan it? (YES/no/selectively): y
Client found at address 0x50
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 Yes
    (confidence 8, not a hardware monitoring chip)
Probing for `EDID EEPROM'...                                No

Now follows a summary of the probes I have just done.
Just press ENTER to continue: y

Driver `k8temp' (autoloaded):
  * Chip `AMD K8 thermal sensors' (confidence: 9)

No modules to load, skipping modules configuration.

Unloading i2c-dev... OK

I guess it is ITE IT8700 chip which is likely to be the same as IT8705?

Best regards, Daniel


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
