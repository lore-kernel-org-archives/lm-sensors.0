From: Jean Delvare <jdelvare@suse.de>
Date: Sun, 05 Jul 2015 06:57:27 +0000
Subject: Re: [lm-sensors] [PATCH v3] hwmon: (nct7802) Add pwm control
Message-Id: <20150705085727.23e25d08@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1436021854-13072-1-git-send-email-const@MakeLinux.com>
	<55982124.2070500@roeck-us.net>
In-Reply-To: <55982124.2070500@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: Constantine Shulyupin <const@MakeLinux.com>, open@suse.de, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On Sat, 04 Jul 2015 11:08:36 -0700, Guenter Roeck wrote:
> Hi Constantine,
> 
> On 07/04/2015 07:57 AM, Constantine Shulyupin wrote:
> > Added fan output control registers.
> > Modes of operation are PWM (default) and DC.
> >
> 
> Another note: Since you mention DC vs. pwm mode, have you
> considered adding pwm[123]_mode attributes to report the
> selected mode ?

If you do, please make sure these attributes are read-only.

Thanks,
-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
