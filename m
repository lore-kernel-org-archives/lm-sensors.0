From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 12 Jul 2013 14:30:34 +0000
Subject: Re: [lm-sensors] [PATCH v3 1/4] hwmon: (lm90) split set&show temp as common codes
Message-Id: <20130712163034.1fc1cd66@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1373615287-18502-1-git-send-email-wni@nvidia.com>
	<1373615287-18502-2-git-send-email-wni@nvidia.com>
	<20130712152615.23464a6b@endymion.delvare>
	<20130712135000.GA3386@roeck-us.net>
In-Reply-To: <20130712135000.GA3386-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi Guenter,

On Fri, 12 Jul 2013 06:50:00 -0700, Guenter Roeck wrote:
> On Fri, Jul 12, 2013 at 03:26:15PM +0200, Jean Delvare wrote:
> > One thing I am a little worried about (but maybe I'm wrong) is that I
> > seem to understand you want to register every LM90-like chip as both a
> > hwmon device and two thermal devices. I seem to recall that every
> > thermal device is also exposed automatically as a virtual hwmon
> > device, is that correct? If so we will be presenting the same values
> > twice to libsensors, which would be confusing.
> 
> Not sure if that is a good idea, but if I recall correctly, the thermal folks
> plan to remove that path.

If that means that for example the ACPI thermal zone is no longer
displayed by "sensors", then I strongly object - unless it is
explicitly registered as a separate hwmon device from now on, of course.

My idea was to make the bridge optional - you decide when you register
a thermal device if it should be exposed as hwmon or not.

I don't have a strong opinion on the implementation, as long as each
input is listed by "sensors" once and only once.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
