From: bhayward@gmail.com (Brian Hayward)
Date: Thu, 16 Mar 2006 07:39:03 +0000
Subject: [lm-sensors] DFI Lan Party SLI-DR Expert shuts off when it87 is
Message-Id: <a33b5feb0603152339o31ec8e62r6d663692b2461d52@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <a33b5feb0603152333t5f7dcc28i24b235e39d595706@mail.gmail.com>
In-Reply-To: <a33b5feb0603152333t5f7dcc28i24b235e39d595706@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

More information:
1) First three lines when I type "sensors"
eeprom-i2c-0-57
Adapter: SMBus nForce2 adapter at 1c00
Unknown EEPROM type (53)

2) rpm -qa |grep sensors
lm_sensors-2.9.1-3.FC4.2

3) Output from running sensors-detect
# sensors-detect
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
 Do you want to probe now? (YES/no):
Probing for PCI bus adapters...
Use driver `i2c-nforce2' for device 00:01.1: nVidia Corporation nForce4
SMBus (MCP)
Probe succesfully concluded.

We will now try to load each adapter module in turn.
Module `i2c-nforce2' already loaded.
If you have undetectable or unsupported adapters, you can have them
scanned by manually loading the modules before running this script.

 To continue, we need module `i2c-dev' to be loaded.
 If it is built-in into your kernel, you can safely skip this.
 i2c-dev is not loaded. Do you want to load it now? (YES/no):
 Module loaded succesfully.

 We are now going to do the adapter probings. Some adapters may hang halfway
 through; we can't really help that. Also, some chips will be double
detected;
 we choose the one with the highest confidence value in that case.
 If you found that the adapter hung after probing a certain address, you can
 specify that address to remain unprobed. That often
 includes address 0x69 (clock chip).

Next adapter: bt878 #0 [sw]
Do you want to scan it? (YES/no/selectively): no

Next adapter: SMBus nForce2 adapter at 1c40
Do you want to scan it? (YES/no/selectively): no

Next adapter: SMBus nForce2 adapter at 1c00
Do you want to scan it? (YES/no/selectively):
Client found at address 0x08
Client found at address 0x50
Probing for `SPD EEPROM'... Success!
    (confidence 8, driver `eeprom')
Probing for `DDC monitor'... Failed!
Probing for `Maxim MAX6900'... Failed!
Client found at address 0x51
Probing for `SPD EEPROM'... Success!
    (confidence 8, driver `eeprom')
Client found at address 0x57
Probing for `SPD EEPROM'... Success!
    (confidence 1, driver `eeprom')
Probing for `Sony Vaio EEPROM'... Failed!

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
  Trying address 0x0290... Success!
    (confidence 8, driver `it87')
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
  Failed! (0x8712)
Probing for `ITE 8705F Super IO Sensors'
  Failed! (0x8712)
Probing for `ITE 8712F Super IO Sensors'
  Success... found at address 0x0290
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `SMSC 47B27x Super IO Fan Sensors'
  Failed! (skipping family)
Probing for `VT1211 Super IO Sensors'
  Failed! (skipping family)
Probing for `Winbond W83627EHF Super IO Sensors'
  Failed! (skipping family)

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

Driver `eeprom' (should be inserted):
  Detects correctly:
  * Bus `SMBus nForce2 adapter at 1c00'
    Busdriver `i2c-nforce2', I2C address 0x50
    Chip `SPD EEPROM' (confidence: 8)
  * Bus `SMBus nForce2 adapter at 1c00'
    Busdriver `i2c-nforce2', I2C address 0x51
    Chip `SPD EEPROM' (confidence: 8)
  * Bus `SMBus nForce2 adapter at 1c00'
    Busdriver `i2c-nforce2', I2C address 0x57
    Chip `SPD EEPROM' (confidence: 1)

Driver `it87' (should be inserted):
  Detects correctly:
  * ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `ITE 8712F Super IO Sensors' (confidence: 9)


 I will now generate the commands needed to load the I2C modules.
 Sometimes, a chip is available both through the ISA bus and an I2C bus.
 ISA bus access is faster, but you need to load an additional driver module
 for it. If you have the choice, do you want to use the ISA bus or the
 I2C/SMBus (ISA/smbus)? smbus

To make the sensors modules behave correctly, add these lines to
/etc/modprobe.conf:

#----cut here----
# I2C module options
alias char-major-89 i2c-dev
#----cut here----

To load everything that is needed, add this to some /etc/rc* file:

#----cut here----
# I2C adapter drivers
modprobe i2c-nforce2
modprobe i2c-isa
# I2C chip drivers
modprobe eeprom
modprobe it87
# sleep 2 # optional
/usr/bin/sensors -s # recommended
#----cut here----


On 3/16/06, Brian Hayward <bhayward at gmail.com> wrote:
>
> First off, when running sensors-detect, if I select "yes" for the next
> question, the computer turns off.
> Next adapter: SMBus nForce2 adapter at 1c40
> Do you want to scan it? (YES/no/selectively):
>
> The computer just powers down, as if I turned the switch off.  No warning
> or anything.
>
> If I select NO to the 1c40 nForc2 option and then YES to all others - the
> computer does not power off until I modprobe it87.
>
> I've tried:
>    modprobe it87
>    modprobe it87 force_it87=9191,0x290
> Same problem either way, immediate shutdown.
>
> Checking the messages file after bootup, these are the last entrys before
> the shutdown:
>
> Mar 16 01:13:14 kobold kernel: i2c /dev entries driver
> Mar 16 01:19:09 kobold kernel: it87: Found IT8712F chip at 0x290, revision
> 7
>
> Then I get messages from booting back up.
>
> If I load all suggested modules _except_ it87, it does not shut down and
> it also does not show any CPU/Fanspeed redouts when I type "sensors".
>
> Do you have any suggestions?
>
> Thanks,
> Brian Hayward
>
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060316/=
e6044871/attachment-0001.html
