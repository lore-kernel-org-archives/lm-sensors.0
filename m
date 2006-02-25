From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Sat, 25 Feb 2006 18:04:39 +0000
Subject: [lm-sensors] [patch 0/2] hwmon: add a superio_locks coordinator
Message-Id: <44009C37.1030601@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello

Sorry for the delay I have been rather busy with the school finishing stuff.
And now my comments. I studied both patches and I really like a simplistic aproach

So far I know sio is used in:

mmc card driver wbsd.c
parallel port drivers parport_pc.c
several watchdog drivers
irda drivers

After studying those drivers and your minimalistic approach in mind I came to this conclusion

what about to create this API:


unlock_seq[] = {0x87,0x87,0x00} maybe 0x00 to terminate the list?

sio_enter(u8 port, u8 *unlock_seq)
sio_exit(u8 port, u8 *lock_seq)
sio_inb(u8 port)
sio_outb(u8 port, u8 val)
sio_select(u8 port, u8 ldn)

Now the big thing ;) the semaphore/mutex for the access locking would be hidden in sio_enter
and sio_exit

there could be just some port-> index mapping so you will try to lock/unlock just a lock to right address
This would solve all problems with concurrent access.

This approach should work and it is consistent with the idea of SIO, just enter the configuration space,
alter something and exit... Just lock it between enter and exit.

The locking in some other places cannot be done because the drivers can switch the bank and this is
not good. They can try to lock/unlock the sio itself. This approach will solve those problems...

What do you say? If you like it maybe you can implement it or come with something else...

Regards
Rudolf

