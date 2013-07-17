From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 17 Jul 2013 09:46:39 +0000
Subject: Re: [lm-sensors] [PATCH v3 2/4] hwmon: (lm90) use macro defines for the status bit
Message-Id: <20130717114639.3a348931@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1373615287-18502-1-git-send-email-wni@nvidia.com>
	<1373615287-18502-3-git-send-email-wni@nvidia.com>
	<20130715185727.4ebde8c4@endymion.delvare>
	<51E641C7.4000107@nvidia.com>
	<20130717102803.6ee36313@endymion.delvare>
	<51E663FC.5050209@nvidia.com>
In-Reply-To: <51E663FC.5050209-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi Wei,

On Wed, 17 Jul 2013 17:29:32 +0800, Wei Ni wrote:
> On 07/17/2013 04:28 PM, Jean Delvare wrote:
> > I do maintain the lm90 driver, so the decision is up to me. Guenter did
> > a preliminary review of your patches and I am grateful for that, but I
> > do not intend to wait for his return to continue with your patches.
> > Otherwise he will have to do the same when he returns and I am gone,
> > and this may end up delaying your patches by one kernel version.
> 
> I will send out patches soon :)

You may want to wait until I'm done reviewing the whole v3 patch set. I
hope to have the time to do that today.

> >> (...)
> >> Oh, yes, this is a problem, I didn't noticed it.
> >> How about to use this:
> >> bool lm90_alarms_tripped(*client, *status);
> >> bool lm90_alarms2_tripped(*client, *status2);
> >> So we can read the status only once and pass it.
> > 
> > This is a good idea but you only need status, not status2, so it can be
> > made simpler:
> > bool lm90_is_tripped(*client, *status);
> > (handling both status and status 2 as you already do.)
> 
> Yes this is simpler, but I think in the future we may need to handle the
> status2, how to handle it ? Or we can define the status as
> bit[0~7]->status and bit[8~15]->status2 .

I hope we will never have to. We need it to work around a hardware
implementation bug, and I hope that newer chips implementing status2
will not have this bug.

That being said, yes, returning status and status2 combined in a 16-bit
value would make sense. We end up comparing with data->alert_alarms
which has exactly this format anyway (and so does data->alarms too.)

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
