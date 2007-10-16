From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Tue, 16 Oct 2007 10:47:42 +0000
Subject: Re: [lm-sensors] [patch 1/1] w83627hf push nr+1 offset into
Message-Id: <20071016104742.GD3731@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <cfe85dfa0710121903r766b4b2ei69c81afab3c1e323@mail.gmail.com>
In-Reply-To: <cfe85dfa0710121903r766b4b2ei69c81afab3c1e323@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jim:

* Jim Cromie <jim.cromie@gmail.com> [2007-10-14 17:20:50 -0600]:
> Binary files hwmon-hoist-temp/arch/i386/boot/setup.elf and hwmon-fan-push-offset/arch/i386/boot/setup.elf differ
> diff -ruNp -X dontdiff -X exclude-diffs hwmon-hoist-temp/drivers/hwmon/w83627hf.c hwmon-fan-push-offset/drivers/hwmon/w83627hf.c
> --- hwmon-hoist-temp/drivers/hwmon/w83627hf.c	2007-10-14 16:58:56.000000000 -0600
> +++ hwmon-fan-push-offset/drivers/hwmon/w83627hf.c	2007-10-14 17:13:47.000000000 -0600

Applied to hwmon-2.6.git/testing, thanks.

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
