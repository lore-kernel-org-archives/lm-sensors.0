From: jo.lodewyckx@edpnet.be (Jo Lodewyckx)
Date: Tue, 04 Apr 2006 13:57:41 +0000
Subject: [lm-sensors] ali1563 problems
Message-Id: <000001c657ef$bd81d2c0$937ba8c0@genesis>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

 

 

I'm using an asrock K8-upgrade 1698 motherboard in my server.

I wanted to use lm_sensors on it but run into some problems.

 

Sensors detect seems to detect my sensors correct but sensors gives me an
error:

 

regawebdev jo # sensors

Can't access procfs/sysfs file

Unable to find i2c bus information;

For 2.6 kernels, make sure you have mounted sysfs and libsensors

was compiled with sysfs support!

For older kernels, make sure you have done 'modprobe i2c-proc'!

 

Relevant Lspci info:

 

regawebdev jo # lspci

00:00.0 Host bridge: ALi Corporation M1689 K8 Northbridge [Super K8 Single
Chip]

00:01.0 PCI bridge: ALi Corporation AGP8X Controller

00:02.0 PCI bridge: ALi Corporation M5249 HTT to PCI Bridge

00:03.0 ISA bridge: ALi Corporation M1563 HyperTransport South Bridge (rev
70)

00:03.1 Bridge: ALi Corporation M7101 Power Management Controller [PMU]

01:00.0 VGA compatible controller: nVidia Corporation NV11 [GeForce2 MX/MX
400] (rev a1)

 

Kernel: 2.6.14-hardened-r6

Sensors version: sensors version 2.10.0 with libsensors version 2.10.0

 

Lsmod:

 

Module                  Size  Used by

i2c_dev                 9968  0

w83627hf               28394  0

hwmon_vid               2475  1 w83627hf

eeprom                  6884  0

i2c_isa                 4548  1 w83627hf

i2c_ali1563             6992  0

i2c_core               19325  5 i2c_dev,w83627hf,eeprom,i2c_isa,i2c_ali1563

 

i2c-detect -l:

i2c-0   smbus           SMBus ALi 1563 Adapter @ 0400           Non-I2C
SMBus adapter

 

i2c-detect 0:

 

I will probe file /dev/i2c/0.

I will probe address range 0x03-0x77.

Continue? [Y/n]

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f

00:          XX XX XX XX XX XX XX XX XX XX XX XX XX

10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX

20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX

30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX

40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX

50: UU UU XX XX XX XX XX XX XX XX XX XX XX XX XX XX

60: XX XX XX XX XX XX XX XX XX 69 XX XX XX XX XX XX

70: XX XX XX XX XX XX XX XX

 

Dmesg:

 

ali1563: SMBus control = 0403

ali1563_probe: Returning 0

 

some other relevant info:

regawebdev linux # cat /etc/mtab | grep sysfs
sysfs /sys sysfs rw 0 0

 

regawebdev linux # grep 'SYSFS' /usr/src/linux/.config
CONFIG_SYSFS=y

 

regawebdev linux # grep 'I2C' /usr/src/linux/.config
# I2C support
CONFIG_I2C=m
CONFIG_I2C_CHARDEV=m
# I2C Hardware Bus support
CONFIG_I2C_ALI1535=m
CONFIG_I2C_ALI1563=m
CONFIG_I2C_ALI15X3=m
CONFIG_I2C_ISA=m

 

Relevant sensors detect output:

 

We will now try to load each adapter module in turn.
Load `i2c-ali1563' (say NO if built into your kernel)? (YES/no):
Module loaded succesfully.
Load `rivatv' (say NO if built into your kernel)? (YES/no):
FATAL: Module rivatv not found.
Loading failed... skipping.
** Note: rivatv module is available at  <http://rivatv.sourceforge.net/>
http://rivatv.sourceforge.net/
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

Next adapter: SMBus ALi 1563 Adapter @ 0400
Do you want to scan it? (YES/no/selectively):
Client found at address 0x50
Probing for `SPD EEPROM'... Success!
(confidence 8, driver `eeprom')
Probing for `DDC monitor'... Failed!
Probing for `Maxim MAX6900'... Failed!
Client found at address 0x51
Probing for `SPD EEPROM'... Success!
(confidence 8, driver `eeprom')
Client found at address 0x69

Some chips are also accessible through the ISA bus. ISA probes are
typically a bit more dangerous, as we have to write to I/O ports to do
this. This is usually safe though.

Do you want to scan the ISA bus? (YES/no):

Probing for `Winbond W83627HF'
Trying address 0x0290... Success!
(confidence 8, driver `w83781d')

Some Super I/O chips may also contain sensors. Super I/O probes are
typically a bit more dangerous, as we have to write to I/O ports to do
this. This is usually safe though.

Do you want to scan for Super I/O sensors? (YES/no):
Probing for `Winbond W83627HF Super IO Sensors'
Success... found at address 0x0290

 

 

 

Your's sincerely,

 

Jo Lodewyckx

-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060404/d63a04de/attachment-0001.html
