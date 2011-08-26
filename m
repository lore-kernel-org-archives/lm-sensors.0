From: Donggeun Kim <dg77.kim@samsung.com>
Date: Fri, 26 Aug 2011 02:20:05 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Add driver for EXYNOS4 TMU
Message-Id: <4E5702D5.6080200@samsung.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1314260034-10358-1-git-send-email-dg77.kim@samsung.com>
In-Reply-To: <1314260034-10358-1-git-send-email-dg77.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

On 2011년 08월 26일 01:26, Guenter Roeck wrote:
> On Thu, 2011-08-25 at 04:13 -0400, Donggeun Kim wrote:
>> +static void exynos4_tmu_initialize(struct platform_device *pdev)
>> +{
>> +       struct exynos4_tmu_data *data = platform_get_drvdata(pdev);
>> +       struct exynos4_tmu_platform_data *pdata = data->pdata;
>> +       unsigned int status, trim_info, interrupt_en;
>> +       u8 threshold_code;
>> +
>> +       clk_enable(data->clk);
>> +
>> +       status = readb(data->base + EXYNOS4_TMU_REG_STATUS);
>> +       if (!status) {
>> +               printk(KERN_INFO "TMU is busy\n");
> 
> Please use dev_info(&pdev->dev, ...);
> 
>> +               clk_disable(data->clk);
>> +               return;
> 
> Are you sure it is a good idea to ignore this error ? Limits won't be
> set, threshold won't be set, trigger levels won't be set. In other
> words, the chip is left in a completely uninitialized and thus
> unpredictable state.
> 
> It might be better to abort driver initialization if this happens.
> 
I should have handled this as a error. I will fix it.

>> +static int exynos4_tmu_read(struct exynos4_tmu_data *data, u8 *temp)
>> +{
>> +       u8 temp_code;
>> +
>> +       clk_enable(data->clk);
>> +
>> +       temp_code = readb(data->base + EXYNOS4_TMU_REG_CURRENT_TEMP);
>> +       if (!temp_code) {
>> +               dev_err(data->hwmon_dev, "Failed to read temperature code\n");
> 
> dev_err and EAGAIN ? Is this really necessary ? EAGAIN will result in a
> retry; if the condition is permanent you'll fill the log pretty quickly.
> 
Okay, it would be better to change the error code.

Thanks for your review.



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
