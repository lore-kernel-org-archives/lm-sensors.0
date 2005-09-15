From: whereami@gmail.com (David Sharp)
Date: Thu, 15 Sep 2005 12:58:18 +0000
Subject: [lm-sensors] read()ing an i2c node results in errno=ENOSYS
Message-Id: <b4e191e7050915035768c521ef@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

we're working on a robotics project, and are tryng using an i2c bus to
communicate between our microcontrollers and our mini-itx pc
(via-embedded Epia ML).

the kernel is rather patched to support the hardware, but i think the
important bits are untouched (I didn't do the kernel patching myself).
It is fairly a recent kernel, i'm pretty sure 2.6.11 (i'd check, but
the box is not in front of me atm).

We have been trying to write some preliminary testing code to
communicate over the i2c bus. some of the original testing code used
i2c-dev.h from the lm_sensors project to use the SMBus functions.
These seem to work correctly. However, we don't want to use SMBus, as
it is more difficult to implement in the microcontrollers. Instead, we
would like to use plain i2c.

From my reading of Documentation/i2c/dev-inteface and some of the
kernel source, we should be able to open(), then use ioctl() to set
the slave address, and finally use read() and write() to make i2c
reads and writes.

although the dev-interface file seems to be outdated (the i2c_smbus_*
"macro's" it refers to are no longer in the kernel headers, and are
now only in the lm_sensors' i2c-dev.h), my amateur reading of the
kernel source supports that this should work. However, a read call
results in errno=ENOSYS (Function not implemented), although on one
run, i actually got EPERM, and another time resulted in SEGV.

I'm sure we've done something wrong, but I can't figure out what it
is, and the ENOSYS mystifies me. I'm fairly sure all necessary kernel
modules are loaded (i2c-core, i2c-dev, i2c-viapro, some others...)
since i2cdetect works, as well as the test using
i2c_smbus_write_block_data().

Thanks,
David Sharp
CalPoly Robotics Club
