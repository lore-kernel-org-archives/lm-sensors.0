From: Paul C Diem <PCDiem@FoxValley.net>
Date: Wed, 19 Jun 2019 21:07:46 +0000
Subject: HP Compaq 8200 Elite SFF
Message-Id: <196f06eb-e73c-4e30-06c5-ac9a878a80be@FoxValley.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

I'm trying to find the driver for the sensor chip used on the HP Compaq 
8200 Elite SFF PC. The HP docs at 
http://h10032.www1.hp.com/ctg/Manual/c02778024 say it is a Nuvoton SIO11 
Controller. I can't find any information on what model the SIO11 is.

I've built the kernel with all the Nuvoton and other hardware monitoring 
drivers included in the 4.19.25 kernel but nothing shows up in 
/sys/class/hwmon other than coretemps. Any pointers will be appreciated. 
sensors-detect shows the following:

# sensors-detect revision $Revision$
# System: Hewlett-Packard HP Compaq 8200 Elite SFF PC [Not Specified]
# Board: Hewlett-Packard 1495
# Kernel: 4.19.25 i686
# Processor: Intel(R) Core(TM) i5-2400 CPU @ 3.10GHz (6/42/7)

This program will help you determine which kernel modules you need
to load to use lm_sensors most effectively. It is generally safe
and recommended to accept the default answers to all questions,
unless you know what you're doing.

Some south bridges, CPUs or memory controllers contain embedded sensors.
Do you want to scan for them? This is totally safe. (YES/no):
Can't exec "modprobe": No such file or directory at 
/usr/sbin/sensors-detect line 3283, <STDIN> line 1.
Failed to load module cpuid.
Silicon Integrated Systems SIS5595...                       No
VIA VT82C686 Integrated Sensors...                          No
VIA VT8231 Integrated Sensors...                            No
AMD K8 thermal sensors...                                   No
AMD Family 10h thermal sensors...                           No
AMD Family 11h thermal sensors...                           No
AMD Family 12h and 14h thermal sensors...                   No
AMD Family 15h thermal sensors...                           No
AMD Family 16h thermal sensors...                           No
AMD Family 17h thermal sensors...                           No
AMD Family 15h power sensors...                             No
AMD Family 16h power sensors...                             No
Intel digital thermal sensor...                             No
Intel AMB FB-DIMM thermal sensor...                         No
Intel 5500/5520/X58 thermal sensor...                       No
VIA C7 thermal sensor...                                    No
VIA Nano thermal sensor...                                  No

Some Super I/O chips contain embedded sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no):
Probing for Super-I/O at 0x2e/0x2f
Trying family `National Semiconductor/ITE'...               Yes
Found unknown chip with ID 0x1c11
Probing for Super-I/O at 0x4e/0x4f
Trying family `National Semiconductor/ITE'...               No
Trying family `SMSC'...                                     Yes
Found unknown chip with ID 0x0b00

Some systems (mainly servers) implement IPMI, a set of common interfaces
through which system health data may be retrieved, amongst other things.
We first try to get the information from SMBIOS. If we don't find it
there, we have to read from arbitrary I/O ports to probe for such
interfaces. This is normally safe. Do you want to scan for IPMI
interfaces? (YES/no):
Found `IPMI BMC KCS'... Success!
     (confidence 8, driver `to-be-written')

Some hardware monitoring chips are accessible through the ISA I/O ports.
We have to write to arbitrary I/O ports to probe them. This is usually
safe though. Yes, you do have ISA I/O ports even if you do not have any
ISA slots! Do you want to scan the ISA I/O ports? (YES/no):
Probing for `National Semiconductor LM78' at 0x290...       No
Probing for `National Semiconductor LM79' at 0x290...       No
Probing for `Winbond W83781D' at 0x290...                   No
Probing for `Winbond W83782D' at 0x290...                   No

Lastly, we can probe the I2C/SMBus adapters for connected hardware
monitoring devices. This is the most risky part, and while it works
reasonably well on most systems, it has been reported to cause trouble
on some systems.
Do you want to probe the I2C/SMBus adapters now? (YES/no):
Using driver `i2c-i801' for device 0000:00:1f.3: Intel Cougar Point (PCH)
Use of uninitialized value $result in pattern match (m//) at 
/usr/sbin/sensors-detect line 3146.
Use of uninitialized value $result in pattern match (m//) at 
/usr/sbin/sensors-detect line 3146.

Next adapter: SMBus I801 adapter at f040 (i2c-0)
Do you want to scan it? (YES/no/selectively):
Client found at address 0x50
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 Yes
     (confidence 8, not a hardware monitoring chip)
Probing for `EDID EEPROM'...                                No
Client found at address 0x52
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 Yes
     (confidence 8, not a hardware monitoring chip)


Now follows a summary of the probes I have just done.
Just press ENTER to continue:

Driver `to-be-written':
   * ISA bus
     Chip `IPMI BMC KCS' (confidence: 8)

Note: there is no driver for IPMI BMC KCS yet.
Check https://hwmon.wiki.kernel.org/device_support_status for updates.

No modules to load, skipping modules configuration.

-- 
Paul C Diem
PCDiem@FoxValley.net
