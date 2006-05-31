From: m.teunissenvanmanen@cb2.nl (Marco Teunissen van Manen)
Date: Wed, 31 May 2006 11:54:36 +0000
Subject: [lm-sensors] Two issues: sysfs and smsc47m1 error
Message-Id: <000601c684a8$fdb00020$6fc8a8c0@WSMARCO>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Ok, the detailed info:

 

HP ML310T2G2 Server , 1Gb Memory, 70Gb SCSI HD. Intel Xeon 3.2Ghz

 

Installed SuSE 9.3 architecture: x86_64, kernel: 2.6.11.4-21.12-smp

 

# sensors -v

Sensors version 2.10.0 with libsensors version 2.10.0

 

Answer YES to all questions

# sensors-detect

Probing for `SMSC 47B27x Super IO Fan Sensors'

  Failed! (0x60)

Probing for `SMSC 47M10x/13x Super IO Fan Sensors'

  Failed! (0x60)

Probing for `SMSC 47M14x Super IO Fan Sensors'

  Failed! (0x60)

Probing for `SMSC 47M15x/192/997 Super IO Fan Sensors'

  Success... found at address 0x0400

Probing for `SMSC 47S42x Super IO Fan Sensors'

  Failed! (0x60)

Probing for `SMSC 47S45x Super IO Fan Sensors'

  Failed! (0x60)

Probing for `SMSC 47M172 Super IO'

  Failed! (0x60)

 

Now follows a summary of the probes I have just done.

 Just press ENTER to continue: YES

 

Driver `smsc47m1' (should be inserted):

  Detects correctly:

  * ISA bus address 0x0400 (Busdriver `i2c-isa')

    Chip `SMSC 47M15x/192/997 Super IO Fan Sensors' (confidence: 9)

 

 

I will now generate the commands needed to load the I2C modules.

 

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

modprobe smsc47m1

# sleep 2 # optional

/usr/local/bin/sensors -s # recommended

#----cut here----

 

Manual trying:

# lsmod | grep i2c

i2c_core               27776  0

 

# modprobe i2c-isa

# lsmod | grep i2c

i2c_isa                 3840  0

i2c_core               27776  1 i2c_isa

 

# modprobe smsc47m1

FATAL: Error inserting smsc47m1
(/lib/modules/2.6.11.4-21.12-smp/kernel/drivers/i2c/chips/smsc47m1.ko): No
such device

 

This raises my first problem. 

 

# modprobe i2c-sensor

# lsmod | grep i2c

i2c_sensor              5120  0

i2c_isa                 3840  0

i2c_core               27776  2 i2c_sensor,i2c_isa

 

# modprobe smsc47m1

FATAL: Error inserting smsc47m1
(/lib/modules/2.6.11.4-21.12-smp/kernel/drivers/i2c/chips/smsc47m1.ko): No
such device

 

Ok, so the one module I need, I cannot get loaded. Some help appreciated. 

 

Just continued with normal steps, and found the following error, which
completely eludes me as well:

# sensors -s

Can't access procfs/sysfs file

Unable to find i2c bus information;

For 2.6 kernels, make sure you have mounted sysfs and libsensors

was compiled with sysfs support!

For older kernels, make sure you have done 'modprobe i2c-proc'!

 

Ehmmm

# mount | grep sysfs

sysfs on /sys type sysfs (rw)

 

# ls /sys/bus/i2c/

.  ..  devices  drivers

 

I've been reading through the docs, searched the internet but I cannot find
a solution. Help very much appreciated.

 

WBR

Marco Teunissen van Manen

 

-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060531/8a18ec1d/attachment.html
