From: dhoffman_98@yahoo.com (David Hoffman)
Date: Thu, 19 May 2005 06:25:37 +0000
Subject: I have information on Winbond W83627EHF Chip
Message-Id: <20050208225342.53850.qmail@web50702.mail.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050208060234.44864.qmail@web50702.mail.yahoo.com>
In-Reply-To: <20050208060234.44864.qmail@web50702.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

SUCCESS! Here is the latest output:


This program will help you determine which I2C/SMBus modules you need
to
load to use lm_sensors most effectively. You need to have i2c and
lm_sensors installed before running this program.
Also, you need to be `root', or at least have access to the /dev/i2c-*
files, for most things.
If you have patched your kernel and have some drivers built in, you can
safely answer NO if asked to load some modules. In this case, things
may
seem a bit confusing, but they will still work.

It is generally safe and recommended to accept the default answers to
all
questions, unless you know what you're doing.

 We can start with probing for (PCI) I2C or SMBus adapters.
 You do not need any special privileges for this.
 Do you want to probe now? (YES/no):
Probing for PCI bus adapters...
Sorry, no PCI bus adapters found.

We will now try to load each adapter module in turn.
If you have undetectable or unsupported adapters, you can have them
scanned by manually loading the modules before running this script.

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

Some chips are also accessible through the ISA bus. ISA probes are
typically a bit more dangerous, as we have to write to I/O ports to do
this. This is usually safe though.

Do you want to scan the ISA bus? (YES/no):
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
Probing for `Winbond W83627EHF'
  Trying address 0x0290... Failed!
Probing for `Winbond W83697HF'
  Trying address 0x0290... Failed!
Probing for `Silicon Integrated Systems SIS5595'
  Trying general detect... Failed!
Probing for `VIA Technologies VT82C686 Integrated Sensors'
  Trying general detect... Failed!
Probing for `VIA Technologies VT8231 Integrated Sensors'
  Trying general detect... Failed!
Probing for `ITE IT8712F'
  Trying address 0x0290... Failed!
Probing for `ITE IT8705F / SiS 950'
  Trying address 0x0290... Failed!
Probing for `IPMI BMC KCS'
  Trying address 0x0ca0... Failed!
Probing for `IPMI BMC SMIC'
  Trying address 0x0ca8... Failed!

Some Super I/O chips may also contain sensors. Super I/O probes are
typically a bit more dangerous, as we have to write to I/O ports to do
this. This is usually safe though.

Do you want to scan for Super I/O sensors? (YES/no):
Probing for `ITE 8702F Super IO Sensors'
  Failed! (0x8853)
Probing for `ITE 8705F Super IO Sensors'
  Failed! (0x8853)
Probing for `ITE 8712F Super IO Sensors'
  Failed! (0x8853)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
  Failed! (0x88)
Probing for `Nat. Semi. PC87360 Super IO Fan Sensors'
  Failed! (0x88)
Probing for `Nat. Semi. PC87363 Super IO Fan Sensors'
  Failed! (0x88)
Probing for `Nat. Semi. PC87364 Super IO Fan Sensors'
  Failed! (0x88)
Probing for `Nat. Semi. PC87365 Super IO Fan Sensors'
  Failed! (0x88)
Probing for `Nat. Semi. PC87365 Super IO Voltage Sensors'
  Failed! (0x88)
Probing for `Nat. Semi. PC87365 Super IO Thermal Sensors'
  Failed! (0x88)
Probing for `Nat. Semi. PC87366 Super IO Fan Sensors'
  Failed! (0x88)
Probing for `Nat. Semi. PC87366 Super IO Voltage Sensors'
  Failed! (0x88)
Probing for `Nat. Semi. PC87366 Super IO Thermal Sensors'
  Failed! (0x88)
Probing for `Nat. Semi. PC87372 Super IO Fan Sensors'
  Failed! (0x88)
Probing for `Nat. Semi. PC87373 Super IO Fan Sensors'
  Failed! (0x88)
