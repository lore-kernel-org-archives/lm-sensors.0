From: "Andrew Paprocki" <andrew@ishiboo.com>
Date: Mon, 07 Jul 2008 11:36:43 +0000
Subject: Re: [lm-sensors] [PATCH 2/4] hwmon: it87 only create pwm1-3 sysfs
Message-Id: <76366b180807070436v1b9ec3cfu9984ecfbac979eac@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1215427211-6001-2-git-send-email-andrew@ishiboo.com>
In-Reply-To: <1215427211-6001-2-git-send-email-andrew@ishiboo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Ah ok, for the pwm1_freq. I suppose this can be left out entirely, or
should pwm1* always exist? It just seemed wrong to make pwm4/5 show up
when needed but not the others.

-Andrew

On Mon, Jul 7, 2008 at 7:25 AM, Jean Delvare <khali@linux-fr.org> wrote:
> On Mon,  7 Jul 2008 06:40:09 -0400, Andrew Paprocki wrote:
>> This patch only creates the pwmN_enable, pwmN, and pwmN_freq
>> sysfs interface files if the corresponding fanN is enabled by
>> the chip.
>
> Nack. PWM1 may control fan2, etc.
>
> --
> Jean Delvare
>
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
