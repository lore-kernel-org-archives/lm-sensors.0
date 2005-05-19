From: palo@bielyvlk.sk (palo)
Date: Thu, 19 May 2005 06:25:34 +0000
Subject: lm85 and emc6d102
Message-Id: <20050131023717.M68048@bielyvlk.sk>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

>email us output of sensors-detect and output of dmesg  
>after ?modprobe lm85?  
>reference  your ticket number  
>you did modprobe a bus driver too, as recommended by sensors-detect, right?  
>  
>don?t worry about smbus-arp  
>  
>  
>MDS 1/29/05  
  
Ticket #: 1865  
  
i now use (test) patch from Rafael Espindola for EMC6D100 and it work OK 
 
board: intel D865GLC 
linux: 2.6.10 + (only) "lm85.c" from 2.6.11-rc2 
lmsensors: 2.9.0 
  
thanks.  
 
ps, will supported "fan speed monitor" in PC87372 with lmsensors ? (is not important) 
  
  
some outputs:  
  
/////////////////////////////////////////////////  
// sensors-detect  
  
[root@vlk 03:47 ~]# lsmod | grep i2c  
i2c_i801                8716  0  
i2c_sensor              3712  0  
i2c_dev                10496  0  
i2c_core               23056  3 i2c_i801,i2c_sensor,i2c_dev  
[root@vlk 03:47 ~]# sensors-detect  
  
This program will help you determine which I2C/SMBus modules you need to  
load to use lm_sensors most effectively. You need to have i2c and  
lm_sensors installed before running this program.  
Also, you need to be `root', or at least have access to the /dev/i2c/*  
files, for most things.  
If you have patched your kernel and have some drivers built in, you can  
safely answer NO if asked to load some modules. In this case, things may  
seem a bit confusing, but they will still work.  
  
It is generally safe and recommended to accept the default answers to all  
questions, unless you know what you're doing.  
  
 We can start with probing for (PCI) I2C or SMBus adapters.  
 You do not need any special privileges for this.  
 Do you want to probe now? (YES/no): yes  
Probing for PCI bus adapters...  
Use driver `i2c-i801' for device 00:1f.3: Intel 82801EB ICH5  
Probe succesfully concluded.  
  
We will now try to load each adapter module in turn.  
Module `i2c-i801' already loaded.  
If you have undetectable or unsupported adapters, you can have them  
scanned by manually loading the modules before running this script.  
  
 To continue, we need module `i2c-dev' to be loaded.  
 If it is built-in into your kernel, you can safely skip this.  
i2c-dev is already loaded.  
  
 We are now going to do the adapter probings. Some adapters may hang halfway  
 through; we can't really help that. Also, some chips will be double detected;  
 we choose the one with the highest confidence value in that case.  
 If you found that the adapter hung after probing a certain address, you can  
 specify that address to remain unprobed. That often  
 includes address 0x69 (clock chip).  
  
