From: Henrik Rydberg <rydberg@euromail.se>
Date: Fri, 05 Nov 2010 08:56:27 +0000
Subject: Re: [lm-sensors] [PATCH 6/8] hwmon: applesmc: Dynamic creation of
Message-Id: <4CD3C6BB.4010601@euromail.se>
List-Id: <lm-sensors.vger.kernel.org>
References: <1288511434-5662-1-git-send-email-rydberg@euromail.se> <1288511434-5662-7-git-send-email-rydberg@euromail.se> <20101105025933.GE28308@ericsson.com>
In-Reply-To: <20101105025933.GE28308@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: Jean Delvare <khali@linux-fr.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

>>  static int applesmc_init_smcreg_try(void)

>>  {
>>         struct applesmc_registers *s = &smcreg;
>> +       u8 tmp[4];
> 
> Why tmp[4] if you only read one byte ?


Alignment optimization, perhaps? :-) I'll change it.

Thanks,
Henrik

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
