From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 15 Jul 2013 17:52:52 +0000
Subject: Re: [lm-sensors] [PATCH v3 1/4] hwmon: (lm90) split set&show temp as common codes
Message-Id: <20130715195252.5d2064d7@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1373615287-18502-1-git-send-email-wni@nvidia.com>
	<1373615287-18502-2-git-send-email-wni@nvidia.com>
	<20130712152615.23464a6b@endymion.delvare>
	<20130712135000.GA3386@roeck-us.net>
	<20130712163034.1fc1cd66@endymion.delvare>
	<20130712144011.GC3629@roeck-us.net>
	<51E395D9.6070000@nvidia.com>
	<20130715092415.6d082aa2@endymion.delvare>
	<51E3BD5F.6060806@nvidia.com>
In-Reply-To: <51E3BD5F.6060806-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi Wei,

On Mon, 15 Jul 2013 17:14:07 +0800, Wei Ni wrote:
> On 07/15/2013 03:24 PM, Jean Delvare wrote:
> > On Mon, 15 Jul 2013 14:25:29 +0800, Wei Ni wrote:
> >> I think we can decide it in the DT, we can add a dt property in the lm90
> >> device node, such as:
> >> sys-interface = SYS_HWMON;
> >> or
> >> sys-interface = SYS_THERMAL;
> >> So we register it as the hwmon or thermal device
> > 
> > This is an option, but please keep in mind that DT is not the only way
> > to instantiate LM90-like devices, and we should not expose duplicate
> > inputs by default. It is fine with me if the default is to create only a
> > HWMON device (as the lm90 driver was doing so far), and only
> > DT-instantiated devices have the choice.
> 
> Yes, we should not expose duplicate inputs, we may have tree permutation:
> 1. only hwmon device:
> for this items, we just need to call hwmon_device_register().
> 2. only thermal device + virtual hwmon device:
> for this items, we just need to call thermal_zone_device_register().
> 
> We can set #1 as the default, and if use DT, we provide option to choice
> #1 or #2.

#2 makes little sense IMHO, for a driver which properly implements
hwmon support. The point of the virtual hwmon device created for
thermal zones was to not put an extra burden on thermal driver authors
by asking them to additionally implement the hwmon interface. But the
hwmon interface it richer than the thermal interface in some respects
so native hwmon implementations are preferred when available. Thus I
think your option #3 below is what we want in addition to #1, and we
don't need #2.

> 3. hwmon device + thermal device:
> for this items, we doesn't need the virtual hwmon which registered by
> the thermal fw, how to handle this one? Add flag when register as
> thermal device to indicate if want virtual hwmon device or not,
> something like your below another option.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
