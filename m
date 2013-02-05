From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 05 Feb 2013 09:18:01 +0000
Subject: Re: [lm-sensors] i2c-i801 on AppleTV (1st gen)
Message-Id: <20130205101801.154bbe84@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <alpine.LRH.2.02.1302050844220.2736@pikachu.3ti.be>
In-Reply-To: <alpine.LRH.2.02.1302050844220.2736@pikachu.3ti.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 5 Feb 2013 10:08:49 +0100 (CET), Dag Wieers wrote:
> For the OpenELEC project I am looking into enabling the i2c-i801 interface 
> for getting more system information (voltage, temperature, fan).
> 
> The AppleTV (1st Gen) has a N10/ICH 7 Family SMBus Controller (8086:27da) 
> device that is supported by i2c-i801, but I haven't been able to get 
> anything to work apart from loading the driver.
> 
>    00:1f.3 SMBus: Intel Corporation N10/ICH 7 Family SMBus Controller (rev 02)
>            Subsystem: Intel Corporation Device 7270
>            Flags: medium devsel, IRQ 19
>            I/O ports at efa0 [size2]
>            Kernel driver in use: i801_smbus
>            Kernel modules: i2c-i801

This looks good.

> (Lacking perl, I haven't been able to get sensors-detect working yet. We 
> will have to add perl to the OpenELEC buildsystem for this)
> 
> I tried loading all sensors from kernel 3.7.5, to no avail.

This is pretty risky, I wouldn't do that.

> Is there something I can do to test whether the i2c SMBus is at all 
> functional ?

Install i2c-tools [1] and try i2cdetect.

[1] http://www.lm-sensors.org/wiki/I2CTools

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
