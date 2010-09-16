From: "Ira W. Snyder" <iws@ovro.caltech.edu>
Date: Thu, 16 Sep 2010 15:14:46 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon: (adm1031) Replace update_rate
Message-Id: <20100916151446.GA14229@ovro.caltech.edu>
List-Id: <lm-sensors.vger.kernel.org>
References: <1284602835-7605-1-git-send-email-guenter.roeck@ericsson.com>
 <1284602835-7605-2-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1284602835-7605-2-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: Jean Delvare <khali@linux-fr.org>, Randy Dunlap <rdunlap@xenotime.net>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

On Wed, Sep 15, 2010 at 07:07:14PM -0700, Guenter Roeck wrote:
> The attribute reflects an interval, not a rate.
> 
> Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> ---
>  Documentation/hwmon/sysfs-interface |   12 +++++-----
>  drivers/hwmon/adm1031.c             |   43 +++++++++++++++++++---------------
>  2 files changed, 30 insertions(+), 25 deletions(-)
> 

I'm the original author of both the update_rate text in sysfs-interface
and the adm1031 support. Your change looks good to me. Thanks for doing
the work.

Acked-by: Ira W. Snyder <iws@ovro.caltech.edu>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
