From: Laszlo Papp <lpapp@kde.org>
Date: Thu, 14 Nov 2013 18:54:17 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (max6650) Add support for gpiodef
Message-Id: <CAOMwXhMS-0AUHQ5tOo9oYEWzRZOo_DnVhm9-tYcjhhyThtca-g@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1384440661-3769-1-git-send-email-lpapp@kde.org>
In-Reply-To: <1384440661-3769-1-git-send-email-lpapp@kde.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: hjk@hansjkoch.de
Cc: Guenter Roeck <linux@roeck-us.net>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Laszlo Papp <lpapp@kde.org>

On Thu, Nov 14, 2013 at 2:51 PM, Laszlo Papp <lpapp@kde.org> wrote:
> +       case 1:
> +               data->gpiodef &= ~MAX6650_GPIO_DEF_GPIO1_LOW;
> +               data->gpiodef &= (gpio << 2);

Yikes, that should have been "|=" of course. I will fix it if needed
once the right approach is found and agreed upon...

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
