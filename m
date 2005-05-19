From: marc@paracel.com (Marc Rieffel)
Date: Thu, 19 May 2005 06:24:21 +0000
Subject: Issues with lm_sensors on Intel SE7501cw2
Message-Id: <9D8C1A43309BAD4A9B46071DAF911D9E3E237D@exch01.paracel.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I submitted this as a ticket yesterday, but it does't seem to have gone through.  I apologize if it's a duplicate.



I have an Intel SE7501cw2 motherboard with dual 2.4 GHz processors in a 1U chassis.  This motherboard has a Winbond w83627hf chip and a max 6650 (or 6651) chip.  

Most of my fans are Sunon GM1204PQV1-8A fans, which should run at 9200 RPM according to the manufacturer.

I'm running RH9 and lm_sensors 2.8.1.

If I plug and unplug the fans, I'm able to correlate their readings with sensors reports.  max6650-ic-0-1b's four fans correspond to sys3 (J29) sys4 (J30), cpu1 (J16), and cpu2 (J14), respectively.  w83627hf's three fans correspond to sys2 (J3), sys1 (J1), and sys5 (J58).  This information may be useful to someone else.


I have several issues.

1. sensors-detect recommends w83781d, which doesn't seem to work, but doesn't recommend w83627hf, which does seem to work.


Output of sensors-detect:

[root@gb0007 lm_sensors-2.8.1]# prog/detect/sensors-detect

This program will help you determine which I2C/SMBus modules you need to
load to use lm_sensors most effectively. You need to have i2c and
lm_sensors installed before running this program.
Also, you need to be `root', or at least have access to the /dev/i2c-*
files, for most things.
If you have patched your kernel and have some drivers built-in, you can
safely answer NO if asked to load some modules. In this case, things may
seem a bit confusing, but they will still work.

 BIOS vendor (ACPI): PTLTD
 System vendor (DMI): Intel Corporation
 BIOS version (DMI): E7501CW20.86B.0023.P05.0306201836
 We can start with probing for (PCI) I2C or SMBus adapters.
 You do not need any special privileges for this.
 Do you want to probe now? (YES/no):
Probing for PCI bus adapters...
Use driver `i2c-i801' for device 00:1f.3: Intel 82801CA/CAM ICH3
Probe succesfully concluded.

 We will now try to load each adapter module in turn.
Load `i2c-i801' (say NO if built into your kernel)? (YES/no):
Module loaded succesfully.
 Do you now want to be prompted for non-detectable adapters? (yes/NO):
 To continue, we need module `i2c-dev' to be loaded.
 If it is built-in into your kernel, you can safely skip this.
 i2c-dev is not loaded. Do you want to load it now? (YES/no):
 Module loaded succesfully.

 We are now going to do the adapter probings. Some adapters may hang halfway
 through; we can't really help that. Also, some chips will be double detected;
 we choose the one with the highest confidence value in that case.
 If you found that the adapter hung after probing a certain address, you can
 specify that address to remain unprobed. That often
 includes address 0x69 (clock chip).

Next adapter: SMBus I801 adapter at 1100 (Non-I2C SMBus adapter)
Do you want to scan it? (YES/no/selectively):
Client found at address 0x1b
Probing for `Maxim MAX6650/MAX6651'... Success!
    (confidence 4, driver `max6650')
