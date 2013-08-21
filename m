From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 21 Aug 2013 12:03:59 +0000
Subject: Re: [lm-sensors] [PATCH 20/35] hwmon: use dev_get_platdata()
Message-Id: <20130821140359.5d2548fc@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <004f01ce8cfc$9f232190$dd6964b0$@samsung.com>
In-Reply-To: <004f01ce8cfc$9f232190$dd6964b0$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 30 Jul 2013 03:42:00 -0700, Guenter Roeck wrote:
> On 07/30/2013 01:13 AM, Jingoo Han wrote:
> > Use the wrapper function for retrieving the platform data instead of
> > accessing dev->platform_data directly.
> >
> > Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> 
> Looks good to me. Jean, ok if I take this patch ?

Sorry for the long silence, I was on vacation. Yes, that's OK with
me :) Thanks for asking.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
