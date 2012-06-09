From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Date: Sat, 09 Jun 2012 17:07:29 +0000
Subject: Re: [lm-sensors] Driver: Super IO Chip access Locking issue
Message-Id: <Pine.LNX.4.61.1206091756260.9671@mtfhpc.demon.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.61.1206091443230.9142@mtfhpc.demon.co.uk>
 <20120609155259.GA8073@ericsson.com>
In-Reply-To: <20120609155259.GA8073@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

Hi Guenter,

On Sat, 9 Jun 2012, Guenter Roeck wrote:

> On Sat, Jun 09, 2012 at 10:39:46AM -0400, Mark Fortescue wrote:
>> Hi All,
>>
>> I have recently noticed a flaw in the design of linux drivers for SuperIO
>> chips.
>>
>> I have a dual core board with two SuperIO chips.
>>
>> Winbond W83627DFG: watchdog/w83627hf_wdt, hwmon/w83627ehf
>> Fintek F81216:
>>
>> The existing driver for the currently supported SuperIO chip is split
>> into two kernel modules each with its own private IO lock.
>>
>> If I continue this model and implement drivers to use the Fintek F81216
>> watchdog and the Winbond W83627DFG GPIO then I end up with more private IO
>> locks and more potential to get a clash when two or more drivers are
>> trying to access the same ports at the same time.
>>
>> What is needed for SuperIO chips is a common way of locking the port
>> resource while the SuperIO chip is being accessed. A single common io_lock
>> would be the first and simplest approach. This is at least safe unlike the
>> current situation.
>>
>> A better and longer term solution would be to update all the affected
>> drivers to use the existing recource allocation system for the SuperIO
>> ports (usually 0x2E/2F and 0x4E/4F) to reserve the port while it is in
>> use.
>>
>> If this is considered too slow/complex and/or too much work then an
>> alternative SuperIO port locking system may be need that dynamically
>> provides locks for a specified SuperIO port address. A driver for a
>> SuperIO chip would request a lock for the desired port address during
>> initialisation and free it up on exit. If scanning for a SuperIO chip,
>> the port lock would be requested and then freed for each port scanned,
>> untill the IO chip is located. This would involve minimal changes
>> to the existing drivers without single treading access to SuperIO chips on
>> different ports.
>>
> Some drivers already implement superio memory region locking (it87, f71882fg,
> sch56xx). Is this what you are looking for ?

Having had a quick look at the code for hwmon/it87, this is exactly 
what I was thinking of.

There seem to be a fair few superio chip drivers still to be sorted :).

Thanks for the pointer on how it should be done.

Now all I need to do is back port all the request_muxed_region code to the 
hacked 2.6.32 kernel I am working with :(.

Regards
 	Mark.
>
> Thanks,
> Guenter
>
>> If any of you think that this needs a wider ordiance, please forward to
>> the appropriate mailing lists.
>>
>> Please CC me on any followups.
>>
>> Regards
>>  	Mark Fortescue.
>>
>> mark @ mtfhpc . demon . co . uk
>>
>> _______________________________________________
>> lm-sensors mailing list
>> lm-sensors@lm-sensors.org
>> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
