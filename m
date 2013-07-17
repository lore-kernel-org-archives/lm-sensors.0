From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 17 Jul 2013 08:28:03 +0000
Subject: Re: [lm-sensors] [PATCH v3 2/4] hwmon: (lm90) use macro defines for the status bit
Message-Id: <20130717102803.6ee36313@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1373615287-18502-1-git-send-email-wni@nvidia.com>
	<1373615287-18502-3-git-send-email-wni@nvidia.com>
	<20130715185727.4ebde8c4@endymion.delvare>
	<51E641C7.4000107@nvidia.com>
In-Reply-To: <51E641C7.4000107-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi Wei,

On Wed, 17 Jul 2013 15:03:35 +0800, Wei Ni wrote:
> On 07/16/2013 12:57 AM, Jean Delvare wrote:
> > On Fri, 12 Jul 2013 15:48:05 +0800, Wei Ni wrote:
> >> Add bit defines for the status register.
> > 
> > Regarding the subject: for me these are constants, not macros. AFAIK
> > the term "macro" refers to defines with parameters only.
> 
> How about "Introduce status bits"

I'd say "Define status bits" as this is exactly what you're doing ;-)
That being said, your patch actually does more than this, as you are
moving code around and to a separate function. The patch description
should say that and explain why.

> >> (...)
> >> +	if ((status & 0x7f) = 0 && (status2 & 0xfe) = 0)
> >> +		return false;
> > 
> > It's a bit disappointing to not use the freshly introduced constants.
> > That being said I agree it would make the code hard to read, so you can
> > leave it as is.
> 
> Sorry, I forgot it.
> How about to define:
> #define LM90_STATUS_MASK 0x7f
> #define MAX6696_STATUS2_MASK 0xfe

I wouldn't bother. I suspect that this code will have to be reworked
soon anyway and these constants may no longer be needed then.

> Or since Guenter is for vacation, I can just leave it as is, and wait
> him back to talk about below issue.

I do maintain the lm90 driver, so the decision is up to me. Guenter did
a preliminary review of your patches and I am grateful for that, but I
do not intend to wait for his return to continue with your patches.
Otherwise he will have to do the same when he returns and I am gone,
and this may end up delaying your patches by one kernel version.

> >> (...)
> >> +		struct lm90_data *data = i2c_get_clientdata(client);
> >> +		u8 config, alarms;
> >> +
> >> +		lm90_read_reg(client, LM90_REG_R_STATUS, &alarms);
> > 
> > You end up reading LM90_REG_R_STATUS, which is not OK. This register
> > contains self-clearing bits, so there is no guarantee that the second
> > read will return the same value as the first read. You'll have to come
> > up with a different approach that reads LM90_REG_R_STATUS only once.
> 
> Oh, yes, this is a problem, I didn't noticed it.
> How about to use this:
> bool lm90_alarms_tripped(*client, *status);
> bool lm90_alarms2_tripped(*client, *status2);
> So we can read the status only once and pass it.

This is a good idea but you only need status, not status2, so it can be
made simpler:
bool lm90_is_tripped(*client, *status);
(handling both status and status 2 as you already do.)

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
