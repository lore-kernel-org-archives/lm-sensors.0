From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:25 +0000
Subject: i2c oops
Message-Id: <20031115113245.2dd85fba.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Sorry for the flood.  It seems that I spoke to soon about the i2c
> patch.  After applying the patch, I get the following error on kernel
> compilation:
> 
> ld -m elf_i386 -T /usr/src/linux-2.4.23-rc1/arch/i386/vmlinux.lds -e
> stext arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o
> init/version.o init/do_mounts.o \
>         --start-group \
>         arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o
>         mm/mm.o fs/fs.o ipc/ipc.o \
>          drivers/char/char.o drivers/block/block.o drivers/misc/misc.o
>          drivers/net/net.o drivers/net/fc/fc.o drivers/atm/atm.o
>          drivers/ide/idedriver.o drivers/scsi/scsidrv.o
>          drivers/cdrom/driver.o drivers/sound/sounddrivers.o
>          drivers/pci/driver.o drivers/video/video.o
>          drivers/usb/usbdrv.o drivers/media/media.o
>          drivers/input/inputdrv.o drivers/i2c/i2c.o drivers/md/mddev.o
>          drivers/sensors/sensor.o \
>         net/network.o \
>         /usr/src/linux-2.4.23-rc1/arch/i386/lib/lib.a
>         /usr/src/linux-2.4.23-rc1/lib/lib.a
>         /usr/src/linux-2.4.23-rc1/arch/i386/lib/lib.a \--end-group \
>         -o vmlinux
> drivers/i2c/i2c.o(.text+0x4208): In function `vt596_transaction':
> : undefined reference to `i2c_delay'
> make: *** [vmlinux] Error 1

The i2c_delay was introduced recently (i2c-2.8.1). Which versions of i2c
and lm_sensors are you using? Such an error would occur if you used
i2c-2.8.0 but lm_sensors 2.8.1, for example.

Please check that /usr/src/linux-2.4.23-rc1/include/linux/i2c.h has the
i2c_delay function defined at the end. If it hasn't, this means you
failed patching your kernel tree in a proper manner.

Since you obviously patched your kernel, you are advised to use the
enhanced i2c patch available here:
  http://www.ensicaen.ismra.fr/~delvare/devel/i2c/
which has more than the one mkpatch.pl would produce and will let you
use non-sensors i2c drivers as well. The patch replaces the i2c one
only, you'll still have to apply the lm_sensors patch after that, based
on the same version as i2c.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
