From: whereami@gmail.com (David Sharp)
Date: Sat, 17 Sep 2005 10:42:22 +0000
Subject: [lm-sensors] read()ing an i2c node results in errno=ENOSYS
Message-Id: <b4e191e70509170141620a6e13@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <b4e191e7050915035768c521ef@mail.gmail.com>
In-Reply-To: <b4e191e7050915035768c521ef@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 9/16/05, Jean Delvare <khali@linux-fr.org> wrote:
> > although the dev-interface file seems to be outdated (the i2c_smbus_*
> > "macro's" it refers to are no longer in the kernel headers, and are
> > now only in the lm_sensors' i2c-dev.h),
> 
> Care to send a patch fixing this doc file?

Sure! i'll try. Attached. It's against the 2.6.12 source i have on my
desktop box, but i don't think it has changed since.

> 
> > my amateur reading of the
> > kernel source supports that this should work. However, a read call
> > results in errno=ENOSYS (Function not implemented), although on one
> > run, i actually got EPERM, and another time resulted in SEGV.
> 
> ENOSYS is expected. You are trying to do raw I2C transfers while the bus
> driver (i2c-viapro) and underlying chip only offer SMBus transfers (that
> is, a subset of I2C.) It fails.
> 
> I'm more concerned about EPERM and SEGV, which obviously shouldn't
> happen. Hard to say why this happens without the actual code though.

well, the SEGV i couldn't repeat, and disappeared during the time it
took to compile gdb to try to debug it. Actually, the EPERM may have
happened more than once, but i can't reproduce it any more. It may
have something to do with the module loading and unloading i was doing
in vain attempts to get it to work. I'll definitely let you know if i
get them again, and can get more info. I suspect they may have been
caused by bus glitches, however. Shady programming on the
microcontrollers, maybe. We are busy now implementing some proper
SMBus on the microcontrollers anyway.

Thank you very much for your help, both on and off the list!

> 
> --
> Jean Delvare
>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: linux-2.6.12-doc-i2c-dev-interface.patch
Type: application/octet-stream
Size: 2795 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050917/0cc81559/linux-2.6.12-doc-i2c-dev-interface.obj
