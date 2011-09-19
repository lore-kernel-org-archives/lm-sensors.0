From: "R, Durgadoss" <durgadoss.r@intel.com>
Date: Mon, 19 Sep 2011 06:58:50 +0000
Subject: Re: [lm-sensors] [PATCH RFC] hwmon: Add unspecified temperature
Message-Id: <D6D887BA8C9DFF48B5233887EF04654109E8D6D637@bgsmsx502.gar.corp.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1316372117-3365-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1316372117-3365-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

Patch looks fine for me. Feel free to add,
Reviewed-by: durgadoss.r@intel.com

> Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> ---
> Something like that ?
> 
> Question is if the first threshold should be numbered 0 or 1.
> I started with 1 for now since tempX also starts with 1.

I agree with you, for the very same reason.

[snip..]

Thanks,
Durga

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
