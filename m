From: akpm@osdl.org (Andrew Morton)
Date: Tue, 15 Nov 2005 01:41:43 +0000
Subject: [lm-sensors] Re: [PATCH 1/1] Added support of ST m41t85 rtc chip
Message-Id: <20051114164118.7270c6ce.akpm@osdl.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4378960F.8030800@varma-el.com>
In-Reply-To: <4378960F.8030800@varma-el.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrey Volkov <avolkov@varma-el.com>
Cc: khali@linux-fr.org, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

Andrey Volkov <avolkov@varma-el.com> wrote:
>
> ...
> Added support of ST M41T85 RTC
> 
> ...
>
> +ulong
> +m41t85_get_rtc_time(void)

Does this need to have global scope?

It appears to have no callers.

It is preferred that `unsigned long' be used.

Please format it this way:

unsigned long m41t85_get_rtc_time(void)


> +static void
> +m41t85_set_tlet(ulong arg)
> +{
> +	struct rtc_time	tm;
> +	ulong	nowtime = *(ulong *)arg;
> +
> +	to_tm(nowtime, &tm);
> +	tm.tm_year = (tm.tm_year - 1900) % 100;
> +
> +	tm.tm_sec = BIN2BCD(tm.tm_sec);
> +	tm.tm_min = BIN2BCD(tm.tm_min);
> +	tm.tm_hour = BIN2BCD(tm.tm_hour);
> +	tm.tm_mon = BIN2BCD(tm.tm_mon);
> +	tm.tm_mday = BIN2BCD(tm.tm_mday);
> +	tm.tm_year = BIN2BCD(tm.tm_year);
> +
> +	down(&m41t85_mutex);

Cannot do down() in a tasklet handler!  Enable CONFIG_DEBUG_PREEMPT and
CONFIG_DEBUG_SPINLOCK_SLEEP, retest.

schedule_work() might be an appropriate fix.

> +int
> +m41t85_set_rtc_time(ulong nowtime)
> +{
> +	new_time = nowtime;
> +
> +	if (in_interrupt())
> +		tasklet_schedule(&m41t85_tasklet);
> +	else
> +		m41t85_set_tlet((ulong)&new_time);
> +
> +	return 0;
> +}

hm, this function isn't referenced from within this patch either.

> +	#if defined (CONFIG_SENSORS_M41T85_SQW_FRQ)

#if's normally start in column zero.

> +		ret = i2c_smbus_write_byte_data(client, RTC_SQW_ADDR, CONFIG_SENSORS_M41T85_SQW_FRQ);

My, what large xterms you have ;)


