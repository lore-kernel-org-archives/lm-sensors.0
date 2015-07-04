From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 04 Jul 2015 18:08:36 +0000
Subject: Re: [lm-sensors] [PATCH v3] hwmon: (nct7802) Add pwm control
Message-Id: <55982124.2070500@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1436021854-13072-1-git-send-email-const@MakeLinux.com>
In-Reply-To: <1436021854-13072-1-git-send-email-const@MakeLinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Constantine,

On 07/04/2015 07:57 AM, Constantine Shulyupin wrote:
> Added fan output control registers.
> Modes of operation are PWM (default) and DC.
>

Another note: Since you mention DC vs. pwm mode, have you
considered adding pwm[123]_mode attributes to report the
selected mode ?

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