Probing for `Nat. Semi. PC87371 Super IO'
  Failed! (0x88)
Probing for `Nat. Semi. PC97371 Super IO'
  Failed! (0x88)
Probing for `Nat. Semi. PC8739x Super IO'
  Failed! (0x88)
Probing for `Nat. Semi. PC8741x Super IO'
  Failed! (0x88)
Probing for `SMSC 47B27x Super IO Fan Sensors'
  Failed! (0x88)
Probing for `SMSC 47M10x/13x Super IO Fan Sensors'
  Failed! (0x88)
Probing for `SMSC 47M14x Super IO Fan Sensors'
  Failed! (0x88)
Probing for `SMSC 47M15x/192 Super IO Fan Sensors'
  Failed! (0x88)
Probing for `SMSC 47S42x Super IO Fan Sensors'
  Failed! (0x88)
Probing for `SMSC 47S45x Super IO Fan Sensors'
  Failed! (0x88)
Probing for `SMSC 47M172 Super IO'
  Failed! (0x88)
Probing for `SMSC LPC47B397-NC Super IO'
  Failed! (0x88)
Probing for `VT1211 Super IO Sensors'
  Failed! (0x88)
Probing for `Winbond W83627HF Super IO Sensors'
  Failed! (0x88)
Probing for `Winbond W83627THF Super IO Sensors'
  Failed! (0x88)
Probing for `Winbond W83637HF Super IO Sensors'
  Failed! (0x88)
Probing for `Winbond W83697HF Super IO Sensors'
  Failed! (0x88)
Probing for `Winbond W83697SF/UF Super IO PWM'
  Failed! (0x88)
Probing for `Winbond W83L517D Super IO'
  Failed! (0x88)
Probing for `Winbond W83627EHF Super IO Sensors'
  Success... found at address 0x0290

Do you want to scan for secondary Super I/O sensors? (YES/no):
Probing for `ITE 8702F Super IO Sensors'
  Failed! (skipping family)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `SMSC 47B27x Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `VT1211 Super IO Sensors'
  Failed! (skipping family)
Probing for `Winbond W83627EHF Super IO Sensors'
  Failed! (skipping family)

 Now follows a summary of the probes I have just done.
 Just press ENTER to continue:

Driver `to-be-written' (should be inserted):
  Detects correctly:
  * ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `Winbond W83627EHF Super IO Sensors' (confidence: 9)


 I will now generate the commands needed to load the I2C modules.
 Sometimes, a chip is available both through the ISA bus and an I2C
bus.
 ISA bus access is faster, but you need to load an additional driver
module
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
modprobe i2c-isa
# I2C chip drivers
# no driver for Winbond W83627EHF Super IO Sensors yet
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










--- Jean Delvare <khali@linux-fr.org> wrote:

> Hi David,
> 
> > I downloaded and installed the new script, but it looks like it
> still
> > did not detect the chip. Here is the output:
> 
> Damn. All three detection methods failed. Let's see why.
> 
> >  We can start with probing for (PCI) I2C or SMBus adapters.
> >  You do not need any special privileges for this.
> >  Do you want to probe now? (YES/no):
> > Probing for PCI bus adapters...
> > Sorry, no PCI bus adapters found.
> 
> Strange. Can you share the output of "lspci" and "lspci -n" with us?
> 
> > Probing for `Winbond W83627EHF'
> >   Trying address 0x0290... Failed!
> 
> Maybe the chip is actually at a different ISA address, can't confirm
> as
> long as the Super-I/O chip isn't properly detected.
> 
> > Probing for `Winbond W83627EHF Super IO Sensors'
> >   Failed! (0x8853)
> 
> Ah, this one is not my fault! The datasheet mentioned 0x886x as the
> chip
> ID. I've now modified the code to accept anything from 0x8840 to
> 0x887f.
> Please get the updated version and try again.
>
http://www2.lm-sensors.nu/%7Elm78/cvs/lm_sensors2/prog/detect/sensors-detect
> 
> Thanks,
> -- 
> Jean Delvare
> 


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
