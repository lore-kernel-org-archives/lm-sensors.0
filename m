From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 05 Jul 2015 13:00:29 +0000
Subject: Re: [lm-sensors] [PATCH v3] hwmon: (nct7802) Add pwm control
Message-Id: <55992A6D.6010506@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1436021854-13072-1-git-send-email-const@MakeLinux.com>	<55982124.2070500@roeck-us.net> <20150705085727.23e25d08@endymion.delvare>
In-Reply-To: <20150705085727.23e25d08@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <jdelvare@suse.de>
Cc: Constantine Shulyupin <const@MakeLinux.com>, open@suse.de, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On 07/04/2015 11:57 PM, Jean Delvare wrote:
> On Sat, 04 Jul 2015 11:08:36 -0700, Guenter Roeck wrote:
>> Hi Constantine,
>>
>> On 07/04/2015 07:57 AM, Constantine Shulyupin wrote:
>>> Added fan output control registers.
>>> Modes of operation are PWM (default) and DC.
>>>
>>
>> Another note: Since you mention DC vs. pwm mode, have you
>> considered adding pwm[123]_mode attributes to report the
>> selected mode ?
>
> If you do, please make sure these attributes are read-only.
>

They are.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
