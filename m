From: jim.cromie@gmail.com (Jim Cromie)
Date: Thu, 14 Sep 2006 21:58:36 +0000
Subject: [lm-sensors] [RFC-patch 0/3] SuperIO locks coordinator
Message-Id: <4509D08C.7020901@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <87fyf5jnkj.fsf@willow.rfc1149.net>	<1157815525.6877.43.camel@localhost.localdomain> <20060909220256.d4486a4f.vsu@altlinux.ru> <4508FF2F.5020504@gmail.com>
In-Reply-To: <4508FF2F.5020504@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jim Cromie <jim.cromie@gmail.com>
Cc: Sergey Vlasov <vsu@altlinux.ru>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Samuel Tardieu <sam@rfc1149.net>, Evgeniy Polyakov <johnpol@2ka.mipt.ru>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, Rudolf Marek <r.marek@sh.cvut.cz>

Jim Cromie wrote:

[ adding Rudolf Marek to cc, since he was kind enough to review the 
original patch ]
>
>
> Ive done limited testing, using the 2 drivers for my PC-87366 chip,
> to insure that I havent badly botched something, (I still may have ;)
> and looked at several of the hwmon drivers that operate superio ports.
> comments in code speak to those observations.
>
one of those observations, stated so they can be more easily reviewed 
(and refuted)

idle/activate IO-sequences:

Some SuperIO devices implement a pseudo-locking scheme which
turns off the port unless an activation-sequence is used 1st.
Once a port is 'idled', it will ignore access until it is re-activated
by doing a specific sequence of operations. 

Those sequences vary per-device, and generally would require a callback
to accomodate the variations.  This implies that all drivers for a 
superio device
would have to supply the (same) callbacks, with superio-locks remembering
only the 1st (they better all be the same anyway, so this by itself isnt 
a limitation).

w83627ehf.c:
static inline void superio_enter(void)
{
    outb(0x87, REG);
    outb(0x87, REG);
}
static inline void superio_exit(void)
{
    outb(0x02, REG);
    outb(0x02, VAL);
}

w83627hf.c differs from above !!!

static inline void superio_exit(void)
{
    outb(0xAA, REG);
}


The problem with these pseudo-locks is they dont really protect anyway;
if the sequences are used at all, every driver would have to unlock the 
chip b4 doing
anything else, and (I assume) activating an already active port will work,
allowing one driver to interfere with another.

I therefore redefined those functions: superio_enter/exit() now do 
mutex_lock/unlock()
on the reserved mutex.  Perhaps the API should have 
superio_lock/unlock() instead,
and leave superio_enter/exit() for drivers to implement themselves if 
they need/want it.


And let me be the 1st to throw a few rocks at my patches.

1- several devices in drivers/hwmon have 2-byte DEVICE_IDs,
and effectively have superio_inw(), (in both open-coded, and explicit 
forms).
My superio_get() cannot handle those devices.  I can fix it 'easily' by 
doing an inw()
if wanted devid>255, but that may be -ETOOHACKY

comments ?


