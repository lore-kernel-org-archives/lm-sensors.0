From: charles@defenderhosting.com (Charles Galpin)
Date: Thu, 19 May 2005 06:24:43 +0000
Subject: i2c-amd756 and dual opteron sensors not found
Message-Id: <85CC3C14-6640-11D8-8D31-000A958E5EF8@defenderhosting.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <E039AC86-6597-11D8-8D31-000A958E5EF8@defenderhosting.com>
In-Reply-To: <E039AC86-6597-11D8-8D31-000A958E5EF8@defenderhosting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark.

> whatever sensrors you have aren't on your 756 i2c bus.
> Either they are memory-mapped (ISA) or you have another bus.
> You may have an 8111 but the device isn't enabled (746a).
> If you can get it enabled in the bios or elsewhere then try the  
> i2c-amd8111 module.
> Also see FAQ 4.24.3.

There are no options in the bios to turn it on/off. I can give anyone  
root access to the box if it would help you diagnose the status of  
support for this.

This is the system.

http://www.msicomputer.com/product/detail_spec/product_detail.asp? 
model=K1-1000
http://www.msicomputer.com/product/detail_spec/product_detail.asp? 
model=K8D_Master-FT
http://www.msicomputer.com/product/server/K8D_Master-FT(rackmount).pdf

the mainboard is ms-9131 has amd 8111 & 8113 and winbond w83627hf-aw +  
bcm5704

I have looked at the FAQ, but honestly do not know where I stand :)   
The i2c seems supported, but I'm not sure -

[root@opteron root]# service lm_sensors start
Starting up sensors: starting module __i2c-amd756__
starting module __i2c-isa__
starting module __eeprom__
starting module __bmcsensors__
                                                            [  OK  ]
[root@opteron root]# i2cdetect -l
i2c-0   smbus           SMBus AMD756 adapter at 80e0            Non-I2C  
SMBus adapter
i2c-1   dummy           ISA main adapter                        ISA bus  
algorithm
[root@opteron root]# i2cdetect 0
   WARNING! This program can confuse your I2C bus, cause data loss and  
worse!
   I will probe file /dev/i2c-0
   You have five seconds to reconsider and press CTRL-C!

      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: XX XX XX XX XX XX XX XX 08 XX XX XX XX XX XX XX
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
50: XX XX UU UU XX XX XX XX XX XX XX XX XX XX XX XX
60: XX XX XX XX XX XX XX XX XX 69 XX XX XX XX XX XX
70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
[root@opteron root]# i2cdetect 1
Error: Can't use SMBus Quick Write command on this bus (ISA bus?)

But i2c-amd8111 does not load:

[root@opteron root]# depmod i2c-amd8111
# module             id=string
# pci module         vendor     device     subvendor  subdevice  class   
     class_mask driver_data
# isapnp module      cardvendor carddevice driver_data vendor      
function   ...
# usb module         match_flags idVendor idProduct bcdDevice_lo  
bcdDevice_hi bDeviceClass bDeviceSubClass bDeviceProtocol  
bInterfaceClass bInterfaceSubClass bInterfaceProtocol driver_info
# module             pattern
# ieee1394 module    match_flags vendor_id model_id specifier_id version
# module             id


Also, I should have included a full transcript of sensors-detect  
before, and have done so now in case it helps.

thanks again
charles

This hung for a while at the Velleman scan BTW.
[root@opteron lm_sensors-2.8.4]# sensors-detect

This program will help you determine which I2C/SMBus modules you need to
load to use lm_sensors most effectively. You need to have i2c and
lm_sensors installed before running this program.
Also, you need to be `root', or at least have access to the /dev/i2c-*
files, for most things.
If you have patched your kernel and have some drivers built in, you can
safely answer NO if asked to load some modules. In this case, things may
seem a bit confusing, but they will still work.

  We can start with probing for (PCI) I2C or SMBus adapters.
  You do not need any special privileges for this.
  Do you want to probe now? (YES/no):
Probing for PCI bus adapters...
Use driver `i2c-amd756' for device 00:07.3: AMD-8111 ACPI
Probe succesfully concluded.

  We will now try to load each adapter module in turn.
