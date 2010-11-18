From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 18 Nov 2010 19:09:15 +0000
Subject: Re: [lm-sensors] [PATCH 3/3] Print the status of fault register at
Message-Id: <20101118190915.GA18194@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4CE5595B.60300@RuggedCom.com>
In-Reply-To: <4CE5595B.60300@RuggedCom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Nov 18, 2010 at 01:45:29PM -0500, Ira W. Snyder wrote:
[ ... ]
> > 
> > A more common and chip independent solution to such scenarios would be to have a dedicated register
> > in the system to log reboot reasons. This can be anything - nvram, a chip register, or something else.
> > I don't think it is a good idea to make assumptions about reboot reasons based on the behavior
> > of one specific chip.
> > 
> 
> I can offer some insight on how I'd handle this, if the LTC4215 EN bit
> was the method used to detect SW reset on my board.
> 
> I use the U-Boot bootloader to load Linux. I have no need to access the
> chip while the bootloader is running. It would be very easy to have the
> bootloader read the value and cache it somewhere. Some possibilities
> include the U-Boot environment, or an unused register (I use a mpc83xx
> chip, which has two of these).
> 
Even then it might be simpler to just store the reset reason in one of the unused
registers and access it after the reboot. This assumes, of course, that the registers
retain their value after a reboot and have a well defined content after poweron.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
