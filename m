From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:24:15 +0000
Subject: MAX 6650
Message-Id: <3F526C4C.6080409@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030827130542.45ced665.khali@linux-fr.org>
In-Reply-To: <20030827130542.45ced665.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

thanks.
I tested the driver and 'sensors' by modprobing it with force_max6650; it looks good.
I added it to Module.mk.

Some comments:
	- an alarms /proc entry may be helpful
	- the xdump /proc entry is not necessary (at least to us), we have the 'i2cdump' utility
	- your choices of implementation of the speed control are fine,
 	  until we come up with a standard way of handling these.
	- guess there's no way to distinguish between 50 and 51?

Morris, John wrote:
>>>I mis-typed: that would be the MAX6650, not the MAX6550, which does
>>>not seem to exist.
>>>
>>>Do you still want it?
>>
>>Yes, we do want it.
> 
> 
> OK, I've just committed it to CVS. Although we don't use them, I've also
> made and tested 
> the necessary changes (weekend finger exercise :-) to sensors-detect and the
> "sensors"
> program. The latter could probably benefit from more work.
> 
> This was all developed and tested for an embedded system in a cross
> compilation environment,
> which is a bit different to the regular Linux build envoronment, where you
> run on the
> same machine as you compile on. That changes a lot of the assumptions about
> include paths
> and so on, so I haven't been able to do a completely clean build using the
> regular
> make system. Let me know if I've broken anything.
> 
> John.
> 
