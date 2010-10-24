From: =?UTF-8?B?w4lyaWMgUGllbA==?= <eric.piel@tremplin-utc.net>
Date: Sun, 24 Oct 2010 14:19:42 +0000
Subject: Re: [lm-sensors] [PATCH 04/12] hwmon: lis3: Update coordinates at
Message-Id: <4CC4407E.6060705@tremplin-utc.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1287748654-2626-1-git-send-email-samu.p.onkalo@nokia.com> <1287748654-2626-5-git-send-email-samu.p.onkalo@nokia.com>
In-Reply-To: <1287748654-2626-5-git-send-email-samu.p.onkalo@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Samu Onkalo <samu.p.onkalo@nokia.com>
Cc: khali@linux-fr.org, guenter.roeck@ericsson.com, jic23@cam.ac.uk, lm-sensors@lm-sensors.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

Op 22-10-10 13:57, Samu Onkalo schreef:
> Call input device poll function at device open to refresh coordinates
> immediately. This is needed for the case where poll interval is set to
> zero and coordinate updates happens purely under interrupt control.
>
> Signed-off-by: Samu Onkalo<samu.p.onkalo@nokia.com>
Acked-by: Eric Piel <eric.piel@tremplin-utc.net>
> ---
>   drivers/hwmon/lis3lv02d.c |    5 +++++
>   1 files changed, 5 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/hwmon/lis3lv02d.c b/drivers/hwmon/lis3lv02d.c
> index fe97390..e2e0bb4 100644
> --- a/drivers/hwmon/lis3lv02d.c
> +++ b/drivers/hwmon/lis3lv02d.c
> @@ -312,6 +312,11 @@ static void lis3lv02d_joystick_open(struct input_polled_dev *pidev)
>
>   	if (lis3_dev.pdata&&  lis3_dev.whoami = WAI_8B&&  lis3_dev.idev)
>   		atomic_set(&lis3_dev.wake_thread, 1);
> +	/*
> +	 * Update coordinates for the case where poll interval is 0 and
> +	 * the chip in running purely under interrupt control
> +	 */
> +	lis3lv02d_joystick_poll(pidev);
>   }
>
>   static void lis3lv02d_joystick_close(struct input_polled_dev *pidev)


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