Next adapter: SMBus I801 adapter at c800  
Do you want to scan it? (YES/no/selectively): yes  
Client found at address 0x08  
Client found at address 0x2e  
Probing for `Myson MTP008'... Failed!  
Probing for `National Semiconductor LM78'... Failed!  
Probing for `National Semiconductor LM78-J'... Failed!  
Probing for `National Semiconductor LM79'... Failed!  
Probing for `National Semiconductor LM80'... Failed!  
Probing for `National Semiconductor LM85 or LM96000'... Failed!  
Probing for `Analog Devices ADM1027, ADT7460 or ADT7463'... Failed!  
Probing for `SMSC EMC6D100 or EMC6D101'... Success!  
    (confidence 7, driver `lm85')  
Probing for `Analog Devices ADT7467'... Failed!  
Probing for `National Semiconductor LM87'... Failed!  
Probing for `National Semiconductor LM93'... Failed!  
Probing for `Winbond W83781D'... Failed!  
Probing for `Winbond W83782D'... Failed!  
Probing for `Winbond W83791D'... Failed!  
Probing for `Winbond W83792D'... Failed!  
Probing for `Winbond W83791SD'... Failed!  
Probing for `Winbond W83627HF'... Failed!  
Probing for `Asus AS99127F (rev.1)'... Failed!  
Probing for `Asus AS99127F (rev.2)'... Failed!  
Probing for `Asus ASB100 Bach'... Failed!  
Probing for `Winbond W83L785TS-S'... Failed!  
Probing for `Analog Devices ADM9240'... Failed!  
Probing for `Dallas Semiconductor DS1780'... Failed!  
Probing for `National Semiconductor LM81'... Failed!  
Probing for `Analog Devices ADM1026'... Failed!  
Probing for `Analog Devices ADM1025'... Failed!  
Probing for `Analog Devices ADM1024'... Failed!  
Probing for `Analog Devices ADM1029'... Failed!  
Probing for `Analog Devices ADM1030'... Failed!  
Probing for `Analog Devices ADM1031'... Failed!  
Probing for `Analog Devices ADM1022'... Failed!  
Probing for `Texas Instruments THMC50'... Failed!  
Probing for `Analog Devices ADM1028'... Failed!  
Probing for `ITE IT8705F / IT8712F / SiS 950'... Failed!  
Client found at address 0x44  
Probing for `Maxim MAX6633/MAX6634/MAX6635'... Failed!  
Client found at address 0x50  
Probing for `SPD EEPROM'... Success!  
    (confidence 8, driver `eeprom')  
Probing for `DDC monitor'... Failed!  
Probing for `Maxim MAX6900'... Failed!  
Client found at address 0x52  
Probing for `SPD EEPROM'... Success!  
    (confidence 8, driver `eeprom')  
Client found at address 0x61  
Probing for `SMBus 2.0 ARP-Capable Device'... Success!  
    (confidence 1, driver `smbus-arp')  
Client found at address 0x69  
  
Some chips are also accessible through the ISA bus. ISA probes are  
typically a bit more dangerous, as we have to write to I/O ports to do  
this. This is usually safe though.  
  
Do you want to scan the ISA bus? (YES/no): yes  
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
  Trying address 0x0290... Failed!  
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
this. This is usually safe though.  
  
Do you want to scan for Super I/O sensors? (YES/no): yes  
Probing for `ITE 8702F Super IO Sensors'  
  Failed! (0xf0d1)  
Probing for `ITE 8705F Super IO Sensors'  
  Failed! (0xf0d1)  
Probing for `ITE 8712F Super IO Sensors'  
  Failed! (0xf0d1)  
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'  
  Failed! (0xf0)  
Probing for `Nat. Semi. PC87360 Super IO Fan Sensors'  
  Failed! (0xf0)  
Probing for `Nat. Semi. PC87363 Super IO Fan Sensors'  
  Failed! (0xf0)  
Probing for `Nat. Semi. PC87364 Super IO Fan Sensors'  
  Failed! (0xf0)  
Probing for `Nat. Semi. PC87365 Super IO Fan Sensors'  
  Failed! (0xf0)  
Probing for `Nat. Semi. PC87365 Super IO Voltage Sensors'  
  Failed! (0xf0)  
Probing for `Nat. Semi. PC87365 Super IO Thermal Sensors'  
  Failed! (0xf0)  
Probing for `Nat. Semi. PC87366 Super IO Fan Sensors'  
  Failed! (0xf0)  
Probing for `Nat. Semi. PC87366 Super IO Voltage Sensors'  
  Failed! (0xf0)  
Probing for `Nat. Semi. PC87366 Super IO Thermal Sensors'  
  Failed! (0xf0)  
Probing for `Nat. Semi. PC87372 Super IO Fan Sensors'  
  Success... found at address 0x06e0  
Probing for `Nat. Semi. PC87373 Super IO Fan Sensors'  
  Failed! (0xf0)  
Probing for `Nat. Semi. PC8739x Super IO'  
  Failed! (0xf0)  
Probing for `Nat. Semi. PC8741x Super IO'  
  Failed! (0xf0)  
Probing for `SMSC 47B27x Super IO Fan Sensors'  
  Failed! (0xf0)  
Probing for `SMSC 47M10x/13x Super IO Fan Sensors'  
  Failed! (0xf0)  
Probing for `SMSC 47M14x Super IO Fan Sensors'  
  Failed! (0xf0)  
Probing for `SMSC 47M15x/192 Super IO Fan Sensors'  
  Failed! (0xf0)  
Probing for `SMSC 47S42x Super IO Fan Sensors'  
  Failed! (0xf0)  
Probing for `SMSC 47S45x Super IO Fan Sensors'  
  Failed! (0xf0)  
Probing for `SMSC 47M172 Super IO'  
  Failed! (0xf0)  
Probing for `SMSC LPC47B397-NC Super IO'  
  Failed! (0xf0)  
Probing for `VT1211 Super IO Sensors'  
  Failed! (0xf0)  
Probing for `Winbond W83627HF Super IO Sensors'  
  Failed! (0xf0)  
Probing for `Winbond W83627THF Super IO Sensors'  
  Failed! (0xf0)  
Probing for `Winbond W83637HF Super IO Sensors'  
  Failed! (0xf0)  
Probing for `Winbond W83697HF Super IO Sensors'  
  Failed! (0xf0)  
Probing for `Winbond W83697SF/UF Super IO PWM'  
  Failed! (0xf0)  
Probing for `Winbond W83L517D Super IO'  
  Failed! (0xf0)  
  
Do you want to scan for secondary Super I/O sensors? (YES/no): yes  
Probing for `ITE 8702F Super IO Sensors'  
  Failed! (skipping family)  
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'  
  Failed! (skipping family)  
Probing for `SMSC 47B27x Super IO Fan Sensors'  
  Failed! (skipping family)  
Probing for `VT1211 Super IO Sensors'  
  Failed! (skipping family)  
  
 Now follows a summary of the probes I have just done.  
 Just press ENTER to continue:  
  
Driver `lm85' (should be inserted):  
  Detects correctly:  
  * Bus `SMBus I801 adapter at c800' (Algorithm unavailable)  
    Busdriver `i2c-i801', I2C address 0x2e  
    Chip `SMSC EMC6D100 or EMC6D101' (confidence: 7)  
  
Driver `eeprom' (should be inserted):  
  Detects correctly:  
  * Bus `SMBus I801 adapter at c800' (Algorithm unavailable)  
    Busdriver `i2c-i801', I2C address 0x50  
    Chip `SPD EEPROM' (confidence: 8)  
  * Bus `SMBus I801 adapter at c800' (Algorithm unavailable)  
    Busdriver `i2c-i801', I2C address 0x52  
    Chip `SPD EEPROM' (confidence: 8)  
  
Driver `smbus-arp' (should be inserted):  
  Detects correctly:  
  * Bus `SMBus I801 adapter at c800' (Algorithm unavailable)  
    Busdriver `i2c-i801', I2C address 0x61  
    Chip `SMBus 2.0 ARP-Capable Device' (confidence: 1)  
  
Driver `to-be-written' (should be inserted):  
  Detects correctly:  
  * ISA bus address 0x06e0 (Busdriver `i2c-isa')  
    Chip `Nat. Semi. PC87372 Super IO Fan Sensors' (confidence: 9)  
  
  
 I will now generate the commands needed to load the I2C modules.  
 Sometimes, a chip is available both through the ISA bus and an I2C bus.  
 ISA bus access is faster, but you need to load an additional driver module  
 for it. If you have the choice, do you want to use the ISA bus or the  
 I2C/SMBus (ISA/smbus)? smbus  
  
To make the sensors modules behave correctly, add these lines to  
/etc/modules:  
  
#----cut here----  
# I2C adapter drivers  
i2c-i801  
i2c-isa  
# I2C chip drivers  
lm85  
eeprom  
smbus-arp  
# no driver for Nat. Semi. PC87372 Super IO Fan Sensors yet  
#----cut here----  
  
Do you want to add these lines to /etc/modules automatically? (yes/NO)no  
  
  
////////////////////////////////////////  
// dmesg  
  
dmesg after: modprobe lm85  
  
i2c_adapter i2c-0: lm85: Detected SMSC chip  
i2c_adapter i2c-0: lm85: Unrecognized version/stepping 0x65 Defaulting to Generic LM85.  
  
  
////////////////////////////////////////  
// sensors  
  
[root@vlk 03:53 ~]# sensors  
lm85-i2c-0-2e  
Adapter: SMBus I801 adapter at c800  
V1.5:       +1.47 V  (min =  +0.00 V, max =  +3.32 V)  
VCore:      +1.34 V  (min =  +0.00 V, max =  +2.99 V)  
V3.3:       +3.35 V  (min =  +0.00 V, max =  +4.38 V)  
V5:        +5.03 V  (min =  +0.00 V, max =  +6.64 V)  
V12:      +11.88 V  (min =  +0.00 V, max = +15.94 V)  
CPU_Fan:   2705 RPM  (min =    0 RPM)  
fan2:         0 RPM  (min =    0 RPM)  
fan3:         0 RPM  (min =    0 RPM)  
fan4:         0 RPM  (min =    0 RPM)  
CPU:         +47?C  (low  =  -127?C, high =  +127?C)  
Board:       +33?C  (low  =  -127?C, high =  +127?C)  
Remote:      +37?C  (low  =  -127?C, high =  +127?C)  
CPU_PWM:   255  
Fan2_PWM:  255  
Fan3_PWM:   77  
vid:      +1.387 V  (VRM Version 10.0)  
  
eeprom-i2c-0-52  
Adapter: SMBus I801 adapter at c800  
Memory type:            DDR SDRAM DIMM  
Memory size (MB):       256  
  
eeprom-i2c-0-50  
Adapter: SMBus I801 adapter at c800  
Memory type:            DDR SDRAM DIMM  
Memory size (MB):       256  
  
  
