From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Date: Fri, 08 Oct 2010 12:33:22 +0000
Subject: Re: [lm-sensors] [PATCH] coretemp: fix reading of microcode revision
Message-Id: <20101008123322.GB878@khazad-dum.debian.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <4CADB0A1020000780001B335@vpn.id2.novell.com>
In-Reply-To: <4CADB0A1020000780001B335@vpn.id2.novell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 08 Oct 2010, Jean Delvare wrote:
> On Fri, 08 Oct 2010 08:05:21 +0100, Jan Beulich wrote:
> > >>> On 07.10.10 at 20:46, Fenghua Yu <fenghua.yu@intel.com> wrote:
> > > On Thu, Oct 07, 2010 at 02:36:01AM -0700, Jan Beulich wrote:
> > >> @@ -327,8 +336,13 @@ static int __devinit coretemp_probe(stru
> > >>  
> > >>  	if ((c->x86_model = 0xe) && (c->x86_mask < 0xc)) {
> > >>  		/* check for microcode update */
> > >> -		rdmsr_on_cpu(data->id, MSR_IA32_UCODE_REV, &eax, &edx);
> > >> -		if (edx < 0x39) {
> > >> +		err = smp_call_function_single(data->id, get_ucode_rev_on_cpu,
> > >> +					       &edx, 1);
> > >> +		if (err)
> > >> +			dev_warn(&pdev->dev,
> > >> +				 "Cannot determine microcode revision "
> > >> +				 "of the CPU!\n");
> > > 
> > > When err, need to call dev_err and go to exit_free. This error handling 
> > > should
> > > be same as edx < 0x39 case.
> > 
> > Hmm, not sure - I'd prefer to consider the machine usable in this
> > (theoretical only anyway) case.
> 
> I tend to prefer Fenghua's approach, sorry. If a bad microcode revision
> is so wrong that we fail the probe when we see it, then a failure to
> determine the microcode revision should lead to the same result. As
> always, missing monitoring information is preferable to unreliable
> monitoring information.

That is correct.  On a related note, this is the second place in the kernel
that needs to determine the microcode revision.  Shouldn't we have this as
common arch-specific code?

The nasty thing about microcode revisions is that they can increase at any
point in time (although we CAN get notified of it), but I don't think we 
ensure that they cannot go BACK after suspend/resume cycles.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
