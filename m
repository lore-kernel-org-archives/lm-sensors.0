From: "Juerg Haefliger" <juergh@gmail.com>
Date: Wed, 22 Aug 2007 15:55:45 +0000
Subject: Re: [lm-sensors] intel 7501wv2 server board
Message-Id: <191fb4ca0708220855n1766c669yee34f47eda0f8d99@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <22272395.631187762672311.JavaMail.root@shoemasters.com>
In-Reply-To: <22272395.631187762672311.JavaMail.root@shoemasters.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ryan,

On 8/21/07, RYAN M. vAN GINNEKEN <luck@computerking.ca> wrote:
>
> Hello i have the intel 7501wv2 serverboard and i am running CentOS 5 like so
> also i have 533 dual xeons in this board and read some stuff on the wiki
> about cpu sensors and using xeontemp not to clear on most of what i need to
> do.
>
> Linux canmail.org 2.6.18-8.1.8.el5 #1 SMP Tue Jul 10 06:50:22 EDT 2007 i686
> i686 i386 GNU/Linux
>
> Below the output of the lm-sensors detection wizard i downloaded the newest
> one.  I have tried to load the modules recommended at the end of the wizard
> and i get this.
>
> [root@canmail /]# /sbin/modprobe ipmi-si
> [root@canmail /]# /sbin/modprobe ipmisensors
> FATAL: Module ipmisensors not found.

ipmisensors is not part of the kernel or distribution. You need to get
it from http://bmcsensors-26.sourceforge.net/ and compile it against
your running kernel.

...juerg


> one works one does not to sure about the alias stuff anywho i get this error
> when i run the sensors command.   I read some stuff in this list to check
> for /devs so i did and the one required seems to be there.
>
> [root@canmail /]# sensors
> Can't access procfs/sysfs file
> Unable to find i2c bus information;
> For 2.6 kernels, make sure you have mounted sysfs and libsensors
> was compiled with sysfs support!
> For older kernels, make sure you have done 'modprobe i2c-proc'!
> [root@canmail /]# ls -l /dev/i2c-0
> crw------- 1 root root 89, 0 Aug 21 21:54 /dev/i2c-0
> [root@canmail /]# ls -l /dev/i2c*
> crw------- 1 root root 89, 0 Aug 21 21:54 /dev/i2c-0
>
> [root@canmail c0mputerking]# perl "sensors-detect?format=txt"
> # sensors-detect revision $Revision$
>
> This program will help you determine which kernel modules you need
> to load to use lm_sensors most effectively. It is generally safe
> and recommended to accept the default answers to all questions,
> unless you know what you're doing.
>
> We can start with probing for (PCI) I2C or SMBus adapters.
> Do you want to probe now? (YES/no): YES
> Probing for PCI bus adapters...
> Use driver `i2c-i801' for device 0000:00:1f.3: Intel 82801CA/CAM ICH3
>
> We will now try to load each adapter module in turn.
> Module `i2c-i801' already loaded.
> If you have undetectable or unsupported adapters, you can have them
> scanned by manually loading the modules before running this script.
>
> To continue, we need module `i2c-dev' to be loaded.
> Do you want to load `i2c-dev' now? (YES/no): YES
> Module loaded successfully.
>
> We are now going to do the I2C/SMBus adapter probings. Some chips may
> be double detected; we choose the one with the highest confidence
> value in that case.
> If you found that the adapter hung after probing a certain address,
> you can specify that address to remain unprobed.
>
> Next adapter: SMBus I801 adapter at 0580 (i2c-0)
> Do you want to scan it? (YES/no/selectively): YES
> Client found at address 0x44
> Probing for `Maxim MAX6633/MAX6634/MAX6635'...
> No
> Client found at address 0x52
> Probing for `Analog Devices ADM1033'...                     No
> Probing for `Analog Devices ADM1034'...                     No
> Probing for `SPD EEPROM'...
> Yes
>     (confidence 8, not a hardware monitoring chip)
> Probing for `EDID EEPROM'...
> No
>
> Some chips are also accessible through the ISA I/O ports. We have to
> write to arbitrary I/O ports to probe them. This is usually safe though.
> Yes, you do have ISA I/O ports even if you do not have any ISA slots!
> Do you want to scan the ISA I/O ports? (YES/no):
> Probing for `National Semiconductor LM78' at 0x290...       No
> Probing for `National Semiconductor LM78-J' at 0x290...     No
> Probing for `National Semiconductor LM79' at 0x290...       No
> Probing for `Winbond W83781D' at 0x290...                   No
> Probing for `Winbond W83782D' at 0x290...                   No
> Probing for `Silicon Integrated Systems SIS5595'...         No
> Probing for `VIA VT82C686 Integrated Sensors'...            No
> Probing for `VIA VT8231 Integrated Sensors'...              No
> Probing for `IPMI BMC KCS' at 0xca0...                      Success!
>     (confidence 4, driver `ipmisensors')
> Probing for `IPMI BMC SMIC' at 0xca8...                     No
>
> Some Super I/O chips may also contain sensors. We have to write to
> standard I/O ports to probe them. This is usually safe.
> Do you want to scan for Super I/O sensors? (YES/no):
> Probing for Super-I/O at 0x2e/0x2f
> Trying family `National Semiconductor'...
> Yes
> Found `Nat. Semi. PC8741x Super IO'
>     (no hardware monitoring capabilities)
> Probing for Super-I/O at 0x4e/0x4f
> Trying family `National Semiconductor'...
> No
> Trying family `SMSC'...
> No
> Trying family `VIA/Winbond/Fintek'...
> No
> Trying family `ITE'...
> No
>
> Some CPUs or memory controllers may also contain embedded sensors.
> Do you want to scan for them? (YES/no):
> AMD K8 thermal sensors...
> No
> Intel Core family thermal sensor...
> No
> Intel AMB FB-DIMM thermal sensor...
> No
>
> Now follows a summary of the probes I have just done.
> Just press ENTER to continue:
>
> Driver `ipmisensors' (should be inserted):
>   Detects correctly:
>   * ISA bus, address 0xca0
>     Chip `IPMI BMC KCS' (confidence: 4)
>
> I will now generate the commands needed to load the required modules.
> Just press ENTER to continue:
>
> To make the sensors modules behave correctly, add these lines to
> /etc/modprobe.conf:
>
> #----cut here----
> # I2C module options
> alias char-major-89 i2c-dev
> #----cut here----
>
> To load everything that is needed, add this to some /etc/rc* file:
>
> #----cut here----
> # You must also install and load the IPMI modules
> modprobe ipmi-si
> # Chip drivers
> # Warning: the required module ipmisensors is not currently installed
> # on your system. For status of 2.6 kernel ports check
> # http://www.lm-sensors.org/wiki/Devices. If driver is
> built
> # into the kernel, or unavailable, comment out the following line.
> modprobe ipmisensors
> # sleep 2 # optional
> /usr/bin/sensors -s # recommended
> #----cut here----
>
> If you have some drivers built into your kernel, the list above will
> contain too many modules. Skip the appropriate ones! You really
> should try these commands right now to make sure everything is
> working properly. Monitoring programs won't work until the needed
> modules are loaded.
>
> --
> Computer King & CaN Mail  -  Sales Service Hosting Backup
>
> http://www.computerking.ca     http://www.canmail.org
>
> NEW!!! Custom Service Packages
> Secure IMAP Email - Automated Remote Backups - Photo Blogs
> - Online Accounting Packages
>
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
