From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:28 +0000
Subject: "Can't access procfs/sysfs file", but all seems ok ??
Message-Id: <20041228161502.26c53d4e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <5799c4e904122605035c3fde7a@mail.gmail.com>
In-Reply-To: <5799c4e904122605035c3fde7a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Side notes:

> I compiled and installed the the latest lm_sensors, enabled i2c in my
> kernel an compiled it but it doesn't work. I have i2c 2.8.8 and sysfs
> and procfs support compiled in my kernel. The only thing i see wrong i
> when i boot intro linux (Mandrake 9.1) the first thing i see are i2c
> error messages.

You hopefully don't have i2c 2.8.8, since you are running a 2.6 kernel
and i2c 2.8.x is meant for 2.4 kernels.

> CONFIG_I2C_PARPORT=y
> CONFIG_I2C_PARPORT_LIGHT=y
> (...)
> CONFIG_I2C_PCA_ISA=y

Don't do that. I guess you do not need these drivers, and since the
devices they were written for can only hardly be detected, you are
asking for trouble by embedding them in the kernel.

> [root@nitro lm_sensors-2.8.8]# grep 'SENSOR' /usr/src/linux/.config
> CONFIG_I2C_SENSOR=y
> CONFIG_SENSORS_ADM1021=y
> CONFIG_SENSORS_ADM1025=y
> CONFIG_SENSORS_ADM1031=y
> CONFIG_SENSORS_ASB100=y
> CONFIG_SENSORS_DS1621=y
> CONFIG_SENSORS_FSCHER=y
> CONFIG_SENSORS_GL518SM=y
> CONFIG_SENSORS_IT87=y
> CONFIG_SENSORS_LM75=y
> CONFIG_SENSORS_LM77=y
> CONFIG_SENSORS_LM78=y
> CONFIG_SENSORS_LM80=y
> CONFIG_SENSORS_LM83=y
> CONFIG_SENSORS_LM85=y
> CONFIG_SENSORS_LM90=y
> CONFIG_SENSORS_MAX1619=y
> CONFIG_SENSORS_SMSC47M1=y
> CONFIG_SENSORS_VIA686A=y
> CONFIG_SENSORS_W83781D=y
> CONFIG_SENSORS_W83L785TS=y
> CONFIG_SENSORS_W83627HF=y
> CONFIG_SENSORS_EEPROM=y
> CONFIG_SENSORS_PCF8574=y
> CONFIG_SENSORS_PCF8591=y
> CONFIG_SENSORS_RTC8564=y

Same here. You certainly don't have all these, but the probings for i2c
devices are slow and not always reliable. Make these modules, don't
include them in the kernel. Removing all these drivers from the kernel
will significantly speed up boot.

> [root@nitro lm_sensors-2.8.8]# vi /boot/log/messages
> "Dec 26 13:43:46 nitro kernel: i2c /dev entries driver
> Dec 26 13:43:46 nitro kernel: i2c-parport: using default base 0x378
> Dec 26 13:43:46 nitro kernel: i2c-pca-isa: i/o base 0x000330. irq 10
> Dec 26 13:43:46 nitro kernel: i2c-algo-pca: bus is not idle. status is
> 0xff Dec 26 13:43:46 nitro last message repeated 11 times" (this is
> the first thing i see when booting)

These errors are because of CONFIG_I2C_PARPORT=y and
CONFIG_I2C_PCA_ISA=y above. Make them n or m and the errors will go
away.

-- 
Jean Delvare
http://khali.linux-fr.org/
