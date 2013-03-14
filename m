From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 14 Mar 2013 15:14:10 +0000
Subject: Re: [lm-sensors] [PATCH 1/5] hwmon: (w83627ehf) Use fixed attributes for SYSTIN, CPUTIN, and AUXTIN
Message-Id: <20130314151410.GA10995@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1363217037-15723-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1363217037-15723-2-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Mar 13, 2013 at 04:23:53PM -0700, Guenter Roeck wrote:
> So far the code used dynamic temperature attributes for SYSTIN, CPUTIN, and
> AUXTIN on NCT6775/NCT6776. That has the disadvantage that the mapping of
> tempX_type and tempX_offset does not necessarily match reality, and code
> complexity is increased.
> 
> To avoid mapping problems and simplify the code, use fixed mapping instead, and
> use temp[4-9] for additional temperature sources.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Given that we are about to introduce a shiny new driver for NCT6775/NCT6776,
and will likely remove support for those chips from the w83627ehf driver,
maybe we should not bother and just drop this patch.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
