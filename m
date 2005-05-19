From: dhoffman_98@yahoo.com (David Hoffman)
Date: Thu, 19 May 2005 06:25:37 +0000
Subject: I have information on Winbond W83627EHF Chip
Message-Id: <20050209193347.24549.qmail@web50704.mail.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050208060234.44864.qmail@web50702.mail.yahoo.com>
In-Reply-To: <20050208060234.44864.qmail@web50702.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

OK, well if I keep my notifier up, and I'm near the machine, I get a
message as soon as your new mail arrives, so that's close enough to get
back to you faster.

OK, I did the isaset and here is the new output from isadump:

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 01 bf 04 c8 11 00 47 30 01 c8 01 c8 3c 3c 01 0a
10: 01 00 10 00 00 01 01 3c 43 00 ff ff 24 32 00 df
20: a5 e6 cd cb ff cb 8b 29 ff d2 ff e7 00 00 00 00
30: 10 00 00 00 0c 03 00 00 00 04 00 00 40 40 01 ff
40: 03 00 00 de ff 00 03 74 2d 44 01 c4 18 95 00 a3
50: ff ff 00 ff ff ff 00 80 88 20 ff ff 19 a4 ff 05
60: a5 e6 cd cb ff cb 8b 29 ff d2 ff e7 00 00 00 00
70: 10 00 00 00 0c 03 00 00 00 04 00 00 40 40 01 ff
80: 01 bf 04 c8 11 00 47 30 01 c8 01 c8 3c 3c 01 0a
90: 01 00 10 00 00 01 01 3c 43 00 ff ff 24 32 00 df
a0: a5 e6 cd cb ff cb 8b 29 ff d2 ff e7 00 00 00 00
b0: 10 00 00 00 0c 03 00 00 00 04 00 00 40 40 01 ff
c0: 03 00 00 de ff 00 03 74 2d 44 01 c4 18 95 00 a3
d0: ff ff 00 ff ff ff 00 80 88 20 ff ff 19 a4 ff 05
e0: a5 e6 cd cb ff cb 8b 29 ff d2 ff e7 00 00 00 00
f0: 10 00 00 00 0c 03 00 00 00 04 00 00 40 40 01 ff

I can see that 0x4e WAS changed to 0.

Here is the latest output from sensors-detect:

==============
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
 i2c-dev is not loaded. Do you want to load it now? (YES/no):
 Module loaded succesfully.

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
  Failed! (skipping family)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `SMSC 47B27x Super IO Fan Sensors'
  Failed! (skipping family)
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

Do you want to generate /etc/sysconfig/lm_sensors? (YES/no): no

==============



--- Jean Delvare <khali@linux-fr.org> wrote:

> Hi David,
> 
> > Do you use any instant message programs? I have Yahoo Messenger,
> MSN
> > Messenger, and AIM, and it might be easier to communicate instead
> of
> > waiting for e-mails.
> 
> Don't know if that counts as an instant message protocol but I'm on
> IRC
> most of the time (freenode network, #linux-sensors).
> 
> > Well, I can look at the motherboard and actually see the Winbond
> chip
> > right there on the board. It has the winbond logo and the number on
> it
> > is W83627EHF-A.
> > 
> > I didn't notice the "-A" before, but I'm not sure if that means
> > anything.
> 
> I don't think it does, most Winbond chips seem to have that kind of
> name
> extention and it never meant anything (to me at least).
> 
> > I have gone into my BIOS settings and looked at the hardware
> monitor
> > and here are some of the settings it monitors:
> > --------------
> > CPU Temp
> > MB Temp
> > CPU Q-Fan Control
> > CPU Q-Fan Mode
> > CPU Fan Ratio
> > CPU Target Temperature
> > CPU Fan Speed
> > Chassis Fan Speed
> > Vcore Voltage
> > 3.3V Voltage
> > 5V Voltage
> > 12V Voltage
> > --------------
> 
> I take good note, for the time we'll have lm_sensors values to
> compare
> with.
> 
> > The Q-fan thing is specific to Asus and can automatically turn fan
> > speeds up and down depending on temperatures.
> 
> Asus wants you to believe it's specific to them, while it's not. This
> is
> a feature of the Winbond chip itself ("Thermal Cruise" as they call
> it).
> Asus gives it a different name for obvious marketing reasons, but no
> way
> this is theirs.
> 
> > Here is the output from "isadump 0x295 0x296":
> > WARNING! Running this program can cause system crashes, data loss
> and
> > worse!
> > I will probe address register 0x295 and data register 0x296.
> > Continue? [Y/n] Y
> >      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> > 00: 01 bf 04 c8 11 00 47 30 01 c8 01 c8 3c 3c 01 0a
> > 10: 01 00 10 00 00 01 01 3c 43 00 ff ff 24 32 00 e3
> > 20: a0 e6 cd cc ff cb 89 29 ff d3 ff e7 00 00 00 00
> > 30: 10 00 00 00 0c 03 00 00 00 04 00 00 40 40 01 ff
> > 40: 03 de 2f de ff 00 03 74 2d 44 01 c4 18 95 06 a3
> > 50: e4 1f 59 96 3a 39 3d 3d e4 1f 59 96 3a 39 3d 3d
> > 60: a0 e6 cd cc ff cb 89 29 ff d3 ff e7 00 00 00 00
> > 70: 10 00 00 00 0c 03 00 00 00 04 00 00 40 40 01 ff
> > 80: 01 bf 04 c8 11 00 47 30 01 c8 01 c8 3c 3c 01 0a
> > 90: 01 00 10 00 00 01 01 3c 43 00 ff ff 24 32 00 e3
> > a0: a0 e6 cd cc ff cb 89 29 ff d3 ff e7 00 00 00 00
> > b0: 10 00 00 00 0c 03 00 00 00 04 00 00 40 40 01 ff
> > c0: 03 00 00 de ff 00 03 74 2d 44 01 c4 18 95 06 a3
> > d0: e4 1f 59 96 3a 39 3d 3d e4 1f 59 96 3a 39 3d 3d
> > e0: a0 e6 cd cc ff cb 89 29 ff d3 ff e7 00 00 00 00
> > f0: 10 00 00 00 0c 03 00 00 00 04 00 00 40 40 01 ff
> 
> OK... Your chip is stuck with bank 6 selected. Sensors-detect can
> only
> detect Winbond chips on bank 0 (the default). Please do:
> 
> isaset 0x295 0x296 0x4e 0
> 
> then again:
> 
> isadump 0x295 0x296
> 
> You may even try sensors-detect and see if the W83627EHF is now found
> as
> an ISA chip as well.
> 
> Thanks!
> -- 
> Jean Delvare
> 



	
		
__________________________________ 
Do you Yahoo!? 
Yahoo! Mail - You care about security. So do we. 
http://promotions.yahoo.com/new_mail
