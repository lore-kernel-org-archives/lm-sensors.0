From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 09 Jan 2012 01:48:36 +0000
Subject: Re: [lm-sensors] [PATCH 17/17 v3] hwmon: (i5k_amb) fix checkpatch
Message-Id: <20120109014836.GA25268@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1326047660-20539-17-git-send-email-fransmeulenbroeks@gmail.com>
In-Reply-To: <1326047660-20539-17-git-send-email-fransmeulenbroeks@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Jan 08, 2012 at 01:34:20PM -0500, Frans Meulenbroeks wrote:
> fixed:
> WARNING: simple_strtoul is obsolete, use kstrtoul instead
> #162: FILE: i5k_amb.c:162:
> +	unsigned long temp = simple_strtoul(buf, NULL, 10) / 500;
> 
> WARNING: simple_strtoul is obsolete, use kstrtoul instead
> #178: FILE: i5k_amb.c:178:
> +	unsigned long temp = simple_strtoul(buf, NULL, 10) / 500;
> 
> WARNING: simple_strtoul is obsolete, use kstrtoul instead
> #194: FILE: i5k_amb.c:194:
> +	unsigned long temp = simple_strtoul(buf, NULL, 10) / 500;
> 
> total: 0 errors, 3 warnings, 609 lines checked
> 
> i5k_amb.c has style problems, please review.
> 
> If any of these errors are false positives, please report
> them to the maintainer, see CHECKPATCH in MAINTAINERS.
> Signed-off-by: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
> ---

Hi Frans,

I applied the entire series. I'll have to wait until the commit window closes
before I can push it to my kernel.org repository. For now, the up-to-date
repository is available at git://github.com/groeck/linux.git (branch hwmon or hwmon-next).

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
