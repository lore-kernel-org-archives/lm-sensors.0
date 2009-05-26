From: Ben Dooks <ben@simtec.co.uk>
Date: Tue, 26 May 2009 21:25:15 +0000
Subject: Re: [lm-sensors] HWMON: S3C24XX series ADC driver
Message-Id: <4A1C5E3B.1050500@simtec.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090520215029.692678819@fluff.org.uk>
In-Reply-To: <20090520215029.692678819@fluff.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hector Oron wrote:
> Hi,
> 
> 2009/5/26 Ben Dooks <ben@simtec.co.uk>:
>> +       /* Register with the core ADC driver. */
>> +
>> +       hwmon->client = s3c_adc_register(dev, NULL, s3c_hwmon_adcdone, 0);
> 
> I have been trying out this code and when compiling I get a warning,
> 
>   CC [M]  drivers/hwmon/s3c-adc.o
> drivers/hwmon/s3c-adc.c: In function 's3c_hwmon_probe':
> drivers/hwmon/s3c-adc.c:275: warning: passing argument 3 of
> 's3c_adc_register' from
> er type
> 
> s3c_hwmon_adcdone is a callback function and register function is
> expecting something like "void (*conv)(unsigned d0, unsigned d1)"

by the time it is merged, it'll be expecting a third argument
to be passed.

-- 
Ben Dooks, Software Engineer, Simtec Electronics

http://www.simtec.co.uk/

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
