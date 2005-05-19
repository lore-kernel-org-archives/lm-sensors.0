From: hoyt13@sbcglobal.net (Hoyt Bailey)
Date: Thu, 19 May 2005 06:25:13 +0000
Subject: ---=== Lm_sensors Support DB Entry ===---
Message-Id: <200409021133.26975.hoyt13@sbcglobal.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020324193410.GA7656@chrysler.kbs.twi.tudelft.nl>
In-Reply-To: <20020324193410.GA7656@chrysler.kbs.twi.tudelft.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thursday 26 August 2004 07:46, you wrote:
> Your Lm_sensors support entry has been updated.
>
> Please go to http://secure.netroedge.com/~lm78/support.html to 
check
> the status of your entry.
>
> Ticket # 1764

-- The KT400 is a chipset made by VIA, this is not the name of 
your motherboard.
The CyberPower Item # is MB-133-102.  
The Description is  Gigabyte 7VAX KT400 MB 8X AGP (If that dosent 
answer I dont have an answer).

We would need to see the output you get from "sensors-detect" 
and/or "sensors",
[root@Blackgold hoyt]# sensors-detect
No i2c device files found. Use prog/mkdev/mkdev.sh to create 
them.
[root@Blackgold hoyt]# locate mkdev
/home/hoyt/Programs/lm_sensors-2.8.5/prog/mkdev
/home/hoyt/Programs/lm_sensors-2.8.5/prog/mkdev/mkdev.sh
/usr/share/doc/kernel-doc-2.6.3/arm/empeg/mkdevs
/usr/share/doc/kernel-doc-2.6.3/mkdev.cciss
/usr/share/doc/kernel-doc-2.6.3/mkdev.ida
/usr/src/linux-2.6.3-15mdk/Documentation/arm/empeg/mkdevs
/usr/src/linux-2.6.3-15mdk/Documentation/mkdev.cciss
/usr/src/linux-2.6.3-15mdk/Documentation/mkdev.ida
/usr/src/linux-2.6.3-15mdk/drivers/char/ip2/ip2mkdev.c
[root@Blackgold hoyt]# ls -la Programs
total 7968
drwxrwxr-x   3 hoyt hoyt    4096 Aug 25 05:58 ./
drwxr-xr-x  49 hoyt hoyt   20480 Aug 26 08:53 ../
-rw-------   1 hoyt hoyt  407034 Aug 23 10:01 708A107.zip
drwxrwxr-x  12  500  500    4096 Mar  5 17:09 lm_sensors-2.8.5/
-rw-rw-r--   1 hoyt hoyt  726736 Aug 16 12:08 
lm_sensors-2.8.5.tar.gz
-rw-------   1 hoyt hoyt   28261 Aug 18 18:59 
mozplugger-1.6.0-1.i586.rpm
-rw-------   1 hoyt hoyt  417531 Aug 22 14:13 mprime235.tar.gz
-rw-------   1 hoyt hoyt 5842522 Aug 18 09:57 
NFORCE-Linux-x86-1.0-0283-pkg1.run
-rw-------   1 hoyt hoyt  670771 Aug 23 09:54 PX708-107.exe
[root@Blackgold hoyt]# cd P
PDF       Programs
[root@Blackgold hoyt]# cd Programs/lm_sensors-2.8.5/
[root@Blackgold lm_sensors-2.8.5]# ls -la
total 216
drwxrwxr-x  12  500  500  4096 Mar  5 17:09 ./
drwxrwxr-x   3 hoyt hoyt  4096 Aug 25 05:58 ../
drwxrwxr-x   2  500  500  4096 Mar  5 17:09 archive/
-rw-rw-r--   1  500  500  3958 Sep 20  1999 BACKGROUND
-rw-rw-r--   1  500  500  6560 Sep  2  2001 BUGS
-rw-rw-r--   1  500  500 43739 Mar  5 17:08 CHANGES
-rw-rw-r--   1  500  500  4460 Feb 20  2004 CONTRIBUTORS
-rw-rw-r--   1  500  500 17982 Nov 18  1998 COPYING
drwxrwxr-x   6  500  500  4096 Mar  5 17:09 doc/
drwxrwxr-x   2  500  500  4096 Mar  5 17:09 etc/
drwxrwxr-x   6  500  500  4096 Mar  5 17:09 i2c/
-rw-rw-r--   1  500  500 16175 Dec  7  2003 INSTALL
drwxrwxr-x   5  500  500  4096 Mar  5 17:09 kernel/
drwxrwxr-x   2  500  500  4096 Aug 22 15:03 lib/
-rw-rw-r--   1  500  500   922 Mar  5 17:06 lm_sensors.lsm
-rw-rw-r--   1  500  500 13126 Feb  6  2004 Makefile
drwxrwxr-x   2  500  500  4096 Mar  5 17:09 mkpatch/
drwxrwxr-x  20  500  500  4096 Mar  5 17:09 prog/
-rw-rw-r--   1  500  500  2645 Dec  7  2003 QUICKSTART
-rw-rw-r--   1  500  500  8541 Jan 15  2004 README
-rw-rw-r--   1  500  500   730 Sep  4  1999 README.directories
-rw-rw-r--   1  500  500   968 Feb 26  2000 README.package
-rw-rw-r--   1  500  500   767 Feb 26  2000 README.patches
-rw-rw-r--   1  500  500  4753 Nov 30  2003 README.thinkpad
drwxrwxr-x   2  500  500  4096 Mar  5 17:09 RPM/
drwxrwxr-x   2  500  500  4096 Mar  5 17:09 src/
-rw-rw-r--   1  500  500  5079 Dec 15  2003 TODO
-rw-rw-r--   1  500  500    54 Mar  5 17:07 version.h
[root@Blackgold lm_sensors-2.8.5]# cd prog
[root@Blackgold prog]# ls -la
total 80
drwxrwxr-x  20 500 500 4096 Mar  5 17:09 ./
drwxrwxr-x  12 500 500 4096 Mar  5 17:09 ../
drwxrwxr-x   2 500 500 4096 Mar  5 17:09 config/
drwxrwxr-x   2 500 500 4096 Mar  5 17:09 daemon/
drwxrwxr-x   2 500 500 4096 Aug 22 15:03 detect/
drwxrwxr-x   2 500 500 4096 Mar  5 17:09 doc/
drwxrwxr-x   2 500 500 4096 Aug 22 15:03 dump/
drwxrwxr-x   2 500 500 4096 Mar  5 17:09 eeprom/
drwxrwxr-x   2 500 500 4096 Mar  5 17:09 eepromer/
drwxrwxr-x   2 500 500 4096 Mar  5 17:09 hotplug/
drwxrwxr-x   2 500 500 4096 Mar  5 17:09 init/
drwxrwxr-x   2 500 500 4096 Mar  5 17:09 matorb/
drwxrwxr-x   2 500 500 4096 Mar  5 17:09 maxilife/
drwxrwxr-x   2 500 500 4096 Mar  5 17:09 mkdev/
drwxrwxr-x   2 500 500 4096 Mar  5 17:09 pwm/
drwxrwxr-x   2 500 500 4096 Mar  5 17:09 rrd/
drwxrwxr-x   2 500 500 4096 Mar  5 17:09 sensord/
drwxrwxr-x   2 500 500 4096 Aug 22 15:03 sensors/
drwxrwxr-x   2 500 500 4096 Mar  5 17:09 tellerstats/
drwxrwxr-x   2 500 500 4096 Mar  5 17:09 xeon/
[root@Blackgold prog]# cd mkdev
[root@Blackgold mkdev]# ls -la
total 12
drwxrwxr-x   2 500 500 4096 Mar  5 17:09 ./
drwxrwxr-x  20 500 500 4096 Mar  5 17:09 ../
-rwxrwxr-x   1 500 500  376 Jan 13  1999 mkdev.sh*
[root@Blackgold mkdev]# mkdev.sh
bash: mkdev.sh: command not found
[root@Blackgold mkdev]# ./mkdev.sh
/dev/i2c-0
/dev/i2c-1
/dev/i2c-2
/dev/i2c-3
/dev/i2c-4
/dev/i2c-5
/dev/i2c-6
/dev/i2c-7
/dev/i2c-8
/dev/i2c-9
/dev/i2c-10
/dev/i2c-11
/dev/i2c-12
/dev/i2c-13
/dev/i2c-14
/dev/i2c-15
/dev/i2c-16
/dev/i2c-17
/dev/i2c-18
/dev/i2c-19
/dev/i2c-20
/dev/i2c-21
/dev/i2c-22
/dev/i2c-23
/dev/i2c-24
/dev/i2c-25
/dev/i2c-26
/dev/i2c-27
/dev/i2c-28
/dev/i2c-29
/dev/i2c-30
/dev/i2c-31
[root@Blackgold mkdev]# sensors-detect

