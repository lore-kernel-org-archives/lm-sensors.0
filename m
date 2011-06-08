From: "R, Durgadoss" <durgadoss.r@intel.com>
Date: Wed, 08 Jun 2011 10:17:30 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (coretemp) Further relax
Message-Id: <D6D887BA8C9DFF48B5233887EF046541095AFBD89F@bgsmsx502.gar.corp.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <493994B35A117E4F832F97C4719C4C04011E3427A6@orsmsx505.amr.corp.intel.com>
In-Reply-To: <493994B35A117E4F832F97C4719C4C04011E3427A6@orsmsx505.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

> 4* Regardless of the technically correct answer to point 3 above, I
>    have never seen any multi-core CPU supported by the coretemp driver
>    report different tjmax values for different cores. Did anyone ever
>    see this? If not, I would feel comfortable reading tjmax from
>    MSR_TEMPERATURE_TARGET only once per package for all models. This
>    would make driver initialization faster.
> 

When I tested in 3 of my machines, it did not Show different TjMax.
So, I agree that we should have the TjMax per package.

Thanks,
Durga

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
