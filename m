From: Glenn Hollowell <temp1@blepsias.net>
Date: Mon, 26 Mar 2012 20:21:25 +0000
Subject: Re: [lm-sensors] Not detecting all fan RPMs
Message-Id: <1332793285.10230.12.camel@dfghom-gjhollo2.site>
List-Id: <lm-sensors.vger.kernel.org>
References: <1332789633.10230.9.camel@dfghom-gjhollo2.site>
In-Reply-To: <1332789633.10230.9.camel@dfghom-gjhollo2.site>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Thanks Jean and Guenter, see below for SENSORS -version and -detect. gh

user@dfdot-user1:~> sensors -v
sensors version 3.3.2 with libsensors version 3.3.2 
user@dfdot-user1:~> sensors-detect
# sensors-detect revision 5984 (2011-07-10 21:22:53 +0200)
# System: To Be Filled By O.E.M. To Be Filled By O.E.M. [To Be Filled By
O.E.M.]
# Board: ASRock 880G Extreme3

This program will help you determine which kernel modules you need
to load to use lm_sensors most effectively. It is generally safe
and recommended to accept the default answers to all questions,
unless you know what you're doing.

Some south bridges, CPUs or memory controllers contain embedded sensors.
Do you want to scan for them? This is totally safe. (YES/no): 
Module cpuid loaded successfully.
Silicon Integrated Systems SIS5595...                       No
VIA VT82C686 Integrated Sensors...                          No
VIA VT8231 Integrated Sensors...                            No
AMD K8 thermal sensors...                                   No
AMD Family 10h thermal sensors...                           Success!
    (driver `k10temp')
AMD Family 11h thermal sensors...                           No
AMD Family 12h and 14h thermal sensors...                   No
AMD Family 15h thermal sensors...                           No
AMD Family 15h power sensors...                             No
Intel digital thermal sensor...                             No
Intel AMB FB-DIMM thermal sensor...                         No
VIA C7 thermal sensor...                                    No
VIA Nano thermal sensor...                                  No

Some Super I/O chips contain embedded sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no): 
Probing for Super-I/O at 0x2e/0x2f
Trying family `National Semiconductor/ITE'...               No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Nuvoton/Fintek'...               Yes
Found `Nuvoton W83677HG-I (NCT6771F/NCT6772F/NCT6775F) Super IO
Sensors'Success!
    (address 0x290, driver `w83627ehf')
Probing for Super-I/O at 0x4e/0x4f
Trying family `National Semiconductor/ITE'...               No
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
ISA slots! Do you want to scan the ISA I/O ports? (yes/NO): yes
Probing for `National Semiconductor LM78' at 0x290...       No
Probing for `National Semiconductor LM79' at 0x290...       No
Probing for `Winbond W83781D' at 0x290...                   No
Probing for `Winbond W83782D' at 0x290...                   No

Lastly, we can probe the I2C/SMBus adapters for connected hardware
monitoring devices. This is the most risky part, and while it works
reasonably well on most systems, it has been reported to cause trouble
on some systems.
Do you want to probe the I2C/SMBus adapters now? (YES/no): yes
Using driver `i2c-piix4' for device 0000:00:14.0: ATI Technologies Inc
SB600/SB700/SB800 SMBus
Module i2c-dev loaded successfully.

Next adapter: nouveau-0000:04:00.0-2 (i2c-0)
Do you want to scan it? (YES/no/selectively): yes

Next adapter: nouveau-0000:04:00.0-0 (i2c-1)
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

Next adapter: nouveau-0000:04:00.0-1 (i2c-2)
Do you want to scan it? (YES/no/selectively): 

Next adapter: SMBus PIIX4 adapter at 0b00 (i2c-3)
Do you want to scan it? (yes/NO/selectively): yes
Client found at address 0x50
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 Yes
    (confidence 8, not a hardware monitoring chip)
Probing for `EDID EEPROM'...                                No
Client found at address 0x51
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 Yes
    (confidence 8, not a hardware monitoring chip)

Now follows a summary of the probes I have just done.
Just press ENTER to continue: 

Driver `w83627ehf':
  * ISA bus, address 0x290
    Chip `Nuvoton W83677HG-I (NCT6771F/NCT6772F/NCT6775F) Super IO
Sensors' (confidence: 9)

Driver `k10temp' (autoloaded):
  * Chip `AMD Family 10h thermal sensors' (confidence: 9)

Do you want to overwrite /etc/sysconfig/lm_sensors? (YES/no): yes
Copy prog/init/lm_sensors.service to /lib/systemd/system
and run 'systemctl enable lm_sensors.service'
for initialization at boot time.
Unloading i2c-dev... OK
Unloading cpuid... OK

On Mon, 2012-03-26 at 21:44 +0200, Jean Delvare wrote:
> Hi Glenn,
> 
> On Mon, 26 Mar 2012 11:20:33 -0800, Glenn Hollowell wrote:
> > I have an ASRock 880G Extreme motherboard running openSuse linux 12.1. I
> > have been having difficulty seeing all of my chassis and power fan rpms
> > using SENSORS. I have just upgraded to v3.3.2 with no luck.
> > 
> > The mother board has (5) fan plugins. Three of these are for chassis
> > fans, and the other two are labelled "CPU fan" and "PWR fan". The CPU
> > fan and one of the chassis fan (#1) mobo plugins are 4-prong, the others
> > are 3-prong plugs. The pigtails from the 2 chassis fans are 3-prong, as
> > is the power supply plugin. The CPU fan pigtail is a 4-prong.
> > 
> > Currently, I've got chassis fans plugged into CHA_FAN1 and CHA_FAN2, and
> > I've got the power supply fan plugged into PWR_FAN1. The CPU fan is
> > plugged into CPU_FAN1. There is an additional CHA_FAN3 plug on the
> > motherboard.
> > 
> > In bios I get the following readings,
> > 
> > CPU fan 1 = 3750
> > Chasis fan 1 = 1268 
> > Chasis fan 2 = 1278 
> > Chasis fan 3 = NA
> > Power fan 1 = 878 
> > 
> > All of the above seem reasonable and fine.
> > 
> > Below is the output from SENSORS,
> > users@dothom-user1:~> sensors
> > (...)
> > nct6775-isa-0290
> 
> The NCT6775 supports only 4 fans, so either there is some multiplexing
> in place (which we don't support) or you have a second hardware
> monitoring chip on your system.
> 
> Can you please send the full output sensors-detect from lm-sensors
> 3.3.2?
> 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