Module `i2c-amd756' already loaded.
  Do you now want to be prompted for non-detectable adapters? (yes/NO):  
yes
Load `i2c-elektor' (say NO if built into your kernel)? (YES/no):
modprobe: Can't locate module i2c-elektor
Loading failed... skipping.
Load `i2c-elv' (say NO if built into your kernel)? (YES/no):
/lib/modules/2.4.22-1.2135.nptlsmp/kernel/drivers/i2c/i2c-elv.o:  
init_module: No such device
Hint: insmod errors can be caused by incorrect module parameters,  
including invalid IO or IRQ parameters.
       You may find more information in syslog or the output from dmesg
/lib/modules/2.4.22-1.2135.nptlsmp/kernel/drivers/i2c/i2c-elv.o: insmod  
/lib/modules/2.4.22-1.2135.nptlsmp/kernel/drivers/i2c/i2c-elv.o failed
/lib/modules/2.4.22-1.2135.nptlsmp/unsupported/drivers/i2c/i2c-elv.o:  
init_module: No such device
Hint: insmod errors can be caused by incorrect module parameters,  
including invalid IO or IRQ parameters.
       You may find more information in syslog or the output from dmesg
/lib/modules/2.4.22-1.2135.nptlsmp/unsupported/drivers/i2c/i2c-elv.o:  
insmod  
/lib/modules/2.4.22-1.2135.nptlsmp/unsupported/drivers/i2c/i2c-elv.o  
failed
/lib/modules/2.4.22-1.2135.nptlsmp/unsupported/drivers/i2c/i2c-elv.o:  
insmod i2c-elv failed
Loading failed... skipping.
Load `i2c-philips-par' (say NO if built into your kernel)? (YES/no):
Module loaded succesfully.
Load `i2c-velleman' (say NO if built into your kernel)? (YES/no):
Module loaded succesfully.
  To continue, we need module `i2c-dev' to be loaded.
  If it is built-in into your kernel, you can safely skip this.
i2c-dev is already loaded.

  We are now going to do the adapter probings. Some adapters may hang  
halfway
  through; we can't really help that. Also, some chips will be double  
detected;
  we choose the one with the highest confidence value in that case.
  If you found that the adapter hung after probing a certain address,  
you can
  specify that address to remain unprobed. That often
  includes address 0x69 (clock chip).

Next adapter: SMBus AMD756 adapter at 80e0 (Non-I2C SMBus adapter)
Do you want to scan it? (YES/no/selectively):
Client found at address 0x08
Client found at address 0x52
Probing for `SPD EEPROM'... Success!
     (confidence 8, driver `eeprom')
Client found at address 0x53
Probing for `SPD EEPROM'... Success!
     (confidence 8, driver `eeprom')
Client found at address 0x69

