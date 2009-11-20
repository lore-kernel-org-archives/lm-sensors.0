From: Serge Belyshev <belyshev@depni.sinp.msu.ru>
Date: Fri, 20 Nov 2009 10:22:50 +0000
Subject: Re: [lm-sensors] [PATCH] k10temp: temperature sensor for AMD Family
Message-Id: <87ws1l5wcl.fsf@depni.sinp.msu.ru>
List-Id: <lm-sensors.vger.kernel.org>
References: <4AF91F70.10106@ladisch.de> <4B06501B.8080509@ladisch.de>
In-Reply-To: <4B06501B.8080509@ladisch.de> (Clemens Ladisch's message of "Fri,
	20 Nov 2009 09:15:23 +0100")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org


> +All these processors have a sensor, but on older revisions of Family 10h
> +processors, the sensor returns inconsistent values (erratum 319). The driver
> +refuses to load with these revisions (DR-BA, DR-B2, DR-B3: some Embedded
> +Opterons on Socket F; and Quad-Core Opteron, Phenom Triple/Quad-Core, and
> +Athon Dual-Core on Socket AM2+). All later revisions (RB-C2, BL-C2, DA-C2,
> +RB-C3, HY-D0) work fine; see the list above.

Please note that erratum actually states that the sensor only "may report
inconsistent values.", not that it is always broken.  As evident by my
own experience (tested with a userspace application), it actually works
perfectly on all B3 stepping processors that I have.

> +static bool __devinit has_erratum_319(void)
> +{
> +	/*
> +	 * Erratum 319: The thermal sensor of older Family 10h processors
> +	 *              (B steppings) is unreliable.
> +	 */
> +	return boot_cpu_data.x86 = 0x10 && boot_cpu_data.x86_model <= 2;
> +}
...
> +	if (has_erratum_319()) {
> +		dev_err(&pdev->dev,
> +			"unreliable CPU thermal sensor; monitoring disabled\n");
> +		err = -ENODEV;
> +		goto exit;
> +	}

So, please provide an alternative for those who have a working sensor on a
revision B processor and want to use it.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
