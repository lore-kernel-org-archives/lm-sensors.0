From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 22 Jun 2005 17:22:52 +0000
Subject: [lm-sensors] Re: Qs on chips/pc87360
Message-Id: <RThpKbDY.1119453469.6033960.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <42B97A75.3060503@divsol.com>
In-Reply-To: <42B97A75.3060503@divsol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Jim,

> Im working on a pc87366_gpio module, and it seems necessary
> to coordinate locking in some way.

It might not be stricly necessary, but certainly better.

> The simplest thing seems to be to EXPORT_SYMBOL the 2
> semaphores in pc87360_data,

This is not possible as far as I know. These semaphores are not global
symbols, and I think you can only export global symbols. Anyway that's
not what you need, see below.

> (...) but then I looked more closely,
> and found something I dont understand...
>
> /*
>  * Client data (each client gets its own)
>  */
>
> struct pc87360_data {
>         struct i2c_client client;
>         struct semaphore lock;
>         struct semaphore update_lock;
>
>
> How is it possible to have each client get a separate struct
> and separate locks, and still get any protection ?
>
> Do semaphores magically interlock with other semaphores
> protecting the same resource ?   And how do they know what
> theyre protecting ?
>
> I see plenty of up/down ops on the lock, but no place where theyre
> told what theyre locking access to.
>
> Am I missing something ?

I think you are misunderstanding the meaning of "client". Here a client
does not mean a user accessing to the chip. It means an i2c_client
instance in the kernel, which technically corresponds to a physical
instance of the chip. This is certainly overkill in this case, as I
can't think of a system which would have more than one PC8736x chip
(the driver wouldn't even really support it). However, the pc87360
driver currently relies on the i2c subsystem, and it is frequent that
I2C/SMBus chips can be found several times in a system, so every i2c
chip driver works that way.

The real problem here is that this driver should NOT belong to the i2c
subsystem at all. It drives Super-I/O chips, not I2C chips. The problem
is that the current kernel code doesn't allow for hardware monitoring
drivers not to rely on the i2c subsystem. There are plans to change that
soon, but it promises to take some time.

That being said, you will notice that the pc87360 driver only accesses
the Super-I/O space when you load it. The semaphores protect the
hardware monitoring I/O ranges, NOT the Super-I/O space, this is
different. The Super-I/O space is not protected (which is not exactly
fine, but happens to work as long as the only accesses are from the init
section of the driver).

So you could add and export a semaphore protecting the Super-I/O range,
but this would make it impossible for anyone to use your GPIO driver
without loading the hardware monitoring driver. Better would be to have
a common driver for the Super-I/O access, which both the GPIO and the
hardware monitoring drivers would rely on. Yet another approach would be
to have a generic Super-I/O subsystem which would take care of the
problem for all Super-I/O chips. Evgeniy Polyakov is working on this
(although in a much more complex way I would have suggested). I don't
know the current status though.

> Do the earlier chips, 60, 65, etc also have a GPIO section,
> or is it just the 66 ?

I don't know, but all five datasheets are freely available from National
Semiconductor's site, so you could easily check.

--
Jean Delvare
