From: ch@murgatroid.com (Christopher Hoover)
Date: Fri, 24 Mar 2006 04:45:36 +0000
Subject: [lm-sensors] [PATCH] Clean up magic numbers in i2c_parport.h
Message-Id: <000e01c64efd$cae7f750$8401000a@fakie>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <20060323205617.38e02afe.khali@linux-fr.org>
References: <20060323081231.D794B1EC019@garage.murgatroid.com>
In-Reply-To: <20060323081231.D794B1EC019@garage.murgatroid.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Jean Delvare' <khali@linux-fr.org>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, kernel-janitors@lists.osdl.org, 'Andrew Morton' <akpm@osdl.org>


> Beeuh. These macros don't really help. They actually make the lines
longer! I'm not taking this change, sorry.

If I kill off the macros but continue to use C99 structure initializers,
which is I believe is the proper kernel coding style today, the lines are
going to get even longer.  Is that OK?

Or are you asking for the patch w/o macros and w/o C99 structure
initializers?

I can/will do either.  Just let me know what is acceptable a priori.

-ch


