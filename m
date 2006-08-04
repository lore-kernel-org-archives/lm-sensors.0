From: m-dettling@gmx.de (Matthias Dettling)
Date: Fri, 04 Aug 2006 09:57:58 +0000
Subject: [lm-sensors] Strange problem with lm-sensors and module eeprom
Message-Id: <44D31A26.3000103@gmx.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

i have a strange problem with lm-sensors and the eeprom module.
On my Tyan Mainboard (S5350) I get all values of the temperature and fan 
sensors, but the memory modules are not listed on the output of sensors.

The problem is that in /sys/bus/i2c/drivers/eeprom for every memory 
module an entry exists and therefore the output of decode-dimms.pl 
delivers the correct informations about the memory.

Thus I think there should be a problem with the sensors program or maybe 
with the config file.

I have Kernel 2.6.17 on Gentoo Linux with lm-sensors 2.10.0.

Has anyone an idea what could be?

Best Regards
Matthias Dettling



---------------------------------------------------------------------------
localhost eeprom # decode-dimms.pl

PC DIMM Serial Presence Detect Tester/Decoder
By Philip Edelbrock, Christian Zuckschwerdt, Burkart Lingner,
Jean Delvare and others
Version 2.10.0


Decoding EEPROM: /sys/bus/i2c/drivers/eeprom/0-0053
Guessing DIMM is in                             bank 4 


---== The Following is Required Data and is Applicable to all DIMM 
Types ==---
EEPROM Checksum of bytes 0-62                   OK (0x76) 

# of bytes written to SDRAM EEPROM              128 

Total number of bytes in EEPROM                 256 

Fundamental Memory type                         DDR SDRAM 

Number of Row Address Bits (SDRAM only)         13 

Number of Col Address Bits (SDRAM only)         11 

Number of Module Rows                           2 

Data Width (SDRAM only)                         72 

Module Interface Signal Levels                  SSTL 2.5 

Cycle Time (SDRAM) highest CAS latency          6ns 

Maximum module speed                            DDR 333MHz (PC2700) 

Access Time (SDRAM)                             7ns 

Module Configuration Type                       ECC 

Refresh Type                                    Self Refreshing 

Refresh Rate                                    Reduced (7.8uS) 

Primary SDRAM Component Bank Config             No Bank2 OR Bank2 = 
Bank1 width
Primary SDRAM Component Widths                  8 

Error Checking SDRAM Component Bank Config      No Bank2 OR Bank2 = 
Bank1 width
Error Checking SDRAM Component Widths           8 

Min Clock Delay for Back to Back Random Access  1 


---== The Following Apply to SDRAM DIMMs ONLY ==---
Burst lengths supported                         Burst Length = 2 

                                                 Burst Length = 4 

                                                 Burst Length = 8 

Number of Device Banks                          4 

Supported CAS Latencies                         CAS Latency = 3 

                                                 CAS Latency = 4 

Supported CS Latencies                          CS Latency = 0 

Supported WE Latencies                          WE Latency = 1 

SDRAM Module Attributes                         Registered 
Address/Control Inputs
                                                 On card PLL (clock) 

                                                 Differential Clock 
Input
SDRAM Device Attributes (General)               Lower VCC Tolerance: 10% 

                                                 Upper VCC Tolerance: 
10%
                                                 Undefined (bit 6) 

                                                 Undefined (bit 7) 

SDRAM Cycle Time (2nd highest CAS)              7.5nS 

SDRAM Access from Clock Time (2nd highest CAS)  7nS 


---== The Following are Optional (may be Bogus) ==---
SDRAM Cycle Time (3rd highest CAS)              Undefined! 

SDRAM Access from Clock Time (3rd highest CAS)  Undefined! 


---== The Following are Required (for SDRAMs) ==---
Minimum Row Precharge Time                      72nS 

Row Active to Row Active Min                    48nS 

RAS to CAS Delay                                72nS 

Min RAS Pulse Width                             42nS 


---== The Following are Required and Apply to ALL DIMMs ==---
Row Densities                                   512 MByte 


---== The Following are Proposed and Apply to SDRAM DIMMs ==---
Command and Address Signal Setup Time           0nS 

Command and Address Signal Hold Time            0nS 

Data Signal Setup Time                          4.5nS 

Data Signal Hold Time                           4.5nS 

SPD Revision code                               10 

Manufacturer                                    Kingston 

Manufacturing Location Code                     0x04 

Part Number                                     128Mx72D333C25 

Revision Code                                   0x0031 

Manufacturing Date                              0x0618 

Assembly Serial Number                          0x01167EF4 

