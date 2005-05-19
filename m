From: wing549@earthlink.com (Stealth)
Date: Thu, 19 May 2005 06:23:42 +0000
Subject: help
Message-Id: <3DE90367.3080904@earthlink.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020728124708.244675c6.nec@chello.hu>
In-Reply-To: <20020728124708.244675c6.nec@chello.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

im really confused, sensors-detect dosent seem to find my chip my 
motherboard is the ABIT KX7-KT333r and im running Redhat 7.3 kernel 
2.4.18-18.7.x  ...i untared lmsensors , and ran make all, make install 
it gave me warnings about files not being found like it said in the 
install file, then i did sensors-detect and ran defaults...
 

[root@Nooblesse root]# sensors-detect
 This program will help you to determine which I2C/SMBus modules you need to
 load to use lm_sensors most effectively.
 You need to have done a `make install', issued a `depmod -a' and made sure
 `/etc/conf.modules' (or `/etc/modules.conf') contains the appropriate
 module path before you can use some functions of this utility. Read
 doc/modules for more information.
 Also, you need to be `root', or at least have access to the 
/dev/i2c[-/]* files
 for some things. You can use prog/mkdev/mkdev.sh to create these /dev files
 if you do not have them already.
 If you have patched your kernel and have some drivers built-in you can
 safely answer NO if asked to load some modules. In this case, things may
 seem a bit confusing, but they will still work.

 IF THIS IS AN IBM THINKPAD, PRESS CTRL-C NOW!
 IBM Thinkpads have a severely broken i2c/SMBus implementation,  just 
scanning
 the bus will break your thinkpad forever!

 We can start with probing for (PCI) I2C or SMBus adapters.
 You do not need any special privileges for this.
 Do you want to probe now? (YES/no): YES
Probing for PCI bus adapters...
Sorry, no PCI bus adapters found.

 We will now try to load each adapter module in turn.
 Do you now want to be prompted for non-detectable adapters? (yes/NO): NO
 To continue, we need module `i2c-dev' to be loaded.
 If it is built-in into your kernel, you can safely skip this.
i2c-dev is already loaded.

 We are now going to do the adapter probings. Some adapters may hang halfway
 through; we can't really help that. Also, some chips will be double 
detected;
 we choose the one with the highest confidence value in that case.
 If you found that the adapter hung after probing a certain address, you can
 specify that address to remain unprobed. If you have a PIIX4, that often
 includes addresses 0x69 and/or 0x6a.

 Some chips are also accessible through the ISA bus. ISA probes are
 typically a bit more dangerous, as we have to write to I/O ports to do
 this.  Do you want to scan the ISA bus? (YES/no): YES
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
  Trying address 0x0290... Success!
    (confidence 8, driver `Unwritten (W83697HF)')
Probing for `Silicon Integrated Systems SIS5595'
  Trying general detect... Failed!
Probing for `VIA Technologies VT 82C686 Integrated Sensors'
  Trying general detect... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'
  Trying address 0x0290... Failed!

 Now follows a summary of the probes I have just done.
 Just press ENTER to continue:

Driver `Unwritten (W83697HF)' (should be inserted):
  Detects correctly:
  * ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `Winbond W83697HF' (confidence: 8)


 I will now generate the commands needed to load the I2C modules.
 Sometimes, a chip is available both through the ISA bus and an I2C bus.
 ISA bus access is faster, but you need to load an additional driver module
 for it. If you have the choice, do you want to use the ISA bus or the
 I2C/SMBus (ISA/smbus)?

WARNING! If you have some things built into your kernel, the
below list will contain too many modules. Skip the appropriate ones!
To load everything that is needed, add this to some /etc/rc* file:

#----cut here----
# I2C adapter drivers
modprobe i2c-isa
# I2C chip drivers
modprobe Unwritten (W83697HF)
#----cut here----

To make the sensors modules behave correctly, add these lines to either
/etc/modules.conf or /etc/conf.modules:

#----cut here----
# I2C module options
alias char-major-89 i2c-dev
#----cut here----
[root@Nooblesse root]#

then i put the modules in /etc/rc and /etc/modules.conf

[root@Nooblesse root]# vi /etc/rc
rc          rc.d        rc.local    rc.sysinit  rc0.d       rc1.d       
rc2.d       rc3.d       rc4.d       rc5.d       rc6.d
[root@Nooblesse root]# vi /etc/rc
[root@Nooblesse root]# vi /etc/rc
[root@Nooblesse root]# vi /etc/mo
modules.conf   modules.conf~  motd
[root@Nooblesse root]# vi /etc/mo
modules.conf   modules.conf~  motd
[root@Nooblesse root]# vi /etc/mo
modules.conf   modules.conf~  motd
[root@Nooblesse root]# vi /etc/modules.conf
[root@Nooblesse root]# modprobe i2c-dev
[root@Nooblesse root]# sensors
No sensors found!
[root@Nooblesse root]# modprobe i2c-isa
[root@Nooblesse root]# sensors
No sensors found!
[root@Nooblesse root]#
  help! what am i doing wrong? linux is cool



