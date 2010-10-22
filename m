From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 22 Oct 2010 18:39:47 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] [ARM] Kirkwood: add fan support for
Message-Id: <1287772787.9690.397.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101017154021.GB29120@kw.sim.vm.gnt>
	<1287330612-11256-1-git-send-email-simon@sequanux.org>
	<1287330612-11256-2-git-send-email-simon@sequanux.org>
	<1287712396.9690.378.camel@groeck-laptop>
	<alpine.LFD.2.00.1010212202400.2764@xanadu.home>
	<20101022082712.GU29120@kw.sim.vm.gnt>
In-Reply-To: <20101022082712.GU29120@kw.sim.vm.gnt>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, 2010-10-22 at 04:27 -0400, Simon Guinot wrote:
> Hi Nicolas,
> 
> On Thu, Oct 21, 2010 at 10:08:01PM -0400, Nicolas Pitre wrote:
> > On Thu, 21 Oct 2010, Guenter Roeck wrote:
> > 
> > > On Sun, 2010-10-17 at 11:50 -0400, Simon Guinot wrote:
> > > > From: Simon Guinot <sguinot@lacie.com>
> > > > 
> > > > Signed-off-by: Simon Guinot <sguinot@lacie.com>
> > > 
> > > Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>
> > > 
> > > I assume this will get pushed through the ARM tree, right ?
> > 
> > Might be simpler if this is routed along the same path as the core code 
> > it relies upon to avoid dependency ordering issues.  There is nothing 
> > particularly ARM specific here anyway.
> 
> There is some changes, related to the netspace_v2-setup.c file, stagged
> in your Orion tree. At some point, a merge will be needed.
> 
I rebased to Linus' latest tree which had some changes in
netspace_v2-setup.c. We'll see if that solves the merge problem.

Nicolas, I assume I have your implied Ack for this commit. If not,
please let me know.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
