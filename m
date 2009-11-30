From: =?UTF-8?B?w4lyaWMgUGllbA==?= <eric.piel@tremplin-utc.net>
Date: Mon, 30 Nov 2009 15:16:18 +0000
Subject: Re: [lm-sensors] [PATCH v3 4/5] lis3: Scale output values to mg
Message-Id: <4B13E1C2.9050403@tremplin-utc.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1258622842-23129-1-git-send-email-samu.p.onkalo@nokia.com> <1258622842-23129-2-git-send-email-samu.p.onkalo@nokia.com> <1258622842-23129-3-git-send-email-samu.p.onkalo@nokia.com> <1258622842-23129-4-git-send-email-samu.p.onkalo@nokia.com> <1258622842-23129-5-git-send-email-samu.p.onkalo@nokia.com>
In-Reply-To: <1258622842-23129-5-git-send-email-samu.p.onkalo@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Samu Onkalo <samu.p.onkalo@nokia.com>
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Op 19-11-09 10:27, Samu Onkalo schreef:
> Report output values as 1/1000 of earth gravity.

:
Looks good, excepted that you have some constants with a very long name.

:
> +#define LIS3_SCALING_ACCURACY           1024
> +#define LIS3_2G2G_SENSITIVITY_WAI_12B	((LIS3_SCALING_ACCURACY * 1000) / 1024)
> +#define LIS3_2G2G_SENSITIVITY_WAI_8B	(18 * LIS3_SCALING_ACCURACY)
As you'll have to rebase it anyway for the path 3, could you change
those constants to have a shorter name? At least "WAI" could go away.
And what does 2G2G stands for?

Eric

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
