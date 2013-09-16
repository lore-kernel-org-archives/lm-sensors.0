From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 16 Sep 2013 12:34:29 +0000
Subject: Re: [lm-sensors] [PATCH v3 3/4] hwmon: (lm90) add support to handle IRQ
Message-Id: <20130916143429.6b7537c2@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1373615287-18502-1-git-send-email-wni@nvidia.com>
	<1373615287-18502-4-git-send-email-wni@nvidia.com>
	<20130718175822.62c358bf@endymion.delvare>
	<51E8DFB2.9070701@nvidia.com>
	<20130727170212.29297696@endymion.delvare>
	<51F640A0.4040809@nvidia.com>
	<20130729175835.795dba2b@endymion.delvare>
	<51F776DB.3060104@nvidia.com>
In-Reply-To: <51F776DB.3060104-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sw-mobile-therm-Lp/cVzEoVyZDw2glCA4ptUEOCMrvLtNR@public.gmane.org

Hi Wei,

Sorry for the late reply, catching up with the discussions from before
my vacation...

On Tue, 30 Jul 2013 16:18:35 +0800, Wei Ni wrote:
> On 07/29/2013 11:58 PM, Jean Delvare wrote:
> > On Mon, 29 Jul 2013 18:14:56 +0800, Wei Ni wrote:
> >> Yes, we had met this problems, to fix this issue, we enabled one-shot
> >> mode in the bottom half handler of nct interrupts to force a
> >> conversion/comparison. This effectively stops repeated nct interrupts.
> >> We will do following things in the IRQ thread:
> >> 1. stand by the nct1008. (set configure register bit 6)
> >> 2. update the limit value if needed.
> >> 3. write to one-shot resister.
> >> 4. give hardware necessary time to finish conversion
> >> 5. run the nct1008 (clear configure register bit 6)
> > 
> > Doh, this is so ugly :(
> > 
> > Why don't you configure the pin as THERM2 instead of ALERT then? I'd
> > expect this to make things easier.
> 
> If configure as THERM2, only the high temperature limits are relevant,
> so when the temperature reduced, it will not trigger interrupt, and we
> can't update the cooling state.

Ah, indeed, I had not noticed this restriction.

> Or do you mean that we can configure the pin to THERM2 in the irq_thread
> to avoid the repeated interrupt ? I tried it, but no help, the nct1008
> will not run the conversion/comparison immediately, so the status
> register will not be cleared.

No, I didn't mean to suggest anything like that.

> >> (...)
> >> These trip-temps are not critical temperature, we used these temps to
> >> update cooling states. For the critical-temp, we handle it like my
> >> mentioned in #1.
> > 
> > I understand. But even if these interrupts are only used for managing
> > cooling states, a misbehavior could still have annoying consequences,
> > such as causing the thermal shutdown to trigger when this could have
> > been avoided, or throttling to stay enabled even though the system has
> > cooled down enough.
> 
> I think our driver are trying best to avoid these troubles. As I know in
> our downstream codes, we didn't met these things.
> I think since the lm90 support interrupt mode, then the driver should
> have related interface to handle it, and it can call the callback
> function to do what the platform driver want.

Yes, fair enough. I do not object to it, I was only trying to
understand how you were using it.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
