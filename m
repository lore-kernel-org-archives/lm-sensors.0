From: sandreas41@yahoo.com (Stewart Andreason)
Date: Mon, 23 May 2005 08:27:45 +0000
Subject: [lm-sensors] report of sensor inaccuracy for hardware
Message-Id: <20050523035157.47128.qmail@web30911.mail.mud.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I am running Linux-2.4.30 with the 2 patches:
 i2c-2.9.1.tar.gz and lm_sensors-2.9.1.tar.gz
Hardware is Asus A7V8X-X (with AMD Athlon XP 1700 cpu)

output from:
# sensors-detect
Probing for PCI bus adapters...
Use driver `i2c-viapro' for device 00:11.0: VIA
Technologies VT8233A/8235
South Bridge
Probe succesfully concluded.

Load `i2c-viapro'
Module loaded succesfully.

i2c-dev is not loaded. Do you want to load it now?
(YES/no):
Module loaded succesfully.

Next adapter: SMBus Via Pro adapter at e800

Do you want to scan it? (YES/no/selectively):
Client found at address 0x37
Client found at address 0x50
Probing for `SPD EEPROM'... Success!
    (confidence 8, driver `eeprom')
Client found at address 0x51
Probing for `SPD EEPROM'... Success!
    (confidence 8, driver `eeprom')
Client found at address 0x69

Probing for `ITE IT8712F'
  Trying address 0x0290... Success!
    (confidence 8, driver `it87')

Probing for `ITE 8712F Super IO Sensors'
  Success... found at address 0x0290

Driver `eeprom' (should be inserted):
  Detects correctly:
  * Bus `SMBus Via Pro adapter at e800' (Non-I2C SMBus
adapter)
    Busdriver `i2c-viapro', I2C address 0x50
    Chip `SPD EEPROM' (confidence: 8)
  * Bus `SMBus Via Pro adapter at e800' (Non-I2C SMBus
adapter)
    Busdriver `i2c-viapro', I2C address 0x51
    Chip `SPD EEPROM' (confidence: 8)

Driver `it87' (should be inserted):
  Detects correctly:
  * ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `ITE 8712F Super IO Sensors' (confidence: 9)

/etc/modules.conf:

#----cut here----
# I2C module options
alias char-major-89 i2c-dev
#----cut here----

To load everything that is needed, add this to some
/etc/rc* file:

#----cut here----
# I2C adapter drivers
modprobe i2c-viapro
modprobe i2c-isa
# I2C chip drivers
# Warning: the required module eeprom is not currently
installed on your
system.

# If driver is built-in to the kernel, or unavailable,
comment out the
following line.
modprobe eeprom
modprobe it87
# sleep 2 # optional
/usr/local/bin/sensors -s # recommended
#----cut here----


# sensors
it8712-isa-0290
Adapter: ISA adapter
VCore 1:   +1.79 V  (min =  +1.42 V, max =  +1.57 V)  
ALARM
VCore 2:   +0.00 V  (min =  +2.40 V, max =  +2.61 V)  
ALARM
+3.3V:     +6.72 V  (min =  +3.14 V, max =  +3.46 V)  
ALARM
+5V:       +4.92 V  (min =  +4.74 V, max =  +5.24 V)
+12V:     +12.16 V  (min = +11.40 V, max = +12.60 V)
-12V:     -27.36 V  (min = -12.63 V, max = -11.41 V)  
ALARM
-5V:      -13.64 V  (min =  -5.24 V, max =  -4.76 V)  
ALARM
Stdby:     +4.89 V  (min =  +4.74 V, max =  +5.24 V)
VBat:      +4.08 V
fan1:     4192 RPM  (min =     RPM, div = 2)
fan2:         RPM  (min = 3000 RPM, div = 2)         
ALARM
fan3:         RPM  (min = 3000 RPM, div = 2)         
ALARM
M/B Temp:    +36 C  (low  =   +15 C, high =   +40 C)  
sensor = thermistor
CPU Temp:    +30 C  (low  =   +15 C, high =   +45 C)  
sensor = thermistor
Temp3:        -1 C  (low  =   +15 C, high =   +45 C)  
sensor = disabled

Fan2 is missing (does show in Bios/Setup)
M/B Temp and CPU Temp are reversed.
voltages are ... interesting.

The only module I didn't load is eeprom, as I can't
find it in kernel-config.

Any ideas?

Stewart




		
Discover Yahoo! 
Use Yahoo! to plan a weekend, have fun online and more. Check it out! 
http://discover.yahoo.com/

