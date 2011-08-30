From: Donggeun Kim <dg77.kim@samsung.com>
Date: Tue, 30 Aug 2011 10:59:25 +0000
Subject: Re: [lm-sensors] [PATCH v3] hwmon: Add driver for EXYNOS4 TMU
Message-Id: <4E5CC28D.4050900@samsung.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1314613983-3331-1-git-send-email-dg77.kim@samsung.com>
In-Reply-To: <1314613983-3331-1-git-send-email-dg77.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

On 2011년 08월 30일 19:46, Donggeun Kim wrote:
> On 2011년 08월 29일 21:22, R, Durgadoss wrote:
> The read function returns error code (-ENODATA) for abnormal case.
> So, the return type should be 'int'.
>>> +static irqreturn_t exynos4_tmu_irq(int irq, void *id)
>>> +{
>>> +	struct exynos4_tmu_data *data = id;
>>
>> I am not sure whether we _must_ cast 'id', as (struct exynos4_tmu_data *)..
>>  
> In exynos4_tmu_irq function, 'irq_work' field in 'exynos4_tmu_data' is
> accessed. Thus, it should be casted.
The last sentence is 'Thus, it should not be casted'.
It was my mistake.



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
