From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 12 Dec 2010 21:47:08 +0000
Subject: Re: [lm-sensors] [PATCH] libsensors: Add missing attributes
Message-Id: <20101212224708.75b3feb9@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1292010605-22089-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1292010605-22089-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 10 Dec 2010 11:50:05 -0800, Guenter Roeck wrote:
> The attributes added in this patch are listed in the current version
> of the hwmon sysfs ABI, but not yet supported by libsensors.
> 
> This patch only adds the new attributes to libsensors. The sensors command
> will be updated in a separate patch.
> 
> Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>

Looks alright, feel free to commit.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
