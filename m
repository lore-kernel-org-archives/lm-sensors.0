From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 30 Oct 2013 16:11:17 +0000
Subject: Re: [lm-sensors] [PATCH v3 2/4] hwmon: (lm90) use macro defines for the status bit
Message-Id: <20131030161117.GB4526@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1373615287-18502-1-git-send-email-wni@nvidia.com>
 <1373615287-18502-3-git-send-email-wni@nvidia.com>
 <20130715185727.4ebde8c4@endymion.delvare>
 <20130715173322.GA20484@roeck-us.net>
 <20131030163326.4e7e0cfc@endymion.delvare>
In-Reply-To: <20131030163326.4e7e0cfc-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Wed, Oct 30, 2013 at 04:33:26PM +0100, Jean Delvare wrote:
> Hi Guenter,
> 
> On Mon, 15 Jul 2013 10:33:22 -0700, Guenter Roeck wrote:
> > On Mon, Jul 15, 2013 at 06:57:27PM +0200, Jean Delvare wrote:
> > > Unrelated to this patch, but Guenter, I am worried about the MAX6696
> > > handling here. I realize that I am the one who accepted your code, but
> > > now it looks wrong. Specifically:
> > > * We check for (status2 & 0xfe) i.e. 7 alarm bits, but the code below
> > >   only reports 2 alarms bits. So if any of the 5 other alarm bits in
> > >   STATUS2 are, we may return true (chip is tripped) but not print the
> > >   cause.
> > > * At least bits 1 and 2 of STATUS 2 fit totally fine in the driver as
> > >   it currently exists, so I can't think of any reason for not handling
> > >   them. Why are we not? Ideally we should print a message for every
> > >   alarm bit so that we never return "true" without printing a message.
> > >   Even though OT2 limits aren't handled by the driver...
> > > * If you think this piece of code shouldn't deal with OT/THERM limits
> > >   because they do not trigger an SMBus alarm, this can be discussed,
> > >   but all chips should be handled the same in this respect then.
> > > * Why in the first place is max6696's data->alert_alarms set to 0x187c
> > >   and not 0x1c7c? Including 1OPEN but not 2OPEN makes no sense.
> > 
> > I am about to leave for vacation, so this will have to wait for a couple of
> > weeks. I'll look at it after I am back.
> 
> Are you back now? ;-)
> 
Yes, only I completely forgot about this :-). I'll add it to my task list.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
