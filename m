From: jihostyle@gmail.com (Hoya)
Date: Fri, 18 Aug 2006 05:29:57 +0000
Subject: [lm-sensors] lm-sensors & IPMI problem
Message-Id: <44e55064.027cda9b.4089.ffffd722@mx.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I am using an SGI 1100 U1 server with p3 at 866*2 and ServerWorks LE
North&South Bridge. (CNB30LE & OSB4)

According to SGI's tech sheet, BMC is connected to the South Bridge SMB
which provides IPMI functionality.

 

I am using Ubuntu 6.06 (Dapper Drake) on kernel 2.6.17 with the
openIPMI(v39) and ipmisensors patch.

And I have installed lm-sensors 2.9.x deb package which was provided by
ubuntu.

 

Sensors keeps telling me it can't find any sensors and I have no idea why.
(may be incorrect kernel patch or config?)

 

My kernel patch list is as so.

1.       OpenIPMI from http://openipmi.sourceforge.net
<http://openipmi.sourceforge.net/> 

A.        linux-i2c-2.6.17-v39.0.diff

B.       linux-ipmibase-2.6.17-v39.0.diff

C.       linux-ipmismb-2.6.17-v39.0.diff

2.       IPMIsensors from http://bmcsensors-26.sourceforge.net
<http://bmcsensors-26.sourceforge.net/> 

A.        ipmisensors-20060805-0622.diff

 

The following is my lsmod readings

 

root at sigma:/usr/src/patch# lsmod

Module                  Size  Used by

i2c_isa                 5120  0

i2c_dev                 9248  0

quota_v2                9856  2

ipv6                  259168  21

ipmisensors            18792  0

ipmi_msghandler        35872  1 ipmisensors

parport_pc             36048  0

lp                     12000  0

parport                36808  2 parport_pc,lp

i2c_piix4               8912  0

floppy                 60304  0

i2c_core               27040  3 i2c_isa,i2c_dev,i2c_piix4

sworks_agp              9600  0

agpgart                32744  1 sworks_agp

e100                   35044  0

mii                     5888  1 e100

psmouse                38696  0

serio_raw               7140  0

pcspkr                  3136  0

evdev                   9984  0

ext3                  137160  5

jbd                    58228  1 ext3

mbcache                 8900  1 ext3

ide_generic             1408  0 [permanent]

ohci_hcd               21508  0

usbcore               128668  2 ohci_hcd

ide_cd                 40256  0

cdrom                  37456  1 ide_cd

ide_disk               16736  8

serverworks             8968  0 [permanent]

generic                 4516  0 [permanent]

thermal                13192  0

processor              23176  1 thermal

fan                     4708  0

vga16fb                12744  0

cfbcopyarea             3968  1 vga16fb

vgastate                9632  1 vga16fb

cfbimgblt               3072  1 vga16fb

cfbfillrect             4320  1 vga16fb

 

It seems that the ipmisensors and ipmi_msghandler have successfully loaded.

 

And the following is the output of sensors-detect.

 

root at sigma:/usr/src/patch# /usr/local/sbin/sensors-detect

 

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

Use driver `i2c-piix4' for device 00:0f.0: ServerWorks OSB4 South Bridge

Probe succesfully concluded.

 

We will now try to load each adapter module in turn.

Module `i2c-piix4' already loaded.

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

 

Next adapter: SMBus PIIX4 adapter at 0e80 (Algorithm unavailable)

Do you want to scan it? (YES/no/selectively):

Client found at address 0x60

 

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

  Trying address 0x0ca8... Success!

    (confidence 4, driver `bmcsensors')

 

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

 

 Now follows a summary of the probes I have just done.

 Just press ENTER to continue:

 

Driver `bmcsensors' (should be inserted):

  Detects correctly:

  * ISA bus address 0x0ca8 (Busdriver `i2c-isa')

    Chip `IPMI BMC SMIC' (confidence: 4)

 

 

 I will now generate the commands needed to load the I2C modules.

 Sometimes, a chip is available both through the ISA bus and an I2C bus.

 ISA bus access is faster, but you need to load an additional driver module

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

modprobe bmcsensors

# sleep 2 # optional

/usr/local/bin/sensors -s # recommended

#----cut here----

 

WARNING! If you have some things built into your kernel, the list above

will contain too many modules. Skip the appropriate ones! You really should

try these commands right now to make sure everything is working properly.

Monitoring programs won't work until it's done.

 

Do you want to generate /etc/sysconfig/lm_sensors? (yes/NO):

 

I'm not sure but it seems lm-sensors is looking for modprobe bmcsensors
which doesn't exist on my system. (I have ipmisensors instead)

 

There are no errors in dmesg.

 

Any comments on this issue would be greatly appreciated.

 

Thanks. 

-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060818/5c71a217/attachment-0001.html 
