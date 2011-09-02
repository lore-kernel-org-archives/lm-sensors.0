From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 02 Sep 2011 13:54:40 +0000
Subject: Re: [lm-sensors] [PATCH v5] hwmon: Add driver for EXYNOS4 TMU
Message-Id: <20110902135440.GA30543@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1314955144-18168-1-git-send-email-dg77.kim@samsung.com>
In-Reply-To: <1314955144-18168-1-git-send-email-dg77.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Sep 02, 2011 at 05:19:04AM -0400, Donggeun Kim wrote:
> This patch allows to read temperature
> from TMU(Thermal Management Unit) of SAMSUNG EXYNOS4 series of SoC.
> 
> Signed-off-by: Donggeun Kim <dg77.kim@samsung.com>
> Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

[ ... ]

> +
> +struct exynos4_tmu_data {
> +       struct exynos4_tmu_platform_data *pdata;
> +       struct device *hwmon_dev;
> +       struct resource *mem;
> +       void __iomem *base;
> +       int irq;
> +       struct work_struct irq_work;
> +       struct mutex lock;
> +       struct clk *clk;
> +       unsigned int interrupt_stat;

	I just noticed that this variable is only set and used in one function,
	so you can keep it as local variable there.

> +       u8 temp_error1, temp_error2;
> +};

[ ... ]

> +
> +static int exynos4_tmu_read(struct exynos4_tmu_data *data)
> +{
> +       u8 temp_code, temp;
> +
> +       mutex_lock(&data->lock);
> +       clk_enable(data->clk);
> +
> +       temp_code = readb(data->base + EXYNOS4_TMU_REG_CURRENT_TEMP);
> +       temp = code_to_temp(data, temp_code);

temp is now an u8, so assigning a negative error to it won't do much good.

> +
> +       clk_disable(data->clk);
> +       mutex_unlock(&data->lock);
> +
> +       return temp;
> +}
> +

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
