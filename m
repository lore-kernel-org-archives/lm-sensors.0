From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 25 Feb 2011 18:01:04 +0000
Subject: Re: [lm-sensors] [PATCH v3 4/4] hwmon: (lm85) Add support for
Message-Id: <20110225190104.29153967@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1298654487-30232-5-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1298654487-30232-5-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 25 Feb 2011 09:21:27 -0800, Guenter Roeck wrote:
> EMC6D103S is similar to EMC6D103, only it does not support registers 62[5:7],
> 6D[0:7], and 6E[0:7]. Register respective sysfs attributes and update affected
> registers for all other chips only.
> 
> Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>

Acked-by: Jean Delvare <khali@linux-fr.org>

> ---
>  Documentation/hwmon/lm85 |   12 +++++++-
>  drivers/hwmon/lm85.c     |   75 +++++++++++++++++++++++++++++++--------------
>  2 files changed, 62 insertions(+), 25 deletions(-)
> (...)

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
