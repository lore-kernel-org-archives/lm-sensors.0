From: tandrews@grok.co.za (Thomas Andrews)
Date: Mon, 01 May 2006 17:26:10 +0000
Subject: [lm-sensors] Address configuration for scx200_acb
Message-Id: <20060501172610.GL11355@grok.co.za>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060427234114.941c9657.khali@linux-fr.org>
In-Reply-To: <20060427234114.941c9657.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, May 01, 2006 at 11:12:13AM -0400, Jim Cromie wrote:

> Thomas Andrews wrote:
> >At the moment I'm probing 2e, 4e, and 15c for the base addresses. The
> >addition of the last one was as a result of two things:
> >
> >    (a) The old i2c-nscacb.c driver had this option
> >    (b) The SC1100 data-sheet indicates that it could be located there.
> >
> >I have also made this a module parameter, so you could actually probe
> >anywhere for the base addresses, if you needed to.
> >
> >I've retained the base addresses as a module parameter, so if you specify
> >those, then it will skip the probing at 2e, 4e, and 15c, and just use
> >the addresses you give.
> >
> >Will that satisfy everyone's needs?
> >  
> 
> If theres a device-id, it would be good to check.

Yes, there is: at address 0x20 there is SIO ID. I was wondering if it
was of any use to check this because I rely on probing to find out if
the ACB devices are there, but now I am inclined to think that I should
check this byte before doing any probing.

> I dont know the 1st
> thing about the ACB (on either chip), but I will (eventually) try your
> code, to see if it works on either or both devices.

Thanks!

