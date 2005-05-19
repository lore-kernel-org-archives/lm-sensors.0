From: upgrdman@mindspring.com (Farrell Farahbod)
Date: Thu, 19 May 2005 06:24:05 +0000
Subject: help: sensors-detect
Message-Id: <3F17172F.4050603@mindspring.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

i have a fair amount of expierence with linux, and recently i got a new 
motherboard and cpu. the motherboard seems to have sensors built in, so 
i wanted to be able to take advantage of them. after google'ing a 
little, i heard that using lm_sensors and gkrellm would probably be one 
of the better ways to monitor my temps/volts/rpms. so now to the point...

my motherboard is a Albatron KX400-8XV, which according to the box, 
seems to have the "VIA KT400/8235" chipset. i am pretty sure i saw 
somethnig about my chipset being supported. my cpu is an amd 
thoroughbred athlon 2000+/266fsb (1.667ghz.)

after i downloaded the tar.bz2 of lm_sensors, i read most of the faq, 
and some of the docs. theres a lot! :) and i thought mplayer had a lot 
of docs... :) after trying to get i2c and lm_sensors to compile for some 
time, i gave up and checked to see if my distro--redhat9, by any chance 
had an rpm of lm_sensors. it did. so i installed it. i would have tried 
compiling some more but there were just so many places i could have kept 
messing up on that i didn't want to waste too much time if there was 
redhat's rpm there for me.

so after i installed the rpm, i ran /usr/sbin/sensors-detect (as root,) 
and i get this error message: "...Could not find dmidecode, which should 
have been installed with lm_sensors. Runing dmidecode would help us 
determining your system vendor, which allows safer operations...."

first, is this a big problem? if so, how would i go about fixing it? i 
dont have a imb thinkpad laptop...my pc is a desktop, and its homebuilt, 
by me. i really hope i dont have to try to get compiling to work...its a 
pain for someone new to your project. compiling most software on linux 
is easy, but this isnt! :) thanks so for the software tho, cant wait 
till i get it all working.

well the program said i could contine on anyway, and asked if i wanted 
to start probing for pci i2c or smbus adapters...i chose yes.

heres what it reports:

Probing for PCI bus adapters...
Use driver `i2c-riva' for device 01:00.0: GeForce2 MX
Probe succesfully concluded.
 

  We will now try to load each adapter module in turn.
Load `i2c-riva' (say NO if built into your kernel)? (YES/no):

i dont know if that kernel module is build into my kernel. i use the 
kernel rpms from redhat becuase every time i try to compile a kernel by 
hand, using a kernel for kernel.org, i end up messing things up a lot. 
by the way "uname -r" reports 2.4.20-18.9 if this is of any help. and 
the rpm is optomized for athlon cpus.

anyway i chose yes to try to load the i2c-riva module, and i got this:

modprobe: Can't locate module i2c-riva
Loading failed (No such file or directory)... skipping.
** Note: i2c-riva module is available at
** http://drama.obuda.kando.hu/~fero/cgi-bin/rivatv.shtml

now this isnt too big of a deal to me, becuase it seems to me those 
sensors are for my geforce2 card, and im replacing it in about a week or 
two with a new geforce4 :) but either way...i suppose i should take the 
opportunity to learn, and fix this problem.

so then it says:

  Do you now want to be prompted for non-detectable adapters? (yes/NO):

i stick with no, as it seems to be reccomend (in all caps)... then it asks:

Do you want to scan the ISA bus? (YES/no):

i stick with yes...and it reports:

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

  Now follows a summary of the probes I have just done.
  Just press ENTER to continue:

it seems i have none of the above sensors... so i jsut press enter...

  I will now generate the commands needed to load the I2C modules.
  Sometimes, a chip is available both through the ISA bus and an I2C bus.
  ISA bus access is faster, but you need to load an additional driver module
  for it. If you have the choice, do you want to use the ISA bus or the
  I2C/SMBus (ISA/smbus)?

so i stick with isa... (i usually stick to what it reccomends, becuase i 
dont know much on the topic)

WARNING! If you have some things built into your kernel, the
below list will contain too many modules. Skip the appropriate ones!
To load everything that is needed, add this to some /etc/rc* file:

#----cut here----
# I2C adapter drivers
# I2C chip drivers
#----cut here----

To make the sensors modules behave correctly, add these lines to either
/etc/modules.conf or /etc/conf.modules:

#----cut here----
# I2C module options
alias char-major-89 i2c-dev
#----cut here----

Do you want to generate /etc/sysconfig/lm_sensors? (YES/no):

now im pretty sure i should have stopped a long time ago...so now i jsut 
ctrl-c...becuase i probably need to fix my errors from earlier on first.

so any help would be much appriciated :)

thanks, and sorry for such a long email...

farrell farahbod