Next adapter: Velleman K8000 (Bit-shift algorithm)
Do you want to scan it? (YES/no/selectively):

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
   Trying address 0x0ca0... Success!
     (confidence 4, driver `bmcsensors')
Probing for `IPMI BMC SMIC'
   Trying address 0x0ca8... Failed!

  Some Super I/O chips may also contain sensors. Super I/O probes are
  typically a bit more dangerous, as we have to write to I/O ports to do
  this.  Do you want to scan for Super I/O sensors? (YES/no):
Probing for `ITE 8712F Super IO Sensors'
   Failed! (0xe911)
Probing for `SMSC 47M10x Super IO Fan Sensors'
   Failed! (0xe9)
Probing for `SMSC 47M14x Super IO Fan Sensors'
   Failed! (0xe9)
Probing for `VT1211 Super IO Sensors'
   Failed! (0xe9)
Probing for `Winbond W83627HF Super IO Sensors'
   Failed! (0xe9)
Probing for `Winbond W83627THF Super IO Sensors'
   Failed! (0xe9)
Probing for `Winbond W83637HF Super IO Sensors'
   Failed! (0xe9)
Probing for `Winbond W83697HF Super IO Sensors'
   Failed! (0xe9)
Probing for `Winbond W83697UF Super IO PWM'
   Failed! (0xe9)

  Now follows a summary of the probes I have just done.
  Just press ENTER to continue:

Driver `eeprom' (should be inserted):
   Detects correctly:
   * Bus `SMBus AMD756 adapter at 80e0' (Non-I2C SMBus adapter)
     Busdriver `i2c-amd756', I2C address 0x52
     Chip `SPD EEPROM' (confidence: 8)
   * Bus `SMBus AMD756 adapter at 80e0' (Non-I2C SMBus adapter)
     Busdriver `i2c-amd756', I2C address 0x53
     Chip `SPD EEPROM' (confidence: 8)

Driver `bmcsensors' (should be inserted):
   Detects correctly:
   * ISA bus address 0x0ca0 (Busdriver `i2c-isa')
     Chip `IPMI BMC KCS' (confidence: 4)


  I will now generate the commands needed to load the I2C modules.
  Sometimes, a chip is available both through the ISA bus and an I2C bus.
  ISA bus access is faster, but you need to load an additional driver  
module
  for it. If you have the choice, do you want to use the ISA bus or the
  I2C/SMBus (ISA/smbus)? ISA

To make the sensors modules behave correctly, add these lines to
/etc/modules.conf:

#----cut here----
# I2C module options
alias char-major-89 i2c-dev
#----cut here----

To load everything that is needed, add this to some /etc/rc* file:

#----cut here----
# I2C adapter drivers
modprobe i2c-amd756
# modprobe unknown adapter Velleman K8000 using Bit-shift algorithm
modprobe i2c-isa
# I2C chip drivers
modprobe eeprom
modprobe bmcsensors
# sleep 2 # optional
/usr/local/bin/sensors -s # recommended
#----cut here----

WARNING! If you have some things built into your kernel, the list above
will contain too many modules. Skip the appropriate ones! You really  
should
try these commands right now to make sure everything is working  
properly.
Monitoring programs won't work until it's done.

Do you want to generate /etc/sysconfig/lm_sensors? (YES/no):
Copy prog/init/lm_sensors.init to /etc/rc.d/init.d/lm_sensors
for initialization at boot time.

On Feb 22, 2004, at 9:40 PM, Mark Studebaker wrote:

> whatever sensrors you have aren't on your 756 i2c bus.
> Either they are memory-mapped (ISA) or you have another bus.
> You may have an 8111 but the device isn't enabled (746a).
> If you can get it enabled in the bios or elsewhere then try the  
> i2c-amd8111 module.
> Also see FAQ 4.24.3.
>
> Charles Galpin wrote:
>> Hi
>> I have built i2c and lm_sensors-2.8.4 on a dual opteron running  
>> fedora core 1 x86_64.  Following  
>> http://www2.lm-sensors.nu/~lm78/identify.html I get to step 12, but  
>> it only recognizes the eeprom, and nothing else.
>> I had the same build issues as this thread, which appears to have the  
>> same problem too (but on 2.8.1 a few months ago) -  
>> http://archives.andrew.net.au/lm-sensors/msg04812.html.  I can't see  
>> where/how to join this list to ask on this thread.
>> Can you offer any help on how to get this working properly? I can  
>> give root access to the box if needed.
>> thanks for any help
>> charles
>> Nothing useful in /var/log/messages:
>> Feb 22 15:56:43 opteron kernel: i2c-core.o: i2c core module version  
>> 2.8.4 (20040207)
>> Feb 22 15:56:43 opteron kernel: i2c-proc.o version 2.8.4 (20040207)
>> Feb 22 15:56:43 opteron kernel: i2c-amd756.o version 2.8.4 (20040207)
>> [root@opteron lm_sensors-2.8.4]# sensors-detect
>> This program will help you determine which I2C/SMBus modules you need  
>> to
>> load to use lm_sensors most effectively. You need to have i2c and
>> lm_sensors installed before running this program.
>> Also, you need to be `root', or at least have access to the /dev/i2c-*
>> files, for most things.
>> If you have patched your kernel and have some drivers built in, you  
>> can
>> safely answer NO if asked to load some modules. In this case, things  
>> may
>> seem a bit confusing, but they will still work.
>>  We can start with probing for (PCI) I2C or SMBus adapters.
>>  You do not need any special privileges for this.
>>  Do you want to probe now? (YES/no):
>> Probing for PCI bus adapters...
>> Use driver `i2c-amd756' for device 00:07.3: AMD-8111 ACPI
>> Probe succesfully concluded.
>>  We will now try to load each adapter module in turn.
>> Module `i2c-amd756' already loaded.
>>  Do you now want to be prompted for non-detectable adapters? (yes/NO):
>>  To continue, we need module `i2c-dev' to be loaded.
>>  If it is built-in into your kernel, you can safely skip this.
>>  i2c-dev is not loaded. Do you want to load it now? (YES/no):
>>  Module loaded succesfully.
>>  We are now going to do the adapter probings. Some adapters may hang  
>> halfway
>>  through; we can't really help that. Also, some chips will be double  
>> detected;
>>  we choose the one with the highest confidence value in that case.
>>  If you found that the adapter hung after probing a certain address,  
>> you can
>>  specify that address to remain unprobed. That often
>>  includes address 0x69 (clock chip).
>> Next adapter: SMBus AMD756 adapter at 80e0 (Non-I2C SMBus adapter)
>> Do you want to scan it? (YES/no/selectively):
>> Client found at address 0x08
>> Client found at address 0x52
>> Probing for `SPD EEPROM'... Success!
>>     (confidence 8, driver `eeprom')
>> Client found at address 0x53
>> Probing for `SPD EEPROM'... Success!
>>     (confidence 8, driver `eeprom')
>> Client found at address 0x69
>> [root@opteron lm_sensors-2.8.4]# lsmod
>> Module                  Size  Used by    Not tainted
>> i2c-dev                 5696   0
>> i2c-amd756              5138   0
>> i2c-proc                9800   0
>> i2c-core               25124   0  [i2c-dev i2c-amd756 i2c-proc]
>> lp                     10184   0  (autoclean)
>> parport                44064   0  (autoclean) [lp]
>> autofs                 14468   0  (autoclean) (unused)
>> tg3                    59600   1
>> sg                     38200   0  (autoclean)
>> keybdev                 3168   0  (unused)
>> mousedev                6984   0  (unused)
>> hid                    23976   0  (unused)
>> input                   7584   0  [keybdev mousedev hid]
>> usb-ohci               24752   0  (unused)
>> usbcore                89888   1  [hid usb-ohci]
>> processor              12652   0
>> button                  4432   0  (unused)
>> asus_acpi              11248   0  (unused)
>> ac                      3288   0  (unused)
>> mptscsih               47216   3
>> mptbase                46624   3  [mptscsih]
>> sd_mod                 14540   6
>> scsi_mod              129824   3  [sg mptscsih sd_mod]
>> [root@opteron lm_sensors-2.8.4]# service lm_sensors status
>> No sensors found!
>> [root@opteron lm_sensors-2.8.4]# lspci -n
>> 00:06.0 Class 0604: 1022:7460 (rev 07)
>> 00:07.0 Class 0601: 1022:7468 (rev 05)
>> 00:07.1 Class 0101: 1022:7469 (rev 03)
>> 00:07.3 Class 0680: 1022:746b (rev 05)
>> 00:0a.0 Class 0604: 1022:7450 (rev 12)
>> 00:0a.1 Class 0800: 1022:7451 (rev 01)
>> 00:0b.0 Class 0604: 1022:7450 (rev 12)
>> 00:0b.1 Class 0800: 1022:7451 (rev 01)
>> 00:18.0 Class 0600: 1022:1100
>> 00:18.1 Class 0600: 1022:1101
>> 00:18.2 Class 0600: 1022:1102
>> 00:18.3 Class 0600: 1022:1103
>> 00:19.0 Class 0600: 1022:1100
>> 00:19.1 Class 0600: 1022:1101
>> 00:19.2 Class 0600: 1022:1102
>> 00:19.3 Class 0600: 1022:1103
>> 01:00.0 Class 0c03: 1022:7464 (rev 0b)
>> 01:00.1 Class 0c03: 1022:7464 (rev 0b)
>> 01:05.0 Class 0300: 1002:4752 (rev 27)
>> 02:01.0 Class 0200: 14e4:1648 (rev 03)
>> 02:01.1 Class 0200: 14e4:1648 (rev 03)
>> 02:02.0 Class 0100: 1000:0030 (rev 07)
>> [root@opteron lm_sensors-2.8.4]# i2cdetect
>> Error: No i2c-bus specified!
>> Syntax: i2cdetect I2CBUS
>>   I2CBUS is an integer
>>   i2cdetect -l lists installed busses only
>>   Installed I2C busses:
>>     i2c-0       smbus           SMBus AMD756 adapter at 80e0           
>>   Non-I2C SMBus adapter
>> [root@opteron lm_sensors-2.8.4]# i2cdetect 0
>>   WARNING! This program can confuse your I2C bus, cause data loss and  
>> worse!
>>   I will probe file /dev/i2c-0
>>   You have five seconds to reconsider and press CTRL-C!
>>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
>> 00: XX XX XX XX XX XX XX XX 08 XX XX XX XX XX XX XX
>> 10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
>> 20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
>> 30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
>> 40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
>> 50: XX XX 52 53 XX XX XX XX XX XX XX XX XX XX XX XX
>> 60: XX XX XX XX XX XX XX XX XX 69 XX XX XX XX XX XX
>> 70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
>> [root@opteron lm_sensors-2.8.4]# uname -a
>> Linux opteron 2.4.22-1.2135.nptlsmp #1 SMP Mon Dec 15 15:45:38 EST  
>> 2003 x86_64 x86_64 x86_64 GNU/Linux
