From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 17 Sep 2010 10:37:12 +0000
Subject: Re: [lm-sensors] [PATCH v2 1/2] hwmon: (adm1031) Replace
Message-Id: <20100917123712.3c44235c@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1284652197-17069-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1284652197-17069-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: Randy Dunlap <rdunlap@xenotime.net>, "Ira W. Snyder" <iws@ovro.caltech.edu>, lm-sensors@lm-sensors.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 16 Sep 2010 08:49:57 -0700, Guenter Roeck wrote:
> The attribute reflects an interval, not a rate.
> 
> Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> Acked-by: Ira W. Snyder <iws@ovro.caltech.edu>
> ---
> v2: Modified sysfs-interface text
> 
>  Documentation/hwmon/sysfs-interface |    9 +++----
>  drivers/hwmon/adm1031.c             |   43 +++++++++++++++++++---------------
>  2 files changed, 28 insertions(+), 24 deletions(-)
> 

Applied, thanks.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
