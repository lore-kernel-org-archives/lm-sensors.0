From: Greg Vickers <daehenoc@optusnet.com.au>
Date: Mon, 22 Oct 2007 11:33:56 +0000
Subject: [lm-sensors] sensors report all zero readings on Dell PowerEdge 830
Message-Id: <471C8AA4.7090903@optusnet.com.au>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I have installed lm-sensors v2.10.1-3 on a Dell PowerEdge 830 with 
Debian Etch (stable) installed on it.  (This version is the version of 
lm-sensors that is part of Debian Etch.)  sensors-detect works and 
detects the i801 chipset:

<snip>
Next adapter: SMBus I801 adapter at 08c0
Do you want to scan it? (YES/no/selectively):
Client found at address 0x08
Client found at address 0x2e
Handled by driver `lm85' (already loaded), chip type `lm85'
Client found at address 0x44
Probing for `Maxim MAX6633/MAX6634/MAX6635'...              No
Client found at address 0x50
Handled by driver `eeprom' (already loaded), chip type `eeprom'
Client found at address 0x52
Handled by driver `eeprom' (already loaded), chip type `eeprom'
Client found at address 0x60
Client found at address 0x69
<snip>
#----cut here----
# I2C adapter drivers
i2c-i801
# Chip drivers
lm85
eeprom
#----cut here----

So those modules are loaded successfully:
# lsmod | egrep "i801|eeprom|i2c|lm85"
i2c_dev                 8548  0
eeprom                  7024  0
lm85                   27556  0
hwmon_vid               2784  1 lm85
i2c_i801                7468  0
i2c_core               19680  4 i2c_dev,eeprom,lm85,i2c_i801

Output from dmesg:
# dmesg | grep i2c
i2c_adapter i2c-0: Unrecognized version/stepping 0x68 Defaulting to LM85.
i2c /dev entries driver

But when I run sensors:
# sensors
lm85-i2c-0-2e
Adapter: SMBus I801 adapter at 08c0
V1.5:       +0.00 V  (min =  +0.00 V, max =  +3.32 V)
VCore:      +0.00 V  (min =  +0.00 V, max =  +2.99 V)
V3.3:       +0.00 V  (min =  +0.00 V, max =  +4.38 V)
V5:        +0.00 V  (min =  +0.00 V, max =  +6.64 V)
V12:       +0.00 V  (min =  +0.00 V, max = +15.94 V)
CPU_Fan:      0 RPM  (min =    0 RPM)                     ALARM
fan2:         0 RPM  (min =    0 RPM)                     ALARM
fan3:         0 RPM  (min =    0 RPM)                     ALARM
fan4:         0 RPM  (min =    0 RPM)                     ALARM
CPU Temp:     +0 C  (low  =  -127 C, high =  +127 C)
Board Temp:   +0 C  (low  =  -127 C, high =  +127 C)
Remote Temp:  +0 C  (low  =  -127 C, high =  +127 C)
CPU_PWM:   255
Fan2_PWM:  255
Fan3_PWM:  255
vid:      +1.088 V  (VRM Version 10.0)

All of the sensors are at zero?  So something is not working :(

I've found a lm-sensors ticket #2182 logged in February this year, 
(http://www.lm-sensors.org/ticket/2182) which appears to be the same 
problem and there hasn't been an update to this ticket.

I posted to the Debian users list and was told that I might have more 
success here :)

I've checked the FAQ and can't find anything in particular relating to 
lm85 or to Dell hosts - am I missing something?

If anyone has any suggestions, hints or tips I would love to hear from you!

Thanks,
Greg

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
