From: mds@mds.gotdns.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:53 +0000
Subject: Intel 82801BA issue (was Can't seem to enter my issue into
Message-Id: <42672122.90902@mds.gotdns.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <e0e94cf9c5098ca5d41ab2dd3fde4aca@houston.rr.com>
In-Reply-To: <e0e94cf9c5098ca5d41ab2dd3fde4aca@houston.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

you have the device in lspci so you don't need hotplug or setpci.

To get SMBus working for sensors-detect you need to fix this
	Can't open /dev/i2c[-/]2
by creating the device (see prog/mkdev) or running as root if you aren't.

But driver should find the chip on the ISA side.
Or on the SMBus side if you modprobe i2c-i801.

sensors says no sensors found?
what does dmesg say after modprobes?


Big problem also is 2.7.0 is very very (very) old, try upgrading to latest release.
In that release, recommended driver will be w83627hf.


David Smoot wrote:
> OK, I have examined the board and I most definitely have the Intel 
> 82801BA I/O Controller (ICH2).  When I do an lspci,I get:
> [root@houlnx hotplug]# /sbin/lspci
> 00:00.0 Host bridge: Intel Corporation 82815 815 Chipset Host Bridge and 
> Memory Controller Hub (rev 04)
> 00:02.0 VGA compatible controller: Intel Corporation 82815 CGC [Chipset 
> Graphics Controller]  (rev 04)
> 00:1e.0 PCI bridge: Intel Corporation 82801BAM PCI (rev 05)
> 00:1f.0 ISA bridge: Intel Corporation 82801BA ISA Bridge (ICH2) (rev 05)
> 00:1f.1 IDE interface: Intel Corporation 82801BA IDE U100 (rev 05)
> 00:1f.2 USB Controller: Intel Corporation 82801BA(M) USB (Hub A) (rev 05)
> 00:1f.3 SMBus: Intel Corporation 82801BA(M) SMBus (rev 05)
> 00:1f.4 USB Controller: Intel Corporation 82801BA(M) USB (Hub B) (rev 05)
> 01:05.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] 
> (rev 08)
> 01:08.0 Ethernet controller: Intel Corporation 82801BA(M) Ethernet (rev 03)
> 
>  From i2c-801 in doc/busses:
> "If you do NOT see the 24x3 device at function 3, and you can't
> figure out any way in the BIOS to enable it,
> (and especially if you have an Asus P4B board),
> see prog/hotplug/README.p4b."
> 
> So I went and read README.p4b and followed the instructions there.   
> Here is a cut and paste of the setpci:
> [root@houlnx hotplug]# /sbin/setpci -d 8086:2440 f2.w
> 0060
> Problem is 0x60 already has bits 3 and 8 cleared.  What do I do now?
> 
> Thanks
> David Smoot
> 
> On Apr 20, 2005, at 8:55 AM, David Smoot wrote:
> 
>> I've tried twice now and I don't get an error message, it just goes to 
>> the main support ticket page and I don't get a ticket number and it 
>> does not show up in the list.
>>
>> Here is the text of the ticket I was trying to submit:
>> I thought I submitted a ticket last night but apparently I screwed it 
>> up.  Forgive me if this is a repeat.
>>
>> I installed i2c and lm sensors on a virgin redhat 7.2 box.  Took a 
>> little effort but everything compiled and installed.
>>
>> I have a PCI form factor single board computer, the PCA-6180F from 
>> Advantech.  The manufacturer has confirmed they use a WinBond W83627HF 
>> chip for hardware monitoring.  Sensors-detect correctly identifies the 
>> chip.
>>
>> ###Begin pasted output of sensors detect
>> [root@houlnx sbin]# 
>> /home/dsmoot/hwmonitor/lm_sensors-2.7.0/prog/detect/sensors-detect
>>  This program will help you to determine which I2C/SMBus modules you 
>> need to
>>  load to use lm_sensors most effectively.
>>  You need to have done a `make install', issued a `depmod -a' and made 
>> sure
>>  `/etc/conf.modules' (or `/etc/modules.conf') contains the appropriate
>>  module path before you can use some functions of this utility. Read
>>  doc/modules for more information.
>>  Also, you need to be `root', or at least have access to the 
>> /dev/i2c[-/]* files
>>  for some things. You can use prog/mkdev/mkdev.sh to create these /dev 
>> files
>>  if you do not have them already.
>>  If you have patched your kernel and have some drivers built-in you can
>>  safely answer NO if asked to load some modules. In this case, things may
>>  seem a bit confusing, but they will still work.
>>
>>  IF THIS IS AN IBM THINKPAD, PRESS CTRL-C NOW!
>>  IBM Thinkpads have a severely broken i2c/SMBus implementation, just 
>> scanning
>>  the bus will break your Thinkpad forever!
>>  If this is a non-Thinkpad IBM, we still suggest you press CTRL+C. We 
>> have
>>  had users reporting system breakage on other IBM systems as well.
>>
>>  We can start with probing for (PCI) I2C or SMBus adapters.
>>  You do not need any special privileges for this.
>>  Do you want to probe now? (YES/no):
>> Probing for PCI bus adapters...
>> Use driver `i2c-i810' for device 00:02.0: Intel 82815 GMCH
>> Use driver `i2c-i801' for device 00:1f.3: Intel 82801BA ICH2
>> Probe succesfully concluded.
>>
>>  We will now try to load each adapter module in turn.
>> Load `i2c-i810' (say NO if built into your kernel)? (YES/no):
>> Can't exec "modprobe": No such file or directory at 
>> /home/dsmoot/hwmonitor/lm_sensors-2.7.0/prog/detect/sensors-detect 
>> line 3112, <STDIN> line 2.
>> Loading failed... skipping.
>> Load `i2c-i801' (say NO if built into your kernel)? (YES/no):
>> [root@houlnx sbin]# export PATH=$PATH:/sbin
>> [root@houlnx sbin]# 
>> /home/dsmoot/hwmonitor/lm_sensors-2.7.0/prog/detect/sensors-detect
>>  This program will help you to determine which I2C/SMBus modules you 
>> need to
>>  load to use lm_sensors most effectively.
>>  You need to have done a `make install', issued a `depmod -a' and made 
>> sure
>>  `/etc/conf.modules' (or `/etc/modules.conf') contains the appropriate
>>  module path before you can use some functions of this utility. Read
>>  doc/modules for more information.
>>  Also, you need to be `root', or at least have access to the 
>> /dev/i2c[-/]* files
>>  for some things. You can use prog/mkdev/mkdev.sh to create these /dev 
>> files
>>  if you do not have them already.
>>  If you have patched your kernel and have some drivers built-in you can
>>  safely answer NO if asked to load some modules. In this case, things may
>>  seem a bit confusing, but they will still work.
>>
>>  IF THIS IS AN IBM THINKPAD, PRESS CTRL-C NOW!
>>  IBM Thinkpads have a severely broken i2c/SMBus implementation, just 
>> scanning
>>  the bus will break your Thinkpad forever!
>>  If this is a non-Thinkpad IBM, we still suggest you press CTRL+C. We 
>> have
>>  had users reporting system breakage on other IBM systems as well.
>>
>>  We can start with probing for (PCI) I2C or SMBus adapters.
>>  You do not need any special privileges for this.
>>  Do you want to probe now? (YES/no):
>> Probing for PCI bus adapters...
>> Use driver `i2c-i810' for device 00:02.0: Intel 82815 GMCH
>> Use driver `i2c-i801' for device 00:1f.3: Intel 82801BA ICH2
>> Probe succesfully concluded.
>>
>>  We will now try to load each adapter module in turn.
>> Load `i2c-i810' (say NO if built into your kernel)? (YES/no):
>> Module loaded succesfully.
>> Load `i2c-i801' (say NO if built into your kernel)? (YES/no):
>> Module loaded succesfully.
>>  Do you now want to be prompted for non-detectable adapters? (yes/NO):
>>  To continue, we need module `i2c-dev' to be loaded.
>>  If it is built-in into your kernel, you can safely skip this.
>>  i2c-dev is not loaded. Do you want to load it now? (YES/no):
>>  Module loaded succesfully.
>>
>>  We are now going to do the adapter probings. Some adapters may hang 
>> halfway
>>  through; we can't really help that. Also, some chips will be double 
>> detected;
>>  we choose the one with the highest confidence value in that case.
>>  If you found that the adapter hung after probing a certain address, 
>> you can
>>  specify that address to remain unprobed. That often
>>  includes address 0x69 (clock chip).
>>
>> Next adapter: I810/I815 I2C Adapter (Bit-shift algorithm)
>> Do you want to scan it? (YES/no/selectively):
>>
>> Next adapter: I810/I815 DDC Adapter (Bit-shift algorithm)
>> Do you want to scan it? (YES/no/selectively):
>>
>> Next adapter: SMBus I801 adapter at 5000 (Non-I2C SMBus adapter)
>> Do you want to scan it? (YES/no/selectively):
>> Can't open /dev/i2c[-/]2
>>
>>  Some chips are also accessible through the ISA bus. ISA probes are
>>  typically a bit more dangerous, as we have to write to I/O ports to do
>>  this.  Do you want to scan the ISA bus? (YES/no):
>> Probing for `National Semiconductor LM78'
>>   Trying address 0x0290... Failed!
>> Probing for `National Semiconductor LM78-J'
>>   Trying address 0x0290... Failed!
>> Probing for `National Semiconductor LM79'
>>   Trying address 0x0290... Failed!
>> Probing for `Winbond W83781D'
>>   Trying address 0x0290... Failed!
>> Probing for `Winbond W83782D'
>>   Trying address 0x0290... Failed!
>> Probing for `Winbond W83627HF'
>>   Trying address 0x0290... Success!
>>     (confidence 8, driver `w83781d')
>> Probing for `Winbond W83697HF'
>>   Trying address 0x0290... Failed!
>> Probing for `Silicon Integrated Systems SIS5595'
>>   Trying general detect... Failed!
>> Probing for `VIA Technologies VT82C686 Integrated Sensors'
>>   Trying general detect... Failed!
>> Probing for `VIA Technologies VT8231 Integrated Sensors'
>>   Trying general detect... Failed!
>> Probing for `ITE IT8705F / IT8712F / SiS 950'
>>   Trying address 0x0290... Failed!
>> Probing for `IPMI BMC KCS'
>>   Trying address 0x0ca0... Failed!
>> Probing for `IPMI BMC SMIC'
>>   Trying address 0x0ca8... Failed!
>>
>>  Now follows a summary of the probes I have just done.
>>  Just press ENTER to continue:
>>
>> Driver `w83781d' (should be inserted):
>>   Detects correctly:
>>   * ISA bus address 0x0290 (Busdriver `i2c-isa')
>>     Chip `Winbond W83627HF' (confidence: 8)
>>
>>
>>  I will now generate the commands needed to load the I2C modules.
>>  Sometimes, a chip is available both through the ISA bus and an I2C bus.
>>  ISA bus access is faster, but you need to load an additional driver 
>> module
>>  for it. If you have the choice, do you want to use the ISA bus or the
>>  I2C/SMBus (ISA/smbus)?
>>
>> WARNING! If you have some things built into your kernel, the
>> below list will contain too many modules. Skip the appropriate ones!
>> To load everything that is needed, add this to some /etc/rc* file:
>>
>> #----cut here----
>> # I2C adapter drivers
>> modprobe i2c-isa
>> # I2C chip drivers
>> modprobe w83781d
>> #----cut here----
>>
>> To make the sensors modules behave correctly, add these lines to either
>> /etc/modules.conf or /etc/conf.modules:
>>
>> #----cut here----
>> # I2C module options
>> alias char-major-89 i2c-dev
>> #----cut here----
>>
>> Do you want to generate /etc/sysconfig/lm_sensors? (YES/no):
>> Copy prog/init/lm_sensors.init to /etc/rc.d/init.d/lm_sensors
>> for initialization at boot time.
>> ####End cut and paste of sensors-detect######
>>
>> What I did:
>> Made the recommended edit to /etc/modules.conf
>> Added the recommended modprobes to /etc/rc.d/rc.local
>> copied the lm_sensors.init to /etc/rc.d/init.d/lm_sensors
>>
>> After a reboot, I ran sensors.  No sensors detected.  The modules are 
>> loading just fine (lsmod shows the modules there).  I got an error 
>> about i2c-proc not being loaded so I added i2c-proc to the startup list.
>>
>> ######Output of lsmod######
>> w83781d                19488   0 (unused)
>> i2c-proc                6448   0 [w83781d]
>> i2c-isa                 1168   0 (unused)
>> i2c-core               15120   0 [w83781d i2c-proc i2c-isa]
>> autofs                 10720   0 (autoclean) (unused)
>> eepro100               17440   1
>> ipchains               36448   0
>> usb-uhci               21424   0 (unused)
>> usbcore                50912   1 [usb-uhci]
>> ext3                   63184   2
>> jbd                    40032   2 [ext3]
>> ##########End of output of lsmod##########
>>
>> I'm confused.  The hardware can be recognized but apparently not 
>> communicated with.  I've tried a number of things just shooting in the 
>> dark:
>> manually run /prog/init/lm_sensors.init start (starts OK but takes a 
>> good solid minute for the w83781d to load)
>> manually edited the sensors.conf file to w83781d-isa-0290
>> tried directly calling sensors w83781d-isa-0290
>> tried browsing /proc (chip headers are there but no data)
>>
>> the output of prog/dump/isadump 0x295 0x296
>>   WARNING! Running this program can cause system crashes, data loss 
>> and worse!
>>   I will probe address register 0x0295 and data register 0x0296.
>>   You have five seconds to reconsider and press CTRL-C!
>>
>>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
>> 00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>> 10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>> 20: 5c 4e ca b4 c6 1c de 1a 8e ff ff 67 54 67 54 e3
>> 30: ba cc a8 d8 b2 31 15 40 2c 3c 7f e1 e1 e1 00 00
>> 40: 01 82 2c 00 00 00 00 5b 2d 02 01 44 41 95 00 a3
>> 50: ff ff 00 ff ff ff 00 00 21 70 ff ff 19 09 ff 05
>> 60: 5c 4e ca b4 c6 1c de 1a 8e ff ff 67 54 67 54 e3
>> 70: ba cc a8 d8 b2 31 15 40 2c 3c 7f e1 e1 e1 00 00
>> 80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>> 90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>> a0: 5c 4e ca b4 c6 1c de 1a 8e ff ff 67 54 67 54 e3
>> b0: ba cc a8 d8 b2 31 15 40 2c 3c 7f e1 e1 e1 00 00
>> c0: 01 00 00 00 00 00 00 5b 2d 02 01 44 41 95 00 a3
>> d0: ff ff 00 ff ff ff 00 00 21 70 ff ff 19 09 ff 05
>> e0: 5c 4e ca b4 c6 1c de 1a 8e ff ff 67 54 67 54 e3
>> f0: ba cc a8 d8 b2 31 15 40 2c 3c 7f e1 e1 e1 00 00
>>
>> Sensors version 2.7.0
>> Kernel Version 2.4.7-10
>>
>> Any idea what I am doing wrong?
>> David
>>
> 

