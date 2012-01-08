From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sun, 08 Jan 2012 19:06:33 +0000
Subject: Re: [lm-sensors] [PATCH 01/17 v2] hwmon: (ad7414) fix checkpath
Message-Id: <20120108190633.GD23747@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1326047660-20539-1-git-send-email-fransmeulenbroeks@gmail.com>
In-Reply-To: <1326047660-20539-1-git-send-email-fransmeulenbroeks@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Jan 08, 2012 at 01:34:04PM -0500, Frans Meulenbroeks wrote:
> fixed:
> WARNING: simple_strtol is obsolete, use kstrtol instead
> #133: FILE: ad7414.c:133:
> +	long temp = simple_strtol(buf, NULL, 10);
> 
> Signed-off-by: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>

Series looks good.

Jean, do you want to take any of those ? Otherwise I'll apply the entire series
for one of the rc candidates, together with Frans' earlier patches.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
