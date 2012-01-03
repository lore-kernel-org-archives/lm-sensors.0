From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 03 Jan 2012 16:49:57 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] drivers/hwmon/lm75.c: fix checkpatch
Message-Id: <1325609397.3996.20.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1325588561-31073-2-git-send-email-fransmeulenbroeks@gmail.com>
In-Reply-To: <1325588561-31073-2-git-send-email-fransmeulenbroeks@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 2012-01-03 at 06:02 -0500, Frans Meulenbroeks wrote:
> Fixed this:
> 
> WARNING: strict_strtol is obsolete, use kstrtol instead
> +   error = strict_strtol(buf, 10, &temp);
> 
> by replacing strict_strtol with kstrtol
> 
> Signed-off-by: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
> ---

Thanks, applied.

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
