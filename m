From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Mon, 15 Oct 2007 06:56:22 +0000
Subject: Re: [lm-sensors] [ patch .24-rc0 0/5 ] SuperIO locks coordinator
Message-Id: <47130F16.3000706@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <4712F4D4.4050707@gmail.com>
In-Reply-To: <4712F4D4.4050707@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jim Cromie <jim.cromie@gmail.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>, LM Sensors <lm-sensors@lm-sensors.org>

Jim Cromie wrote:
> this patchset (on hwmon-git) re-introduces superio_locks module, 
> previously RFC'd here, where I 'borrowed' another thread..
> 
> http://marc.info/?l=linux-kernel&m5821759424601&w=2
> 
> The module shares out slots/shared-reservations containing
> a mutex, so that multiple modules can coordinate access to
> the sio-port.
> 
> Im crossposting - LKML for more reviewers, lm-sensors for
> folks with the hardware and (perhaps) more interest.
> 
> If its not too late, please consider for 2.6.24-rc0
> 
> 01 - adds superio_locks module
> 
> User-drivers specify the sio-port characteristics they can support
> device-ids, sio-port-addrs, enter & exit sequences, etc in 
> a struct superio_search (in __devinit, preferably). 
> 
> superio_find() then searches existing slots/shared-reservations 
> for a matching sio-port, and returns it if found. 
> Otherwize it probes port-addrs, specified by find() user, 
> and makes and returns a new reservation.
> 
>     superio_find()	finds and reserves the slot, 
> 			returned as ptr or null
>     superio_release()	relinguishes the slot (ref-counted)
> 
> Once theyve got the reservation in struct superio * gate 
> (as named in patches 2-5) they *may* use
> 
>     superio_lock(gate)
>     superio_enter/exit(gate)
>     superio_inb/w(gate, regaddr),
>     superio_outb/w(gate, regaddr, val)
> 
> or they can do it themselves with inb/outb, by using gate->sioaddr, etc.
> 

<snip>

> 
> - Hans, I think Ive added all your suggestions, thanks.
> 

Your welcome, at a first look over things look pretty sane now. I'm willing to 
do a full review of this, but first I would like to see some more input from 
others.

Regards,

Hans


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