This program will help you determine which I2C/SMBus modules you 
need to
load to use lm_sensors most effectively. You need to have i2c and
lm_sensors installed before running this program.
Also, you need to be `root', or at least have access to 
the /dev/i2c-*
files, for most things.
If you have patched your kernel and have some drivers built in, 
you can
safely answer NO if asked to load some modules. In this case, 
things may
seem a bit confusing, but they will still work.

 We can start with probing for (PCI) I2C or SMBus adapters.
 You do not need any special privileges for this.
 Do you want to probe now? (YES/no): Y
Probing for PCI bus adapters...
Use driver `i2c-viapro' for device 00:11.0: VIA Technologies 
VT8233A/8235 South Bridge
Probe succesfully concluded.

 We will now try to load each adapter module in turn.
Load `i2c-viapro' (say NO if built into your kernel)? (YES/no): Y
Module loaded succesfully.
 Do you now want to be prompted for non-detectable adapters? 
(yes/NO): y
Load `i2c-elektor' (say NO if built into your kernel)? (YES/no): 
Y
FATAL: Error inserting i2c-elektor 
(/lib/modules/2.6.3-15mdk/kernel/drivers/i2c/busses/i2c-elektor.ko.gz): 
No such device
Loading failed... skipping.
Load `i2c-elv' (say NO if built into your kernel)? (YES/no): Y
FATAL: Error inserting i2c-elv 
(/lib/modules/2.6.3-15mdk/kernel/drivers/i2c/busses/i2c-elv.ko.gz): 
No such device
Loading failed... skipping.
Load `i2c-philips-par' (say NO if built into your kernel)? 
(YES/no): Y
Module loaded succesfully.
Load `i2c-velleman' (say NO if built into your kernel)? (YES/no): 
Y
FATAL: Error inserting i2c-velleman 
(/lib/modules/2.6.3-15mdk/kernel/drivers/i2c/busses/i2c-velleman.ko.gz): 
No such device
Loading failed... skipping.
 To continue, we need module `i2c-dev' to be loaded.
 If it is built-in into your kernel, you can safely skip this.
 i2c-dev is not loaded. Do you want to load it now? (YES/no): Y
 Module loaded succesfully.

 We are now going to do the adapter probings. Some adapters may 
