From: John.Morris@spirentcom.com (Morris, John)
Date: Thu, 19 May 2005 06:24:15 +0000
Subject: MAX 6650
Message-Id: <629E717C12A8694A88FAA6BEF9FFCD440224B3B3@brigadoon.spirentcom.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030827130542.45ced665.khali@linux-fr.org>
In-Reply-To: <20030827130542.45ced665.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



> -----Original Message-----
> From: Mark D. Studebaker [mailto:mds@paradyne.com]
> Sent: Sunday, August 31, 2003 2:45 PM
> To: Morris, John
> Cc: 'sensors@Stimpy.netroedge.com'
> Subject: Re: MAX 6650
> 
> 
> thanks.
> I tested the driver and 'sensors' by modprobing it with 
> force_max6650; it looks good.
> I added it to Module.mk.
> 
> Some comments:
> 	- an alarms /proc entry may be helpful

OK. Will do this when time permits.

> 	- the xdump /proc entry is not necessary (at least to 
> us), we have the 'i2cdump' utility

I'll #ifdef DEBUG that.

> 	- your choices of implementation of the speed control are fine,
>  	  until we come up with a standard way of handling these.
> 	- guess there's no way to distinguish between 50 and 51?

Not that I can see, at least without a 6650 to test on. I'd guess
that the three registers it doesn't have might be the key.

If there's anyone with a board with a MAX6550 (as opposed to a MAX6551)
I'd be happy to work with them to get this sorted out: I realise it is
an ugly carbuncle on the face of the driver.

J.
