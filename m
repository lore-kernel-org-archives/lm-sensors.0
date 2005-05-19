From: pcg@goof.com ( ( Marc A. Lehmann ))
Date: Thu, 19 May 2005 06:23:27 +0000
Subject: AS99127F ceased to work when upgrading 2.5.5 to 2.6.2
Message-Id: <20011216102314.GA879@schmorp.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I just upgraded 2.5.5 to 2.6.2. I have an ASUS-CUV4X-D, which is equipped
with an AS99127F on the SMBUS (module i2c-viapro).

sensors-detect from 2.5.5 detected my AS99127F and it worked "perfectly"
(as perfect as a chip driver can work without a data-sheet ;)

sensors-detect in 2.6.2 does detect my matrox-i2c, my bttv-i2c, my
viapro-smbus, but NOT AS99127F (output is attached, watch out for the two
errors at the beginning).

the kernel prints nothing while running sensors-detect. if I load the
i2c-viapro and the w83781d modules (with args force_as99127f=0,0x2d), I
get these kernel messages:

   i2c-core.o: client [AS99127F chip] registered to adapter [SMBus Via Pro adapter at e800](pos. 0).
   w83781d.o: Duplicate addresses 0x4f for subclients.
   i2c-core.o: client [AS99127F chip] unregistered.
   i2c-core.o: driver unregistered: W83781D sensor driver

that is, initialization fails. If i naively comment out the check

   if(data->lm75[0].addr = data->lm75[1].addr) {

I get this:

   w83781d.o: Subclient 1 registration at address 0x4f failed.

Any chance to get it working with 2.6.2, or is it better to just downgrade
to 2.5.5 again?

As a sidenote: is it possible to cleanly unload the i2c-modules again? If
I naively rmmod i2c-viapro or other modules I cannot insmod them again,
and /proc/ioports contains garbage. accessing proc files (/proc/bus/i2c-1)
gives me kernel oopses.

Thanks for any help, thx for creating lm_sensors ;)

-- 
      -----=-                                             |
      ----=-- _                                           |
      ---=---(_)__  __ ____  __       Marc Lehmann      +--
      --=---/ / _ \/ // /\ \/ /       pcg@goof.com      |e|
      -===/_/_//_/\_,_/ /_/\_\       XX11-RIPE         --+
    The choice of a GNU generation                       |
                                                         |
-------------- next part --------------
Illegal hexadecimal digit 'y' ignored at /opt/sbin/sensors-detect line 790, <INPUTFILE> line 11.
Illegal hexadecimal digit 'm' ignored at /opt/sbin/sensors-detect line 790, <INPUTFILE> line 16.
 This program will help you to determine which I2C/SMBus modules you need to
 load to use lm_sensors most effectively.
 You need to have done a `make install', issued a `depmod -a' and made sure
 `/etc/conf.modules' (or `/etc/modules.conf') contains the appropriate
 module path before you can use some functions of this utility. Read
 doc/modules for more information.
 Also, you need to be `root', or at least have access to the /dev/i2c[-]* files
 for some things. You can use prog/mkdev/mkdev.sh to create these /dev files
 if you do not have them already.
 If you have patched your kernel and have some drivers built-in you can
 safely answer NO if asked to load some modules. In this case, things may
 seem a bit confusing, but they will still work.

 We can start with probing for (PCI) I2C or SMBus adapters.
 You do not need any special privileges for this.
 Do you want to probe now? (YES/no): 
Probing for PCI bus adapters...
Use driver `i2c-viapro' for device 00:04.4: VIA Technologies VT 82C686 Apollo ACPI
Use driver `i2c-matroxfb' for device 01:00.0: MGA G400 AGP
Probe succesfully concluded.

 We will now try to load each adapter module in turn.
Module `i2c-viapro' already loaded.
Load `i2c-matroxfb' (say NO if built into your kernel)? (YES/no): no
 Do you now want to be prompted for non-detectable adapters? (yes/NO): 
 To continue, we need module `i2c-dev' to be loaded.
 If it is built-in into your kernel, you can safely skip this.
i2c-dev is already loaded.

 We are now going to do the adapter probings. Some adapters may hang halfway
 through; we can't really help that. Also, some chips will be double detected;
 we choose the one with the highest confidence value in that case.
 If you found that the adapter hung after probing a certain address, you can
 specify that address to remain unprobed. If you have a PIIX4, that often
 includes addresses 0x69 and/or 0x6a.

Next adapter: SMBus Via Pro adapter at e800 (Non-I2C SMBus adapter)
Do you want to scan it? (YES/no/selectively): 

 Some chips are also accessible through the ISA bus. ISA probes are
 typically a bit more dangerous, as we have to write to I/O ports to do
 this.  Do you want to scan the ISA bus? (YES/no): no

 Now follows a summary of the probes I have just done.
 Just press ENTER to continue: 


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
# I2C chip drivers
#----cut here----

To make the sensors modules behave correctly, add these lines to either
/etc/modules.conf or /etc/conf.modules:

#----cut here----
# I2C module options
alias char-major-89 i2c-dev
#----cut here----
