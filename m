From: jim.cromie@gmail.com (Jim Cromie)
Date: Fri, 10 Mar 2006 17:42:43 +0000
Subject: [lm-sensors] [patch 0/2] hwmon: add a superio_locks coordinator
Message-Id: <4411BA93.6000605@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Rudolf Marek wrote:
> Hello
>
> Sorry for the delay I have been rather busy with the school finishing stuff.
> And now my comments. I studied both patches and I really like a simplistic aproach
>
>   
thanks.  I also just noticed your reply.


> So far I know sio is used in:
>
> mmc card driver wbsd.c
> parallel port drivers parport_pc.c
> several watchdog drivers
> irda drivers
>
> After studying those drivers and your minimalistic approach in mind I came to this conclusion
>
> what about to create this API:
>
>   
How well does this API fit those drivers you surveyed ?
Is it a loose combo of the uses you saw, or a more formal one ?
I did my strawman in a vacuum, and I need to go look at those drivers
(I havent yet, I wanted to answer 1st )  thanks for IDg them

> unlock_seq[] = {0x87,0x87,0x00} maybe 0x00 to terminate the list?
>
>   
I dont get what unlock_seq is for.
> sio_enter(u8 port, u8 *unlock_seq)
> sio_exit(u8 port, u8 *lock_seq)
> sio_inb(u8 port)
> sio_outb(u8 port, u8 val)
> sio_select(u8 port, u8 ldn)
>
>   

Ive also been a little sloppy with sio vs superio names,
(pc87360 has superio_inb, superio_outb, superio_exit
I hope this hasn't confused anything.

I'll infer that you used sio_* as non-conflicting names that the 
mentioned drivers
could easily be patched to use.


> Now the big thing ;) the semaphore/mutex for the access locking would be hidden in sio_enter
> and sio_exit
>
>   
Im not sure hiding them has any value - exposing the locking lets the 
driver do it
for its needs - a driver (forex pc87360) could (not unreasonably) lock 
the sio,
then scan all its sensors, then unlock.
Im not saying thats how pc87360 should do it, just that the driver writer
can reasonably make the max-latency vs speed tradeoff.

you chose enter/exit  as your locking primitives.  This seems less 
obvious than
lock/unlock, I presume your names are taken from their presence in the 
drivers you surveyed.

FWIW, superio_exit in pc87360 looks like this:

static inline void superio_exit(int sioaddr)
{
        outb(0x02, sioaddr);
        outb(0x02, sioaddr+1);
}

I dont know whether that 02 value is something that is chip specific,
or whether its semi-standard in the world of superio-chips.


> there could be just some port-> index mapping so you will try to lock/unlock just a lock to right address
> This would solve all problems with concurrent access.
>
>   
Im not sure what you mean here - It sounds vaguely like what I proposed 
/ intended
with get_sio_gate()


> This approach should work and it is consistent with the idea of SIO, just enter the configuration space,
> alter something and exit... Just lock it between enter and exit.
>
> The locking in some other places cannot be done because the drivers can switch the bank and this is
> not good. They can try to lock/unlock the sio itself. This approach will solve those problems...
>
>   
I dont follow you.   One reason to make the sio_lock/unlock explicit is to
avoid the hassles with bank switching etc -
In diff.use*locks*.alpha-hilock  (patch 2 - flavor 1)
I take the lock once, and all sensor-scan accesses do the bank switching
they need to once, rather than re-doing it each time, just in case someone
else 'simultaneously' used the SIO and changed the bank out from under us.


> What do you say? If you like it maybe you can implement it or come with something else...
>
>   
Thanks for the dialog,  Id like to continue it, and eventually come up 
with a patch.
I have a semi-clear idea what I was proposing, Im less clear on what you 
are thinking.
Could you go back over my bullet items, and comment on each that 
warrants it ?

Forex:
do you like/dislike the struct superio_gate ?
   - I do, the new type gives some manner of type-safety,
    semantic separation from other uses of SIO port

Do you think the gate metaphor works ?
locks themselves dont have addresses, but when installed into doors etc
in your home, they protect stuff there.

do you think the singleton aspect works to coordinate SIO-port using 
drivers ?

Im gonna look at those drivers you mentioned,
to see if I glean the same API that you have.

> Regards
> Rudolf
>
>   


thanks,
jimc

