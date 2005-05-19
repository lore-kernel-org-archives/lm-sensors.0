From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:44 +0000
Subject: reference ticket 1087
Message-Id: <3DFBF756.7060801@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

did you rerun 'make dep'?
did i2c-ali1535.o get created?
try deleting drivers/i2c/*.o and try again...

root wrote:
> this is the error the kernel gives me when compiling the ali interfaces as 
> part of the kernel
> 
>         arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o 
> fs/fs.o ipc/ipc.o \
>          drivers/parport/driver.o drivers/char/char.o drivers/block/block.o 
> drivers/misc/misc.o drivers/net/net.o drivers/media/media.o 
> drivers/char/agp/agp.o drivers/char/drm/drm.o drivers/net/wan/wan.o 
> drivers/ide/idedriver.o drivers/scsi/scsidrv.o drivers/cdrom/driver.o 
> drivers/sound/sounddrivers.o drivers/pci/driver.o drivers/video/video.o 
> drivers/i2c/i2c.o drivers/telephony/telephony.o drivers/sensors/sensor.o \
>         net/network.o \
>         /usr/src/linux-2.4.20/arch/i386/lib/lib.a 
> /usr/src/linux-2.4.20/lib/lib.a /usr/src/linux-2.4.20/arch/i386/lib/lib.a \
>         --end-group \
>         -o vmlinux
> drivers/i2c/i2c.o: [In function] En la funci?n `i2c_init_all':
> drivers/i2c/i2c.o(.text.init+0xb6): [reference to] referencia a 
> `i2c_ali1535_init' [undefined ]sin definir 
> make[1]: *** [vmlinux] Error 1
> make[1]: Leaving directory `/usr/src/linux-2.4.20'
> make: *** [stamp-build] Error 2
> 