Client found at address 0x1f
Probing for `Maxim MAX6650/MAX6651'... Failed!
Client found at address 0x30
Client found at address 0x31
Client found at address 0x34
Client found at address 0x35
Client found at address 0x50
Probing for `SPD EEPROM'... Success!
    (confidence 8, driver `eeprom')
Probing for `DDC monitor'... Failed!
Client found at address 0x51
Probing for `SPD EEPROM'... Success!
    (confidence 8, driver `eeprom')
Client found at address 0x54
Probing for `SPD EEPROM'... Success!
    (confidence 8, driver `eeprom')
Client found at address 0x55
Probing for `SPD EEPROM'... Success!
    (confidence 8, driver `eeprom')
Client found at address 0x69

 Some chips are also accessible through the ISA bus. ISA probes are
 typically a bit more dangerous, as we have to write to I/O ports to do
 this.  Do you want to scan the ISA bus? (YES/no):
Probing for `National Semiconductor LM78'
  Trying address 0x0290... Failed!
Probing for `National Semiconductor LM78-J'
  Trying address 0x0290... Failed!
Probing for `National Semiconductor LM79'
  Trying address 0x0290... Failed!
Probing for `Winbond W83781D'
  Trying address 0x0290... Failed!
Probing for `Winbond W83782D'
  Trying address 0x0290... Failed!
Probing for `Winbond W83627HF'
  Trying address 0x0290... Success!
    (confidence 8, driver `w83781d')
Probing for `Winbond W83697HF'
  Trying address 0x0290... Failed!
Probing for `Silicon Integrated Systems SIS5595'
  Trying general detect... Failed!
Probing for `VIA Technologies VT82C686 Integrated Sensors'
  Trying general detect... Failed!
Probing for `VIA Technologies VT8231 Integrated Sensors'
  Trying general detect... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'
  Trying address 0x0290... Failed!
Probing for `IPMI BMC KCS'
  Trying address 0x0ca0... Failed!
Probing for `IPMI BMC SMIC'
  Trying address 0x0ca8... Failed!

 Some Super I/O chips may also contain sensors. Super I/O probes are
 typically a bit more dangerous, as we have to write to I/O ports to do
 this.  Do you want to scan for Super I/O sensors? (YES/no):
Probing for `SMSC 47M10x Super IO Fan Sensors'
  Failed! (0x00)
Probing for `SMSC 47M14x Super IO Fan Sensors'
  Failed! (0x00)
Probing for `VT1211 Super IO Sensors'
  Failed! (0x52)
Probing for `Winbond W83627HF Super IO Sensors'
  Success... found at address 0x0290
Probing for `Winbond W83627THF Super IO Sensors'
  Failed! (0x52)
Probing for `Winbond W83697HF Super IO Sensors'
  Failed! (0x52)

 Now follows a summary of the probes I have just done.
 Just press ENTER to continue:

Driver `max6650' (should be inserted):
  Detects correctly:
  * Bus `SMBus I801 adapter at 1100' (Non-I2C SMBus adapter)
    Busdriver `i2c-i801', I2C address 0x1b
    Chip `Maxim MAX6650/MAX6651' (confidence: 4)

Driver `eeprom' (should be inserted):
  Detects correctly:
  * Bus `SMBus I801 adapter at 1100' (Non-I2C SMBus adapter)
    Busdriver `i2c-i801', I2C address 0x50
    Chip `SPD EEPROM' (confidence: 8)
  * Bus `SMBus I801 adapter at 1100' (Non-I2C SMBus adapter)
    Busdriver `i2c-i801', I2C address 0x51
    Chip `SPD EEPROM' (confidence: 8)
  * Bus `SMBus I801 adapter at 1100' (Non-I2C SMBus adapter)
    Busdriver `i2c-i801', I2C address 0x54
    Chip `SPD EEPROM' (confidence: 8)
  * Bus `SMBus I801 adapter at 1100' (Non-I2C SMBus adapter)
    Busdriver `i2c-i801', I2C address 0x55
    Chip `SPD EEPROM' (confidence: 8)

Driver `w83781d' (should be inserted):
  Detects correctly:
  * ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `Winbond W83627HF' (confidence: 8)

Driver `w83627hf' (may not be inserted):
  Misdetects:
  * ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `Winbond W83627HF Super IO Sensors' (confidence: 8)


 I will now generate the commands needed to load the I2C modules.
 Sometimes, a chip is available both through the ISA bus and an I2C bus.
 ISA bus access is faster, but you need to load an additional driver module
 for it. If you have the choice, do you want to use the ISA bus or the
 I2C/SMBus (ISA/smbus)?

To make the sensors modules behave correctly, add these lines to
/etc/modules.conf:

#----cut here----
# I2C module options
alias char-major-89 i2c-dev
#----cut here----

To load everything that is needed, add this to some /etc/rc* file:

#----cut here----
# I2C adapter drivers
modprobe i2c-i801
modprobe i2c-isa
# I2C chip drivers
modprobe max6650
modprobe eeprom
modprobe w83781d
# sleep 2 # optional
/usr/local/bin/sensors -s # recommended
#----cut here----

WARNING! If you have some things built into your kernel, the list above
will contain too many modules. Skip the appropriate ones! You really should
try these commands right now to make sure everything is working properly.
Monitoring programs won't work until it's done.

Do you want to generate /etc/sysconfig/lm_sensors? (YES/no):
Copy prog/init/lm_sensors.init to /etc/rc.d/init.d/lm_sensors
for initialization at boot time.



[root@gb0007 lm_sensors-2.8.1]# modprobe i2c-i801
[root@gb0007 lm_sensors-2.8.1]# modprobe i2c-isa
[root@gb0007 lm_sensors-2.8.1]# modprobe max6650
[root@gb0007 lm_sensors-2.8.1]# modprobe eeprom
[root@gb0007 lm_sensors-2.8.1]# modprobe w83781d
[root@gb0007 lm_sensors-2.8.1]# sensors -s


[root@gb0007 lm_sensors-2.8.1]# sensors
max6650-i2c-0-1b
Adapter: SMBus I801 adapter at 1100
Algorithm: Non-I2C SMBus adapter
fan1:     configured 238125 RPM, actual    0 RPM.
fan2:     3270 RPM
fan3:     6750 RPM
fan4:     6390 RPM

eeprom-i2c-0-50
Adapter: SMBus I801 adapter at 1100
Algorithm: Non-I2C SMBus adapter
Memory type:            DDR SDRAM DIMM
Memory size (MB):       256

eeprom-i2c-0-51
Adapter: SMBus I801 adapter at 1100
Algorithm: Non-I2C SMBus adapter
Memory type:            DDR SDRAM DIMM
Memory size (MB):       256

eeprom-i2c-0-54
Adapter: SMBus I801 adapter at 1100
Algorithm: Non-I2C SMBus adapter
Memory type:            DDR SDRAM DIMM
Memory size (MB):       256

eeprom-i2c-0-55
Adapter: SMBus I801 adapter at 1100
Algorithm: Non-I2C SMBus adapter
Memory type:            DDR SDRAM DIMM
Memory size (MB):       256


[root@gb0007 lm_sensors-2.8.1]# rmmod w83781d
[root@gb0007 lm_sensors-2.8.1]# modprobe w83627hf
[root@gb0007 lm_sensors-2.8.1]# sensors -s
[root@gb0007 lm_sensors-2.8.1]# sensors
max6650-i2c-0-1b
Adapter: SMBus I801 adapter at 1100
Algorithm: Non-I2C SMBus adapter
fan1:     configured 238125 RPM, actual    0 RPM.
fan2:     3270 RPM
fan3:     6750 RPM
fan4:     6390 RPM

eeprom-i2c-0-50
Adapter: SMBus I801 adapter at 1100
Algorithm: Non-I2C SMBus adapter
Memory type:            DDR SDRAM DIMM
Memory size (MB):       256

eeprom-i2c-0-51
Adapter: SMBus I801 adapter at 1100
Algorithm: Non-I2C SMBus adapter
Memory type:            DDR SDRAM DIMM
Memory size (MB):       256

eeprom-i2c-0-54
Adapter: SMBus I801 adapter at 1100
Algorithm: Non-I2C SMBus adapter
Memory type:            DDR SDRAM DIMM
Memory size (MB):       256

eeprom-i2c-0-55
Adapter: SMBus I801 adapter at 1100
Algorithm: Non-I2C SMBus adapter
Memory type:            DDR SDRAM DIMM
Memory size (MB):       256

[root@gb0007 lm_sensors-2.8.1]# rmmod w83781d
[root@gb0007 lm_sensors-2.8.1]# modprobe w83627hf
[root@gb0007 lm_sensors-2.8.1]# sensors -s
[root@gb0007 lm_sensors-2.8.1]# sensors
max6650-i2c-0-1b
Adapter: SMBus I801 adapter at 1100
Algorithm: Non-I2C SMBus adapter
fan1:     configured 238125 RPM, actual    0 RPM.
fan2:     3270 RPM
fan3:     6720 RPM
fan4:     6360 RPM

eeprom-i2c-0-50
Adapter: SMBus I801 adapter at 1100
Algorithm: Non-I2C SMBus adapter
Memory type:            DDR SDRAM DIMM
Memory size (MB):       256

eeprom-i2c-0-51
Adapter: SMBus I801 adapter at 1100
Algorithm: Non-I2C SMBus adapter
Memory type:            DDR SDRAM DIMM
Memory size (MB):       256

eeprom-i2c-0-54
Adapter: SMBus I801 adapter at 1100
Algorithm: Non-I2C SMBus adapter
Memory type:            DDR SDRAM DIMM
Memory size (MB):       256

eeprom-i2c-0-55
Adapter: SMBus I801 adapter at 1100
Algorithm: Non-I2C SMBus adapter
Memory type:            DDR SDRAM DIMM
Memory size (MB):       256

w83627hf-isa-0290
Adapter: ISA adapter
Algorithm: ISA algorithm
VCore 1:   +1.44 V  (min =  +1.28 V, max =  +1.40 V)       ALARM
VCore 2:   +1.79 V  (min =  +1.28 V, max =  +1.40 V)
+3.3V:     +3.29 V  (min =  +3.13 V, max =  +3.45 V)
+5V:       +4.91 V  (min =  +4.72 V, max =  +5.24 V)
+12V:     +12.39 V  (min = +10.79 V, max = +13.19 V)
-12V:      +1.74 V  (min = -13.21 V, max = -10.90 V)
-5V:       -0.05 V  (min =  -5.26 V, max =  -4.76 V)
V5SB:      +5.39 V  (min =  +4.72 V, max =  +5.24 V)       ALARM
VBat:      +2.92 V  (min =  +2.40 V, max =  +3.60 V)
fan1:     3125 RPM  (min = 3000 RPM, div = 2)
fan2:     3068 RPM  (min = 3000 RPM, div = 2)
fan3:     3183 RPM  (min =  750 RPM, div = 8)
temp1:       +58?C  (limit =  +60?C)                       sensor = PII/Celeron diode
temp2:     +42.0?C  (limit =  +60?C, hysteresis =  +50?C) sensor = PII/Celeron diode
temp3:     +39.0?C  (limit =  +60?C, hysteresis =  +50?C) sensor = PII/Celeron diode
vid:      +1.350 V
alarms:   Chassis intrusion detection                      ALARM
beep_enable:
          Sound alarm disabled


2. The max6650 fan speed measurement seems to be all or nothing.  If there's a (Sunon) fan connected and operational, it reports 7650RPM.  If there's no fan connected, it reports 0 RPM.  If I physically slow the fan down, it still report 7650 RPM.  (The tachs on the w83627hf sensor do show decreased rpm when I impede their fans).

3. The fan speeds reported (7650 or 18,000-21,000) seem to be inconsistent with the advertised speeds.  Changing the divisors doesn't seem to affect the reported values.

4. The speed control on the max6650 doesn't seem to work.  See below.

Setting max6650's fan speed has no effect:

[root@oscarnode001 root]#  cat /proc/sys/dev//sensors/max6650-i2c-0-1b/speed
238125
[root@oscarnode001 root]#  cat /proc/sys/dev//sensors/max6650-i2c-0-1b/fan1
7650
[root@oscarnode001 root]# echo "1" > /proc/sys/dev//sensors/max6650-i2c-0-1b/speed
[root@oscarnode001 root]#  cat /proc/sys/dev//sensors/max6650-i2c-0-1b/fan1   
7650

[root@oscarnode001 root]# cat /proc/sys/dev//sensors/w83627hf-isa-0290/fan?
2960 21093
1278 16875
750 7336
[root@oscarnode001 root]# cat /proc/sys/dev//sensors/w83627hf-isa-0290/pwm1
255 1
[root@oscarnode001 root]# echo "0 1"> /proc/sys/dev//sensors/w83627hf-isa-0290/pwm1
[root@oscarnode001 root]# cat /proc/sys/dev//sensors/w83627hf-isa-0290/pwm1     0 1
[root@oscarnode001 root]#  cat /proc/sys/dev//sensors/w83627hf-isa-0290/fan?
2960 18750
1278 21093
750 7336

5. The w83627hf's "pwm1" setting seems to have no effect:

[root@oscarnode001 root]# cat /proc/sys/dev//sensors/w83627hf-isa-0290/fan?
2960 21093
1278 16875
750 7336
[root@oscarnode001 root]# cat /proc/sys/dev//sensors/w83627hf-isa-0290/pwm1
255 1
[root@oscarnode001 root]# echo "0 1"> /proc/sys/dev//sensors/w83627hf-isa-0290/pwm1
[root@oscarnode001 root]# cat /proc/sys/dev//sensors/w83627hf-isa-0290/pwm1     0 1
[root@oscarnode001 root]#  cat /proc/sys/dev//sensors/w83627hf-isa-0290/fan?
2960 18750
1278 21093
750 7336


6. The w83627hf's "pwm2" setting is able to reduce the speed of fans 1 and 2, but only to about half.  I can hear them change speed when I do this.  I can't get them to stop completely, though.

[root@oscarnode001 root]#  cat /proc/sys/dev//sensors/w83627hf-isa-0290/fan?
2960 21093
1278 21093
750 7031
[root@oscarnode001 root]# echo "0 1"> /proc/sys/dev//sensors/w83627hf-isa-0290/pwm2
[root@oscarnode001 root]#  cat /proc/sys/dev//sensors/w83627hf-isa-0290/fan?    
2960 11250
1278 12053
750 7670


7.  Changes to the "pwm2" setting seem to be transient.  Something happens to change it back to 255.  

[root@oscarnode001 root]# cat /proc/sys/dev//sensors/w83627hf-isa-0290/pwm2     
0 1
[root@oscarnode001 root]# sleep 60
[root@oscarnode001 root]# cat /proc/sys/dev//sensors/w83627hf-isa-0290/pwm2     
255 1


8. Sometimes the "lm75" module loads and detects something.  I'm not aware of there being any lm75's or compatible devices on this system.  This is what I get when it loads and detects:

lm75-i2c-0-48
Adapter: SMBus I801 adapter at 1100
Algorithm: Non-I2C SMBus adapter
temp:       -1.0?C  (limit =  -1.0?C, hysteresis =  -1.0?C)

lm75-i2c-0-49
Adapter: SMBus I801 adapter at 1100
Algorithm: Non-I2C SMBus adapter
temp:       -1.0?C  (limit =  -1.0?C, hysteresis =  -1.0?C)

9. The lm75's temperature readings are bogus.  At an earlier point I got them to report reasonable values, but I can't get back to that state.

lm75-i2c-0-48
Adapter: SMBus I801 adapter at 1100
Algorithm: Non-I2C SMBus adapter
temp:      +40.5?C  (limit = +60.0?C, hysteresis = +50.0?C)

lm75-i2c-0-49
Adapter: SMBus I801 adapter at 1100
Algorithm: Non-I2C SMBus adapter
temp:      +43.0?C  (limit = +60.0?C, hysteresis = +50.0?C)


10.  The default value for the sensor type on the  w83627hf's temperature sensor, according to sensors.conf, is thermistor (3435).  But for me it seems to be defaulting to "1", PII/Celeron Diode.  That appears to be correct for temp2 and temp3, which I *think* correspond to cpu0 and cpu1 temperatures.  It doesn't make sense for temp1, though, which I *think* corresponds to "ambient" temperature as reported on the bios page.  When I set sensor1 to "2", or 3904 transistor, I get more reasonable values.  Setting it to 3435 (thermistor) gives even worse values.

I think that's all for now.  Thanks.


