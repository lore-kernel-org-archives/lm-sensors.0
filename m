From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 09 Nov 2010 16:53:14 +0000
Subject: Re: [lm-sensors] [26/32] drivers/hwmon/via-cputemp.c: Use pr_fmt
Message-Id: <20101109165314.GA17165@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <bd2bd159db94be1cfdb2bc176d3a5bb2705f79ef.1287556801.git.joe@perches.com>
In-Reply-To: <bd2bd159db94be1cfdb2bc176d3a5bb2705f79ef.1287556801.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Joe Perches <joe@perches.com>
Cc: Jean Delvare <khali@linux-fr.org>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On Wed, Oct 20, 2010 at 06:51:50AM -0000, Joe Perches wrote:
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
