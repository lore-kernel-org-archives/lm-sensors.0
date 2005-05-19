From: marc@paracel.com (Marc Rieffel)
Date: Thu, 19 May 2005 06:24:45 +0000
Subject: lm_sensors on Itanium
Message-Id: <9D8C1A43309BAD4A9B46071DAF911D9E3E29F0@exch01.paracel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <9D8C1A43309BAD4A9B46071DAF911D9E4C89F0@exch01.paracel.com>
In-Reply-To: <9D8C1A43309BAD4A9B46071DAF911D9E4C89F0@exch01.paracel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[root@gb0010 hotplug]# make
gcc -D__KERNEL__ -DMODULE -DLINUX -DM7101_DEBUG -O2 -Wall -I/usr/include -c m7101.c -o m7101.o
m7101.c:67:2: #error ERROR - You must have 'Support for hot-pluggable devices' enabled in your kernel (under 'general setup')!!
make: *** [m7101.o] Error 1

I'll try recompiling the kernel with hot-plug enabled...

[root@gb0010 sensors]# ./sensors-detect

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
Sorry, no PCI bus adapters found.

 We will now try to load each adapter module in turn.
 Do you now want to be prompted for non-detectable adapters? (yes/NO):
 To continue, we need module `i2c-dev' to be loaded.
 If it is built-in into your kernel, you can safely skip this.
i2c-dev is already loaded.

 We are now going to do the adapter probings. Some adapters may hang halfway
 through; we can't really help that. Also, some chips will be double detected;
 we choose the one with the highest confidence value in that case.
 If you found that the adapter hung after probing a certain address, you can
 specify that address to remain unprobed. That often
 includes address 0x69 (clock chip).

Next adapter: ELV Parallel port adaptor (Bit-shift algorithm)
Do you want to scan it? (YES/no/selectively): no

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
  Trying address 0x0ca0... Failed!
Probing for `IPMI BMC SMIC'
  Trying address 0x0ca8... Failed!

 Some Super I/O chips may also contain sensors. Super I/O probes are
 typically a bit more dangerous, as we have to write to I/O ports to do
 this.  Do you want to scan for Super I/O sensors? (YES/no):
Probing for `ITE 8702F Super IO Sensors'
  Failed! (0x5101)
Probing for `ITE 8705F Super IO Sensors'
  Failed! (0x5101)
Probing for `ITE 8712F Super IO Sensors'
  Failed! (0x5101)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
  Failed! (0x51)
Probing for `Nat. Semi. PC87360 Super IO Fan Sensors'
  Failed! (0x51)
Probing for `Nat. Semi. PC87363 Super IO Fan Sensors'
  Failed! (0x51)
Probing for `Nat. Semi. PC87364 Super IO Fan Sensors'
  Failed! (0x51)
Probing for `Nat. Semi. PC87365 Super IO Sensors'
  Failed! (0x51)
Probing for `Nat. Semi. PC87366 Super IO Sensors'
  Failed! (0x51)
Probing for `Nat. Semi. PC87372 Super IO Fan Sensors'
  Failed! (0x51)
Probing for `SMSC 47B27x Super IO Fan Sensors'
  Failed! (0x51)
Probing for `SMSC 47M10x/13x Super IO Fan Sensors'
  Failed! (0x51)
Probing for `SMSC 47M14x Super IO Fan Sensors'
  Failed! (0x51)
Probing for `SMSC 47M15x/192 Super IO Fan Sensors'
  Failed! (0x51)
Probing for `VT1211 Super IO Sensors'
  Failed! (0x51)
Probing for `Winbond W83627HF Super IO Sensors'
  Failed! (0x51)
Probing for `Winbond W83627THF Super IO Sensors'
  Failed! (0x51)
Probing for `Winbond W83637HF Super IO Sensors'
  Failed! (0x51)
Probing for `Winbond W83697HF Super IO Sensors'
  Failed! (0x51)
Probing for `Winbond W83697UF Super IO PWM'
  Failed! (0x51)

 Sorry, no chips were detected.
 Either your sensors are not supported, or they are
 connected to an I2C bus adapter that we do not support.
 See doc/FAQ, doc/lm_sensors-FAQ.html, or
 http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/doc/lm_sensors-FAQ.html
 (FAQ #4.24.3) for further information.
 If you find out what chips are on your board, see
 http://secure.netroedge.com/~lm78/newdrivers.html for driver status.

> -----Original Message-----
> From: Jean Delvare [mailto:khali@linux-fr.org]
> Sent: Tuesday, March 02, 2004 1:32 PM
> To: Marc Rieffel
> Cc: sensors@Stimpy.netroedge.com
> Subject: Re: lm_sensors on Itanium
> 
> 
> > > Step 1: find if you do have a SMBus PCI device. 
> "/sbin/lspci | grep
> > > -i smbus" should help.
> > 
> > Nope:
> > 
> > [root@gb0010 lm_sensors-2.8.4]# lspci|grep -i smbus
> > [root@gb0010 lm_sensors-2.8.4]# lspci
> > 00:1d.0 USB Controller: Intel Corp. 82801DB USB (Hub  (rev 02)
> > 00:1d.1 USB Controller: Intel Corp. 82801DB USB (Hub  (rev 02)
> > 00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev 82)
> > 00:1f.0 ISA bridge: Intel Corp. 82801DB ISA Bridge (LPC) (rev 02)
> > 00:1f.1 IDE interface: Intel Corp. 82801DB IDE U100 (rev 02)
> 
> That one (82801DB) is known for its hability to hide itself. 
> Give a try
> to the p4b_smbus driver (look in lm_sensors2/prog/hotplug), 
> it might be
> what you need.
> 
> If it works, you'll need to run sensors-detect again after loading the
> module (IIRC).
> 
> > > My guess goes to a SMSC 47B27x. It isn't a full hardware 
> monitoring
> > > chip, but has Fan control capabilities.
> > 
> > You win the prize!  Looking on the board, I saw SMSC LPC47B272, ADM
> > 1026, and ADM 211 chips.  I didn't recognize any others, but that
> > doesn't mean there weren't any.
> 
> The ADM1026 is your monitoring chip. It is I2C-only, so it 
> has to be on
> the supposedly hidden 82801 SMBus.
> 
> > Yes, I'm willing to try the updated version.  What more 
> information do
> > you need?
> 
> Get it from here:
> http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/prog/detect/se
nsors-detect

chmod +x and give it a try :)

> Here's what I got from sensors-detect after I solved the i2c-dev
> problem:

i2c-dev is needed to probe I2C busses. Since you don't have any detected
yet, it doesn't change anything. But it will if the p4b_smbus module
works.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