Intel Specification for Frequency               Undefined! 

Intel Spec Details for 100MHz Support           Junction Temp B (100 
degrees C)
                                                 Single Sided DIMM 



Decoding EEPROM: /sys/bus/i2c/drivers/eeprom/0-0057
Guessing DIMM is in                             bank 8 


---== The Following is Required Data and is Applicable to all DIMM 
Types ==---
EEPROM Checksum of bytes 0-62                   OK (0x76) 

# of bytes written to SDRAM EEPROM              128 

Total number of bytes in EEPROM                 256 

Fundamental Memory type                         DDR SDRAM 

Number of Row Address Bits (SDRAM only)         13 

Number of Col Address Bits (SDRAM only)         11 

Number of Module Rows                           2 

Data Width (SDRAM only)                         72 

Module Interface Signal Levels                  SSTL 2.5 

Cycle Time (SDRAM) highest CAS latency          6ns 

Maximum module speed                            DDR 333MHz (PC2700) 

Access Time (SDRAM)                             7ns 

Module Configuration Type                       ECC 

Refresh Type                                    Self Refreshing 

Refresh Rate                                    Reduced (7.8uS) 

Primary SDRAM Component Bank Config             No Bank2 OR Bank2 = 
Bank1 width
Primary SDRAM Component Widths                  8 

Error Checking SDRAM Component Bank Config      No Bank2 OR Bank2 = 
Bank1 width
Error Checking SDRAM Component Widths           8 

Min Clock Delay for Back to Back Random Access  1 


---== The Following Apply to SDRAM DIMMs ONLY ==---
Burst lengths supported                         Burst Length = 2 

                                                 Burst Length = 4 

                                                 Burst Length = 8 

Number of Device Banks                          4 

Supported CAS Latencies                         CAS Latency = 3 

                                                 CAS Latency = 4 

Supported CS Latencies                          CS Latency = 0 

Supported WE Latencies                          WE Latency = 1 

SDRAM Module Attributes                         Registered 
Address/Control Inputs
                                                 On card PLL (clock) 

                                                 Differential Clock 
Input
SDRAM Device Attributes (General)               Lower VCC Tolerance: 10% 

                                                 Upper VCC Tolerance: 
10%
                                                 Undefined (bit 6) 

                                                 Undefined (bit 7) 

SDRAM Cycle Time (2nd highest CAS)              7.5nS 

SDRAM Access from Clock Time (2nd highest CAS)  7nS 


---== The Following are Optional (may be Bogus) ==---
SDRAM Cycle Time (3rd highest CAS)              Undefined! 

SDRAM Access from Clock Time (3rd highest CAS)  Undefined! 


---== The Following are Required (for SDRAMs) ==---
Minimum Row Precharge Time                      72nS 

Row Active to Row Active Min                    48nS 

RAS to CAS Delay                                72nS 

Min RAS Pulse Width                             42nS 


---== The Following are Required and Apply to ALL DIMMs ==---
Row Densities                                   512 MByte 


---== The Following are Proposed and Apply to SDRAM DIMMs ==---
Command and Address Signal Setup Time           0nS 

Command and Address Signal Hold Time            0nS 

Data Signal Setup Time                          4.5nS 

Data Signal Hold Time                           4.5nS 

SPD Revision code                               10 

Manufacturer                                    Kingston 

Manufacturing Location Code                     0x04 

Part Number                                     128Mx72D333C25 

Revision Code                                   0x0031 

Manufacturing Date                              0x0618 

Assembly Serial Number                          0x0116E4F4 

Intel Specification for Frequency               Undefined! 

Intel Spec Details for 100MHz Support           Junction Temp B (100 
degrees C)
                                                 Single Sided DIMM 



Number of SDRAM DIMMs detected and decoded: 2

---------------------------------------------------------------------------
localhost eeprom # sensors
lm85b-i2c-0-2d
Adapter: SMBus I801 adapter at 1100

5V StandBy:
             +5.13 V  (min =  +4.74 V, max =  +5.26 V)
CPU Voltage:
             +1.30 V  (min =  +1.28 V, max =  +1.42 V)
+5V:       +5.08 V  (min =  +4.74 V, max =  +5.26 V)
+12V:     +12.12 V  (min = +11.38 V, max = +12.62 V)
CPU0 Fan:  3784 RPM  (min =    0 RPM)
CPU1 Fan:  4492 RPM  (min =    0 RPM)
Fan5:         0 RPM  (min =    0 RPM)
CPU0 Temp:   +44 C  (low  =  -127 C, high =  +127 C)
CPU1 Temp:   +38 C  (low  =  -127 C, high =  +127 C)
vid:      +1.850 V  (VRM Version 9.1)

