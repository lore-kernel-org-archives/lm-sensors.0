From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 09 Nov 2010 16:38:22 +0000
Subject: Re: [lm-sensors] [07/32] drivers/hwmon/coretemp.c: Use pr_fmt and
Message-Id: <20101109163822.GA14927@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <78de63116e59236eb0f4eaf7143760dc0fa9c9b2.1287556801.git.joe@perches.com>
In-Reply-To: <78de63116e59236eb0f4eaf7143760dc0fa9c9b2.1287556801.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Joe Perches <joe@perches.com>
Cc: Jean Delvare <khali@linux-fr.org>, Fenghua Yu <fenghua.yu@intel.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On Wed, Oct 20, 2010 at 06:51:31AM -0000, Joe Perches wrote:
> Added #define pr_fmt KBUILD_MODNAME ": " fmt
> Converted printks to pr_<level>
> Coalesced any long formats
> Removed prefixes from formats
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> 
Applied.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