hang halfway
 through; we can't really help that. Also, some chips will be 
double detected;
 we choose the one with the highest confidence value in that 
case.
 If you found that the adapter hung after probing a certain 
address, you can
 specify that address to remain unprobed. That often
 includes address 0x69 (clock chip).

Next adapter: SMBus Via Pro adapter at 5000 (Algorithm 
unavailable)
Do you want to scan it? (YES/no/selectively): Y
Client found at address 0x4c
Probing for `National Semiconductor LM75'... Failed!
Probing for `Dallas Semiconductor DS1621'... Failed!
Probing for `Analog Devices ADM1021'... Failed!
Probing for `Analog Devices ADM1021A/ADM1023'... Failed!
Probing for `Maxim MAX1617'... Success!
    (confidence 3, driver `adm1021')
Probing for `Maxim MAX1617A'... Failed!
Probing for `TI THMC10'... Failed!
Probing for `National Semiconductor LM84'... Failed!
Probing for `Genesys Logic GL523SM'... Failed!
Probing for `Onsemi MC1066'... Failed!
Probing for `National Semiconductor LM82'... Failed!
Probing for `National Semiconductor LM83'... Failed!
Probing for `National Semiconductor LM90'... Success!
    (confidence 8, driver `lm90')
Probing for `National Semiconductor LM89'... Failed!
Probing for `National Semiconductor LM86'... Failed!
Probing for `Analog Devices ADM1032'... Failed!
Probing for `Maxim MAX6657/MAX6658'... Failed!
Client found at address 0x50
Probing for `SPD EEPROM'... Success!
    (confidence 8, driver `eeprom')
Probing for `DDC monitor'... Failed!
Client found at address 0x69
Client found at address 0x6a

 Some chips are also accessible through the ISA bus. ISA probes 
are
 typically a bit more dangerous, as we have to write to I/O ports 
to do
 this.  Do you want to scan the ISA bus? (YES/no): Y
Probing for `National Semiconductor LM78'
  Trying address 0x0290... Success!
    (confidence 7, driver `lm78')
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
  Trying address 0x0290... Success!
    (confidence 8, driver `it87')
Probing for `IPMI BMC KCS'
  Trying address 0x0ca0... Failed!
Probing for `IPMI BMC SMIC'
  Trying address 0x0ca8... Failed!

 Some Super I/O chips may also contain sensors. Super I/O probes 
are
 typically a bit more dangerous, as we have to write to I/O ports 
to do
 this.  Do you want to scan for Super I/O sensors? (YES/no): Y
Probing for `ITE 8702F Super IO Sensors'
  Failed! (0x8705)
Probing for `ITE 8705F Super IO Sensors'
  Success... found at address 0x0290
Probing for `ITE 8712F Super IO Sensors'
  Failed! (0x8705)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
  Failed!
Probing for `Nat. Semi. PC87360 Super IO Fan Sensors'
  Failed!
Probing for `Nat. Semi. PC87363 Super IO Fan Sensors'
  Failed!
Probing for `Nat. Semi. PC87364 Super IO Fan Sensors'
  Failed!
Probing for `Nat. Semi. PC87365 Super IO Sensors'
  Failed!
Probing for `Nat. Semi. PC87366 Super IO Sensors'
  Failed!
Probing for `Nat. Semi. PC87372 Super IO Fan Sensors'
  Failed!
Probing for `SMSC 47B27x Super IO Fan Sensors'
  Failed!
Probing for `SMSC 47M10x/13x Super IO Fan Sensors'
  Failed!
Probing for `SMSC 47M14x Super IO Fan Sensors'
  Failed!
Probing for `SMSC 47M15x/192 Super IO Fan Sensors'
  Failed!
Probing for `VT1211 Super IO Sensors'
  Failed!
Probing for `Winbond W83627HF Super IO Sensors'
  Failed!
Probing for `Winbond W83627THF Super IO Sensors'
  Failed!
Probing for `Winbond W83637HF Super IO Sensors'
  Failed!
Probing for `Winbond W83697HF Super IO Sensors'
  Failed!
Probing for `Winbond W83697UF Super IO PWM'
  Failed!

 Now follows a summary of the probes I have just done.
 Just press ENTER to continue:

Driver `adm1021' (may not be inserted):
  Misdetects:
  * Bus `SMBus Via Pro adapter at 5000' (Algorithm unavailable)
    Busdriver `i2c-viapro', I2C address 0x4c
    Chip `Maxim MAX1617' (confidence: 3)

Driver `lm90' (should be inserted):
  Detects correctly:
  * Bus `SMBus Via Pro adapter at 5000' (Algorithm unavailable)
    Busdriver `i2c-viapro', I2C address 0x4c
    Chip `National Semiconductor LM90' (confidence: 8)

Driver `eeprom' (should be inserted):
  Detects correctly:
  * Bus `SMBus Via Pro adapter at 5000' (Algorithm unavailable)
    Busdriver `i2c-viapro', I2C address 0x50
    Chip `SPD EEPROM' (confidence: 8)

Driver `lm78' (may not be inserted):
  Misdetects:
  * ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `National Semiconductor LM78' (confidence: 7)

Driver `it87' (should be inserted but causes problems):
  Detects correctly:
  * ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `ITE 8705F Super IO Sensors' (confidence: 9)
  Misdetects:
  * ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `ITE IT8705F / IT8712F / SiS 950' (confidence: 8)


 I will now generate the commands needed to load the I2C modules.
 Sometimes, a chip is available both through the ISA bus and an 
I2C bus.
 ISA bus access is faster, but you need to load an additional 
driver module
 for it. If you have the choice, do you want to use the ISA bus 
or the
 I2C/SMBus (ISA/smbus)? I2C

To make the sensors modules behave correctly, add these lines to
/etc/modules.conf:

#----cut here----
# I2C module options
alias char-major-89 i2c-dev
options it87 ignore=-1,0x290
#----cut here----

To load everything that is needed, add this to some /etc/rc* 
file:

#----cut here----
# I2C adapter drivers
modprobe i2c-viapro
modprobe i2c-isa
# I2C chip drivers
modprobe lm90
modprobe eeprom
modprobe it87
# sleep 2 # optional
/usr/local/bin/sensors -s # recommended
#----cut here----

WARNING! If you have some things built into your kernel, the list 
above
will contain too many modules. Skip the appropriate ones! You 
really should
try these commands right now to make sure everything is working 
properly.
Monitoring programs won't work until it's done.

Do you want to generate /etc/sysconfig/lm_sensors? (YES/no): Y
Copy prog/init/lm_sensors.init to /etc/rc.d/init.d/lm_sensors
for initialization at boot time.
[root@Blackgold mkdev]# cd ..
[root@Blackgold prog]# cp 
init/lm_sensors.init /etc/rc.d/init.d/lm_sensors
[root@Blackgold prog]#
Regards:
Hoyt
Registered Linux User # 363264
http://counter.li.org
