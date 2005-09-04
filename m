From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 04 Sep 2005 09:55:30 +0000
Subject: [lm-sensors] Re: RFC PATCH patch-13-mm1-hwmon-adm9240-whitespace-1
Message-Id: <20050904095526.316d6109.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <uvhkh19nggg4s7rv03ab6tetdu06jlmk42@4ax.com>
In-Reply-To: <uvhkh19nggg4s7rv03ab6tetdu06jlmk42@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Grant,

> Patches are planned to make chassis_clear write data > <dont_care>,

With what benefit?

> and rework sysfs interface to reduce driver size.

Are you referring to Yani Ioannou's dynamic sysfs callbacks? That would
be very welcome, thanks for looking into that.

> This patch removes mixed tab/space indenting,

There is nothing wrong with mixed tab/space indenting. Additionally,
this part of the code will be completely modified again if you convert
the driver to use dynamic callbacks. So I would like you not to include
these changes in this cleanup patch.

> breaks long lines,

Good.

> removed a trailing space

Good too.

Thanks,
-- 
Jean Delvare
