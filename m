From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 12 May 2013 23:55:19 +0000
Subject: Re: [lm-sensors] [PATCH 04/11] hwmon/lm63, lm90: take msecs_to_jiffies_min into use
Message-Id: <20130512235519.GA13521@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1368188011-23661-1-git-send-email-imre.deak@intel.com>
 <1368188011-23661-4-git-send-email-imre.deak@intel.com>
In-Reply-To: <1368188011-23661-4-git-send-email-imre.deak@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Imre Deak <imre.deak@intel.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, Jean Delvare <khali@linux-fr.org>, lm-sensors@lm-sensors.org

On Fri, May 10, 2013 at 03:13:22PM +0300, Imre Deak wrote:
> Use msecs_to_jiffies_min instead of open-coding the same.
> 
> Signed-off-by: Imre Deak <imre.deak@intel.com>
> ---

Function name could be better. Other than that,

Acked-by: Guenter Roeck <linux@roeck-us.net>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
