From: david.c.hubbard@gmail.com (David Hubbard)
Date: Fri, 15 Sep 2006 00:53:40 +0000
Subject: [lm-sensors] [RFC-patch 0/3] SuperIO locks coordinator
Message-Id: <4dfa50520609141753h34e54fdayba62f1b127d58036@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4508FF2F.5020504@gmail.com>
In-Reply-To: <4508FF2F.5020504@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jim,

> Some SuperIO devices implement a pseudo-locking scheme which
> turns off the port unless an activation-sequence is used 1st.
> Once a port is 'idled', it will ignore access until it is re-activated
> by doing a specific sequence of operations.
>
> Those sequences vary per-device, and generally would require a callback
> to accomodate the variations.  This implies that all drivers for a
> superio device
> would have to supply the (same) callbacks, with superio-locks remembering
> only the 1st (they better all be the same anyway, so this by itself isnt
> a limitation).
>
> w83627ehf.c:
> static inline void superio_enter(void)
> {
>     outb(0x87, REG);
>     outb(0x87, REG);
> }
> static inline void superio_exit(void)
> {
>     outb(0x02, REG);
>     outb(0x02, VAL);
> }
>
> w83627hf.c differs from above !!!
>
> static inline void superio_exit(void)
> {
>     outb(0xAA, REG);
> }
>
>
> The problem with these pseudo-locks is they dont really protect anyway;
> if the sequences are used at all, every driver would have to unlock the
> chip b4 doing
> anything else, and (I assume) activating an already active port will work,
> allowing one driver to interfere with another.
>
> I therefore redefined those functions: superio_enter/exit() now do
> mutex_lock/unlock()
> on the reserved mutex.  Perhaps the API should have
> superio_lock/unlock() instead,
> and leave superio_enter/exit() for drivers to implement themselves if
> they need/want it.

I'd be happy to see those changes in the w83627ehf driver. I'll apply
the patches and see if I can get it working on my machine.

David

