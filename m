From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 29 Jun 2007 07:17:11 +0000
Subject: Re: [lm-sensors] [PATCH] Add temperature-tracking mode to f71805f
Message-Id: <20070629091711.43c8b03b@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1182285507009@dmwebmail.belize.chezphil.org>
In-Reply-To: <1182285507009@dmwebmail.belize.chezphil.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Phil,

On Wed, 27 Jun 2007 21:32:26 +0100, Phil Endecott wrote:
> This third version of this patch:
> - Uses strtol for temperatures since they can be negative.
> - Fixes an indentation issue.
> - Removes the auto_channel files.
> - Removes the description of how this driver uses auto-point files from the sysfs documentation.
> - Uses a sign-off email address which I hope will not offend anyone.
> 
> Requests for any further changes will need to reach me very quickly as my test
> hardware will not be available for much longer.
> 
> 
> 
> This is a patch for the f71805f hwmon driver to add support for its 
> temperature-tracking mode.
> 
> Signed-off-by: Phil Endecott <kernel@chezphil.org>

This patch looks very good, thanks! I'll send it to Mark Hoffman for
upstream inclusion quickly.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
