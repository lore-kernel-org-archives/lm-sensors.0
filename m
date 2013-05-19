From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 19 May 2013 15:17:47 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (tmp401) Drop redundant safety on cache lifetime
Message-Id: <20130519171747.22a97b5d@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20130519165730.2a7425d1@endymion.delvare>
In-Reply-To: <20130519165730.2a7425d1@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 19 May 2013 08:05:37 -0700, Guenter Roeck wrote:
> On Sun, May 19, 2013 at 04:57:30PM +0200, Jean Delvare wrote:
> > time_after (as opposed to time_after_equal) already ensures that the
> > cache lifetime is at least as much as requested. There is no point in
> > manually adding another jiffy to that value, and this can confuse the
> > reader into wrong interpretation.
> > 
> > Signed-off-by: Jean Delvare <khali@linux-fr.org>
> > Cc: Imre Deak <imre.deak@intel.com>
> > Cc: Guenter Roeck <linux@roeck-us.net>
> 
> Acked-by: Guenter Roeck <linux@roeck-us.net>
> 
> Are you going to take the series, or do you want me to handle it ?

You take tmp401 and I take lm63 and lm90?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
