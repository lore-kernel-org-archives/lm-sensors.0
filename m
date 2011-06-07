From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 07 Jun 2011 08:53:05 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon/f71882fg: Add support for the f71869a
Message-Id: <20110607105305.54646154@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1306676086-6253-1-git-send-email-hdegoede@redhat.com>
In-Reply-To: <1306676086-6253-1-git-send-email-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Sun, 29 May 2011 15:34:46 +0200, Hans de Goede wrote:
> The f71869a is almost the same as the f71869f/e, except that it has
> the normal number of temp and pwm zones for a f71882fg derived chip, rather
> then the limited number of the f71869f/e.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> Tested-by: Max Baldwin <archerseven@gmail.com>
> ---
>  Documentation/hwmon/f71882fg |    4 ++++
>  drivers/hwmon/Kconfig        |    2 +-
>  drivers/hwmon/f71882fg.c     |   17 +++++++++++++++--
>  3 files changed, 20 insertions(+), 3 deletions(-)
> (...)

Applied, thanks. Sorry for the delay.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
