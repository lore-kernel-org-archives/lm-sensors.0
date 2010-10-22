From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 22 Oct 2010 04:30:00 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] [ARM] Kirkwood: add fan support for
Message-Id: <20101022043000.GA29632@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101017154021.GB29120@kw.sim.vm.gnt>
	<1287330612-11256-1-git-send-email-simon@sequanux.org>
	<1287330612-11256-2-git-send-email-simon@sequanux.org>
	<1287712396.9690.378.camel@groeck-laptop>
	<alpine.LFD.2.00.1010212202400.2764@xanadu.home>
In-Reply-To: <alpine.LFD.2.00.1010212202400.2764@xanadu.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Oct 21, 2010 at 10:08:01PM -0400, Nicolas Pitre wrote:
> On Thu, 21 Oct 2010, Guenter Roeck wrote:
> 
> > On Sun, 2010-10-17 at 11:50 -0400, Simon Guinot wrote:
> > > From: Simon Guinot <sguinot@lacie.com>
> > > 
> > > Signed-off-by: Simon Guinot <sguinot@lacie.com>
> > 
> > Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>
> > 
> > I assume this will get pushed through the ARM tree, right ?
> 
> Might be simpler if this is routed along the same path as the core code 
> it relies upon to avoid dependency ordering issues.  There is nothing 
> particularly ARM specific here anyway.
> 
Fine with me, as long as no one objects. Simon, can you reparent this
on top of your patch v3 (or maybe on top of 2.6.36) and re-send it ?
For some reason git refuses to apply it for me.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
