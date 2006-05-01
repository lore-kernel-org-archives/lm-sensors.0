From: tandrews@grok.co.za (Thomas Andrews)
Date: Mon, 01 May 2006 13:58:48 +0000
Subject: [lm-sensors] Address configuration for scx200_acb
Message-Id: <20060501135848.GK11355@grok.co.za>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060427234114.941c9657.khali@linux-fr.org>
In-Reply-To: <20060427234114.941c9657.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, May 01, 2006 at 02:22:52PM +0200, Jean Delvare wrote:

> > I have a soekris net4801 which has the same sc-1100.
> > On my board, ISA addys 2e, 2f talk to a separate Super-IO chip, pc87360.
> > which IIRC has an acb unit also.
> 
> True, we don't have a driver for it at the moment though.
> 
> > Back when I got the board, the presence of 2 superio devices was somewhat
> > confusing, until Id read both datasheets - 2x.
> 
> Does the SC1100 appears at 0x4e/0x4f on your Soekris board? If so,
> Thomas' code should still work, as long as we probe both possible
> address pairs.

At the moment I'm probing 2e, 4e, and 15c for the base addresses. The
addition of the last one was as a result of two things:

    (a) The old i2c-nscacb.c driver had this option
    (b) The SC1100 data-sheet indicates that it could be located there.

I have also made this a module parameter, so you could actually probe
anywhere for the base addresses, if you needed to.

I've retained the base addresses as a module parameter, so if you specify
those, then it will skip the probing at 2e, 4e, and 15c, and just use
the addresses you give.

Will that satisfy everyone's needs?

Regards,
Thomas