adm1027-i2c-0-2e
Adapter: SMBus I801 adapter at 1100

+2.5V:     +2.620 V  (min =  +2.37 V, max =  +2.63 V)
3.3V StandBy:
            +3.334 V  (min =  +3.13 V, max =  +3.47 V)
Fan1:         0 RPM  (min =    0 RPM)
Fan2:         0 RPM  (min =    0 RPM)
Fan3:         0 RPM  (min =    0 RPM)
Fan4:         0 RPM  (min =    0 RPM)
VRM0 Temp:+44.50 C  (low  =  -128 C, high =  +127 C)
VRM1 Temp:+56.00 C  (low  =  -127 C, high =  +127 C)
vid:      +1.087 V  (VRM Version 10.0)

localhost eeprom #

---------------------------------------------------------------------------
#
# I2C support
#
CONFIG_I2C=y
CONFIG_I2C_CHARDEV=y

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=m
CONFIG_I2C_ALGOPCF=m
CONFIG_I2C_ALGOPCA=m

#
# I2C Hardware Bus support
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
CONFIG_I2C_I801=y
# CONFIG_I2C_I810 is not set
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_PARPORT is not set
# CONFIG_I2C_PARPORT_LIGHT is not set
# CONFIG_I2C_PROSAVAGE is not set
# CONFIG_I2C_SAVAGE4 is not set
# CONFIG_SCx200_ACB is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_STUB is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set
# CONFIG_I2C_VOODOO3 is not set
# CONFIG_I2C_PCA_ISA is not set

#
# Miscellaneous I2C Chip support
#
CONFIG_SENSORS_DS1337=y
# CONFIG_SENSORS_DS1374 is not set
CONFIG_SENSORS_EEPROM=m
# CONFIG_SENSORS_PCF8574 is not set
# CONFIG_SENSORS_PCA9539 is not set
# CONFIG_SENSORS_PCF8591 is not set
# CONFIG_SENSORS_MAX6875 is not set
CONFIG_I2C_DEBUG_CORE=y
CONFIG_I2C_DEBUG_ALGO=y
CONFIG_I2C_DEBUG_BUS=y
CONFIG_I2C_DEBUG_CHIP=y

...

#
# Hardware Monitoring support
#
CONFIG_HWMON=y
CONFIG_HWMON_VID=m
# CONFIG_SENSORS_ADM1021 is not set
# CONFIG_SENSORS_ADM1025 is not set
# CONFIG_SENSORS_ADM1026 is not set
# CONFIG_SENSORS_ADM1031 is not set
# CONFIG_SENSORS_ADM9240 is not set
# CONFIG_SENSORS_ASB100 is not set
# CONFIG_SENSORS_ATXP1 is not set
# CONFIG_SENSORS_DS1621 is not set
# CONFIG_SENSORS_F71805F is not set
# CONFIG_SENSORS_FSCHER is not set
# CONFIG_SENSORS_FSCPOS is not set
# CONFIG_SENSORS_GL518SM is not set
# CONFIG_SENSORS_GL520SM is not set
# CONFIG_SENSORS_IT87 is not set
# CONFIG_SENSORS_LM63 is not set
# CONFIG_SENSORS_LM75 is not set
# CONFIG_SENSORS_LM77 is not set
# CONFIG_SENSORS_LM78 is not set
# CONFIG_SENSORS_LM80 is not set
# CONFIG_SENSORS_LM83 is not set
CONFIG_SENSORS_LM85=m
# CONFIG_SENSORS_LM87 is not set
# CONFIG_SENSORS_LM90 is not set
# CONFIG_SENSORS_LM92 is not set
# CONFIG_SENSORS_MAX1619 is not set
# CONFIG_SENSORS_PC87360 is not set
# CONFIG_SENSORS_SIS5595 is not set
# CONFIG_SENSORS_SMSC47M1 is not set
# CONFIG_SENSORS_SMSC47B397 is not set
# CONFIG_SENSORS_VIA686A is not set
# CONFIG_SENSORS_VT8231 is not set
# CONFIG_SENSORS_W83781D is not set
# CONFIG_SENSORS_W83792D is not set
# CONFIG_SENSORS_W83L785TS is not set
# CONFIG_SENSORS_W83627HF is not set
# CONFIG_SENSORS_W83627EHF is not set
# CONFIG_SENSORS_HDAPS is not set
CONFIG_HWMON_DEBUG_CHIP=y

