From: trinityrosh@gmail.com (Rosh shah)
Date: Wed, 13 Dec 2006 20:06:59 +0000
Subject: [lm-sensors] Problem making lmsensors work!
Message-Id: <1bebf72e0612131206r24bdb4c0vd0f35f9da801d8b8@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello ,
I am having trouble in making lmsensors work on my machine. Following are
the details:

Motherboard: Via EPIA SP - Series Mini ITX Mainboard
Kernel Version: 2.6.16
Chipset: VIA VT8237R
Sensors version: 2.10

When i run sensors, the following errors comes up:
Sensors not found!

Sensors detect gives the following result:

#sensors-detect revision 1.413 (2006/01/19 20:28:00)

This program will help you determine which I2C/SMBus modules you need to
load to use lm_sensors most effectively. You need to have i2c and
lm_sensors installed before running this program.
Also, you need to be `root', or at least have access to the /dev/i2c-*
files, for most things.
If you have patched your kernel and have some drivers built in, you can
safely answer NO if asked to load some modules. In this case, things may
seem a bit confusing, but they will still work.

It is generally safe and recommended to accept the default answers to all
questions, unless you know what you're doing.

 We can start with probing for (PCI) I2C or SMBus adapters.
 You do not need any special privileges for this.
 Do you want to probe now? (YES/no): y
Probing for PCI bus adapters...
Use driver `i2c-viapro' for device 00:11.0: VIA Technologies VT8237 South
Bridge
Probe succesfully concluded.

We will now try to load each adapter module in turn.
Module `i2c-viapro' already loaded.
If you have undetectable or unsupported adapters, you can have them
scanned by manually loading the modules before running this script.

 To continue, we need module `i2c-dev' to be loaded.
 If it is built-in into your kernel, you can safely skip this.
i2c-dev is already loaded.

 We are now going to do the adapter probings. Some adapters may hang halfway
 through; we can't really help that. Also, some chips will be double
detected;
 we choose the one with the highest confidence value in that case.
 If you found that the adapter hung after probing a certain address, you can
 specify that address to remain unprobed. That often
 includes address 0x69 (clock chip).

Next adapter: SMBus Via Pro adapter at 0500
Do you want to scan it? (YES/no/selectively): y
Client at address 0x50 can not be probed - unload all client drivers first!
Client found at address 0x69

Some chips are also accessible through the ISA bus. ISA probes are
typically a bit more dangerous, as we have to write to I/O ports to do
this. This is usually safe though.
Do you want to scan the ISA bus? (YES/no): y
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
Do you want to scan for Super I/O sensors? (YES/no): y
Probing for `ITE 8702F Super IO Sensors'
  Failed! (skipping family)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `SMSC 47B27x Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `VT1211 Super IO Sensors'
  Success... found at address 0x6000
Probing for `Winbond W83627HF Super IO Sensors'
  Failed! (0x3c)
Probing for `Winbond W83627THF Super IO Sensors'
  Failed! (0x3c)
Probing for `Winbond W83637HF Super IO Sensors'
  Failed! (0x3c)
Probing for `Winbond W83687THF Super IO Sensors'
  Failed! (0x3c)
Probing for `Winbond W83697HF Super IO Sensors'
  Failed! (0x3c)
Probing for `Winbond W83697SF/UF Super IO PWM'
  Failed! (0x3c)
Probing for `Winbond W83L517D Super IO'
  Failed! (0x3c)
Probing for `Fintek F71805F/FG Super IO Sensors'
  Failed! (0x3c02)
Probing for `Winbond W83627EHF/EHG Super IO Sensors'
  Failed! (0x3c02)

Probing for `ITE 8702F Super IO Sensors'
  Failed! (skipping family)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `SMSC 47B27x Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `VT1211 Super IO Sensors'
  Failed! (skipping family)
Probing for `Winbond W83627EHF/EHG Super IO Sensors'
  Failed! (skipping family)

 Now follows a summary of the probes I have just done.
 Just press ENTER to continue:
Now follows a summary of the probes I have just done.
 Just press ENTER to continue:

Driver `vt1211' (should be inserted):
  Detects correctly:
  * ISA bus address 0x6000 (Busdriver `i2c-isa')
    Chip `VT1211 Super IO Sensors' (confidence: 9)


I will now generate the commands needed to load the I2C modules.

To make the sensors modules behave correctly, add these lines to
/etc/modprobe.conf:

#----cut here----
# I2C module options
alias char-major-89 i2c-dev
#----cut here----

To load everything that is needed, add this to some /etc/rc* file:

#----cut here----
# I2C adapter drivers
modprobe i2c-isa
# I2C chip drivers
# Warning: the required module vt1211 is not currently installed on your
system.
# For status of 2.6 kernel ports see
http://secure.netroedge.com/~lm78/supported.html
# If driver is built-in to the kernel, or unavailable, comment out the
following line.
modprobe vt1211
# sleep 2 # optional
/usr/bin/sensors -s # recommended
#----cut here----

WARNING! If you have some things built into your kernel, the list above
will contain too many modules. Skip the appropriate ones! You really should
try these commands right now to make sure everything is working properly.
Monitoring programs won't work until it's done.

Do you want to generate /etc/sysconfig/lm_sensors? (YES/no):Y

After i ran sensors detect, i made changes as it said to /etc/modprobe.conf
file and also made changes to /etc/rc.d file. Well, i am not sure of the
later since it says add the follwing to some in /etc/rc*. Could you please
suggest as to where am i goin wrong ?

Also, when i try to access /dev/i2c-0, when logged in as root, it still says
permission denied ..cd you suggest the problem.

I2cdetect -l shows the following:
Linux-ADVS5:/ # i2cdetect -l
i2c-0   smbus           SMBus Via Pro adapter at 0500           Non-I2C
SMBus adapter

Thanks a lot for your help. Please let me know if there is any other detail
you need..

Sincerely,
Roshni
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20061213/4e1c4e97/attachment.html 
