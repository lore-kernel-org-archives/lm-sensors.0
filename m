From: Wei Ni <wni@nvidia.com>
Date: Wed, 17 Jul 2013 07:09:43 +0000
Subject: Re: [lm-sensors] [PATCH v3 2/4] hwmon: (lm90) use macro defines for the status bit
Message-Id: <51E64337.6040004@nvidia.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1373615287-18502-1-git-send-email-wni@nvidia.com> <1373615287-18502-3-git-send-email-wni@nvidia.com> <20130715185727.4ebde8c4@endymion.delvare> <51E641C7.4000107@nvidia.com>
In-Reply-To: <51E641C7.4000107@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Guenter Roeck <linux@roeck-us.net>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>

On 07/17/2013 03:03 PM, Wei Ni wrote:
> On 07/16/2013 12:57 AM, Jean Delvare wrote:
>> Hi Wei, Guenter,
>>
>>> +
>>> +	if ((status & 0x7f) = 0 && (status2 & 0xfe) = 0)
>>> +		return false;
>>
>> It's a bit disappointing to not use the freshly introduced constants.
>> That being said I agree it would make the code hard to read, so you can
>> leave it as is.
> 
> Sorry, I forgot it.
> How about to define:
> #define LM90_STATUS_MASK 0x7f
> #define MAX6696_STATUS2 0xfe

Sorry, it should be "#define MAX6696_STATUS2_MASK 0xfe".

> 
> Or since Guenter is for vacation, I can just leave it as is, and wait
> him back to talk about below issue.
> 
>>
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
