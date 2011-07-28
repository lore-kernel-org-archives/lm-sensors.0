From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 28 Jul 2011 06:35:38 +0000
Subject: Re: [lm-sensors] [PATCH 09/15] hwmon: Add new attributes to sysfs
Message-Id: <20110728063538.GA22163@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1310485300-2168-10-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1310485300-2168-10-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Jul 13, 2011 at 06:54:38PM -0700, Guenter Roeck wrote:
> Add the following attributes to the sysfs ABI.
> 
> in[0-*]_average
> in[0-*]_lowest
> in[0-*]_highest
> in[0-*]_reset_history
> in_reset_history
> 
> curr[1-*]_average
> curr[1-*]_lowest
> curr[1-*]_highest
> curr[1-*]_reset_history
> curr_reset_history
> 
> Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>

Jean,

any comments on this patch ?

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
