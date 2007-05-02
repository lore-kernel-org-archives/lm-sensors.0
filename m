From: Rouven Sacha <rouven@blinkenmail.de>
Date: Wed, 02 May 2007 21:33:58 +0000
Subject: [lm-sensors] Negative values after fan replacement
Message-Id: <1178141638.9629.47.camel@camposuperbo>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hi list.


I'm new to the list, this is my first post, so please tell me if there's
any information missing.

After a reaching 75°C high, our hosted server got a forced shutdown due
to an acpi event today.

May  2 18:41:37 blinkenmail kernel: ACPI: Critical trip point
May  2 18:41:37 blinkenmail kernel: Critical temperature reached (76 C),
shutting down.
May  2 18:41:37 blinkenmail shutdown[2522]: shutting down for system
halt
May  2 18:41:37 blinkenmail kernel: ACPI: Unable to turn cooling device
[c1b17dec] 'on'
May  2 18:41:38 blinkenmail init: Switching to runlevel: 0
May  2 18:41:43 blinkenmail kernel: ACPI: Critical trip point
May  2 18:41:43 blinkenmail kernel: Critical temperature reached (75 C),
shutting down.
May  2 18:41:43 blinkenmail kernel: ACPI: Unable to turn cooling device
[c1b17dec] 'on'


It's a debian etch xen-dom0 running linux 2.6.18-4. I tried to
investigate, so I installed lm-sensors ( 2.10.1-3).

sensors-detect:

Driver `eeprom' (should be inserted):
  Detects correctly:
  * Bus `SMBus Via Pro adapter at 5000'
    Busdriver `i2c-viapro', I2C address 0x50
    Chip `eeprom' (confidence: 6)
  * Bus `SMBus Via Pro adapter at 5000'
    Busdriver `i2c-viapro', I2C address 0x51
    Chip `eeprom' (confidence: 6)

Driver `w83627hf' (should be inserted):
  Detects correctly:
  * ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `Winbond W83697HF Super IO Sensors' (confidence: 9)

modprobed: i2c-viapro eeprom w83627hf

23:29:57 blinkenmail:~ # lsmod
Module                  Size  Used by
i2c_dev                 9316  0 
tun                    11104  1 
ipv6                  229088  34 
dm_snapshot            16320  0 
dm_mirror              20048  0 
dm_mod                 51000  2 dm_snapshot,dm_mirror
w83627hf               23344  0 
hwmon_vid               3552  1 w83627hf
eeprom                  7792  0 
i2c_isa                 5920  1 w83627hf
i2c_viapro              9012  0 
i2c_core               20480  5
i2c_dev,w83627hf,eeprom,i2c_isa,i2c_viapro
tulip                  48768  0 
shpchp                 33632  0 
pci_hotplug            29472  1 shpchp
psmouse                35880  0 
pcspkr                  3840  0 
serio_raw               7428  0 
via_agp                10432  1 
agpgart                32264  1 via_agp
evdev                   9856  0 
rtc                    13300  0 
ext3                  120072  1 
jbd                    53224  1 ext3
mbcache                 9124  1 ext3
ide_disk               15712  3 
via82cxxx               9156  0 [permanent]
generic                 6244  0 [permanent]
ide_core              112392  3 ide_disk,via82cxxx,generic
via_rhine              24456  0 
mii                     6112  1 via_rhine
ehci_hcd               29288  0 
uhci_hcd               22188  0 
sata_via               10980  0 
usbcore               114372  3 ehci_hcd,uhci_hcd
libata                 90868  1 sata_via
scsi_mod              125160  1 libata
thermal                14376  0 
processor              29608  1 thermal
fan                     5572  0 


and sensors gave me:

21:01:27 blinkenmail:plugins # sensors
        w83697hf-isa-0290
        Adapter: ISA adapter
        VCore:     +1.68 V  (min =  +0.26 V, max =  +0.54 V)
        ALARM  
        +3.3V:     +3.26 V  (min =  +0.66 V, max =  +3.87
        V)              
        +5V:       +5.03 V  (min =  +0.03 V, max =  +0.86 V)
        ALARM  
        +12V:     +11.49 V  (min =  +5.72 V, max =  +4.99 V)
        ALARM  
        -12V:     -11.62 V  (min = -13.59 V, max =  -3.07
        V)              
        -5V:       -4.90 V  (min =  +0.53 V, max =  -2.89 V)
        ALARM  
        V5SB:      +5.43 V  (min =  +5.46 V, max =  +1.29 V)
        ALARM  
        VBat:      +3.28 V  (min =  +0.14 V, max =  +1.04 V)
        ALARM  
        fan1:     2220 RPM  (min = 4963 RPM, div = 8)
        ALARM  
        fan2:     4017 RPM  (min = 2481 RPM, div         8)                     
        temp1:       +28°C  (high =   +64°C, hyst =  -102°C)   sensor         thermistor           
        temp2:     +68.5°C  (high =   +75°C, hyst =   +70°C)   sensor         diode           
        alarms:   Chassis intrusion detection                      ALARM
        beep_enable:
                  Sound alarm enabled
        
The system had a load of under 0.10 and the values for temp1 changed
between 65 and 69°C. I told the support guy of our hoster that there
might be something wrong with the cpu fan and he replaced it with a new
one, he said.

Now sensors gives me a constant value of -93,5°C for temp2:

23:24:13 blinkenmail:~ # sensors
w83697hf-isa-0290
Adapter: ISA adapter
VCore:     +1.68 V  (min =  +0.26 V, max =  +0.54 V)       ALARM  
+3.3V:     +3.25 V  (min =  +0.66 V, max =  +3.89 V)              
+5V:       +5.03 V  (min =  +0.03 V, max =  +0.86 V)       ALARM  
+12V:     +11.55 V  (min =  +5.59 V, max =  +4.99 V)       ALARM  
-12V:     -11.54 V  (min = -14.91 V, max =  -3.07 V)              
-5V:       -4.90 V  (min =  +0.53 V, max =  -6.10 V)       ALARM  
V5SB:      +5.46 V  (min =  +5.46 V, max =  +1.29 V)       ALARM  
VBat:      +3.28 V  (min =  +0.14 V, max =  +1.04 V)       ALARM  
fan1:     2556 RPM  (min = 4963 RPM, div = 8)              ALARM  
fan2:     4017 RPM  (min = 2481 RPM, div = 8)                     
temp1:       +33�C  (high =   +64�C, hyst =  -102�C)   sensor thermistor           
temp2:     -93.5�C  (high =   +75�C, hyst =   +70�C)   sensor diode           
alarms:   Chassis intrusion detection                      ALARM
beep_enable:
          Sound alarm enabled


What does that mean?

Any hints are appreciated,

Rouven Sacha




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
