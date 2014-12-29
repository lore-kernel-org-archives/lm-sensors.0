From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 29 Dec 2014 12:52:45 +0000
Subject: Re: [lm-sensors] [PATCH v2 6/8] hwmon: thermal: Extract __set_pwm() function to only modify PWM duty
Message-Id: <20141229125245.GB18083@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1418897591-18332-1-git-send-email-l.majewski@samsung.com>
 <1419265668-32283-1-git-send-email-l.majewski@samsung.com>
 <1419265668-32283-7-git-send-email-l.majewski@samsung.com>
In-Reply-To: <1419265668-32283-7-git-send-email-l.majewski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, Kamil Debski <k.debski@samsung.com>, Jean Delvare <jdelvare@suse.de>, lm-sensors@lm-sensors.org, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, devicetree@vger.kernel.org, Lukasz Majewski <l.majewski@majess.pl>, Kukjin Kim <kgene.kim@samsung.com>, linux-kernel@vger.kernel.org, Sylwester Nawrocki <s.nawrocki@samsung.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>

On Mon, Dec 22, 2014 at 05:27:46PM +0100, Lukasz Majewski wrote:
> It was necessary to decouple code handling writing to sysfs from the one
> responsible for setting PWM of the fan.
> Due to that, new __set_pwm() method was extracted, which is responsible for
> only setting new PWM duty cycle.
> 
> Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
> ---

Please provide the affected subsystem and the affected driver in the header.
While it may make sense to explain that the patch is to prepare the driver for
thermal use, this should be part of the descriptive text. The patch is,
however, not not a thermal subsystem related patch. The 'thermal:' in the
headline is thus misleading, and you should drop it.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
