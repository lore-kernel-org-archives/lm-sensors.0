From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:45 +0000
Subject: robustified adm1021
Message-Id: <3E1B71FF.3020607@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3E173681.3050806@paradyne.com>
In-Reply-To: <3E173681.3050806@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Ky?sti M?lkki wrote:
> On Mon, 6 Jan 2003, Mark D. Studebaker wrote:
> 
> 
>>You are correct that my change handles transient failures but
>>also hides permanent failures.
>>
>>Since there is no way to get a consistent failure indication
>>through libsensors now (0xff could become anything),
>>perhaps a new standard /proc entry (fail?), which is cleared-on-read,
>>could be used. Fail could be either 0/1 or a bitmask like alarms?
> 
> 
> I did not understand the cleared-on-read. If you mean entry for "new,
> valid data available", it does not survive several readers well.
> SNMP style of a serial incrementing every time there is "new & valid
> data" is better, but does not work for a single run of sensors.
> 

My idea was a /proc entry, "fail", which was a bitmask with
exactly the same bit assignments as "alarms" and "beeps".
And when somebody read "fail", the bits would be cleared by the driver
until the next read failure.
You are right it doesn't survive for several readers.

Another idea I had was that, on read failure, the driver would
set the appropriate "alarms" bit in /proc.
In other words the "alarms" entry in /proc would be the logical OR
of the alarms register in the chip and the driver's internal "fail" bit register.
This wouldn't require any new /proc entries, and works with
"sensors" and other libsensors programs unchanged.
What do you think of that?

> Maybe bitmask. 0 for ok, 1 uninitialized, 2 nak, 4 pec, 8 stuck?
> Even with some sensor code in 2.5 tree now, I would check with LKML
> response of using sysctls for sensors access in the first place before
> extending it to handle failures like this. I never understood the choice
> of using sysctl instead of /dev for this, not that I care or volunteer
> to port to devfs but still.
> 

I'm not volunteering either. 
The lm75 and adm1021 drivers were accepted, and i2c-proc has been
in the kernel for quite a while. I'm not at all inclined to
stir things up on LKML.

> 
>>Or, in the driver, only return 0xff for a reading after repeated read
>>failures.
> 
> 
> Daemon still needs to have some tolerance to avoid shutdown from a
> single bit error. As you noted, 0xff could become anything in
> libsensors, maybe even within the normal range of the meter.
> 

agreed. Any daemon that takes drastic action on one reading is
not too good.

> 
>>Another alternative is to let the i2c adapter do the fail indication...
>>no, probably not good.
> 
> 
> Well it does return negative already, which is nice. And print something
> in log which is good for aftermath. The point with return values from
> adapter is that different actions need be taken for failures and bus
> arbitration. Sometimes nak is normal operation, like client FIFO full or
> EEP writing.
> 

So you'd like i2c-core to return different negative values for
different error conditions (that is, pass through the bus driver error code)
rather than return -1 for everything? 
That sounds fine to me.
