From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Tue, 16 Oct 2007 10:46:55 +0000
Subject: Re: [lm-sensors] [patch 1/1] w83627hf hoist nr-1 offset out of
Message-Id: <20071016104655.GC3731@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <cfe85dfa0710121550l3eef3a9dvd4ade68510ab8003@mail.gmail.com>
In-Reply-To: <cfe85dfa0710121550l3eef3a9dvd4ade68510ab8003@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jim:

* Jim Cromie <jim.cromie@gmail.com> [2007-10-14 17:10:52 -0600]:
> Binary files hwmon-testing/arch/i386/boot/setup.elf and hwmon-hoist-temp/arch/i386/boot/setup.elf differ
> diff -ruNp -X dontdiff -X exclude-diffs hwmon-testing/drivers/hwmon/w83627hf.c hwmon-hoist-temp/drivers/hwmon/w83627hf.c
> --- hwmon-testing/drivers/hwmon/w83627hf.c	2007-10-14 13:00:24.000000000 -0600
> +++ hwmon-hoist-temp/drivers/hwmon/w83627hf.c	2007-10-14 16:58:56.000000000 -0600

When you respin a patch following review, next time please include the patch
description and Signed-off-by again.  Applied to hwmon-2.6.git/testing, thanks.

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
