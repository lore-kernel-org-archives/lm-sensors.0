From: yani.ioannou@gmail.com (Yani Ioannou)
Date: Fri, 03 Jun 2005 20:20:02 +0000
Subject: [lm-sensors] [PATCH 2.6.12-rc4] PCA9539 - new driver
Message-Id: <2538186705060311197d67962d@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <F06EB2894F3F0D45AD9BEA7246DE9C906F50EC@WCSEXCMBS1.ad.wabtec.com>
In-Reply-To: <F06EB2894F3F0D45AD9BEA7246DE9C906F50EC@WCSEXCMBS1.ad.wabtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ben

> Please fix the driver so it works with -mm- kernels and maybe also the alphabetical issue.

Well (and this goes for your all your other -mm submissions too),
don't just fix it so it works with mm, fix it to take advantage of why
the changes (specifically dynamic sysfs callbacks) are there in the
first place.

> +#define store_data(enum_name)                                                \
> +static ssize_t store_##enum_name(struct device *dev, const char *buf, size_t count) \
and here too.
> +{                                                                    \
> +     pca9539_store_reg(dev, buf, enum_name);                         \
> +     return count;                                                   \
> +}

Things like this are exactly what the change is supposed to rid us of,
please see the previous discussion and example patches in this thread:

http://lkml.org/lkml/2005/5/17/75

Thanks,
Yani
