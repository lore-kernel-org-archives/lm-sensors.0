From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 11 Aug 2011 16:51:12 +0000
Subject: Re: [lm-sensors] I2C Sis964 implementation
Message-Id: <1313081472.2214.77.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAPXEm70awrC7bbBqS05RaGOb9RvgYbhuec65FAJz2u9Y5Rcbcg@mail.gmail.com>
In-Reply-To: <CAPXEm70awrC7bbBqS05RaGOb9RvgYbhuec65FAJz2u9Y5Rcbcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

On Wed, 2011-08-10 at 23:38 -0400, Amaury Decrême wrote:
> Hello,
> 
> I'm new to lm_sensors.
> I've modified the original i2c Sis630 implementation by Alexander
> Malysh to support Sis964 southbridge smbus and created a second file.
> 
> 
> I can get the following result (with a dme1737):
> 
> dme1737-i2c-3-2e
> Adapter: SMBus SIS964 adapter at 10e0
> 5VSB:         +0.00 V  (min =  +0.00 V, max =  +6.64 V)
> Vcore:        +3.00 V  (min =  +0.00 V, max =  +2.99 V)
> +3.3V:        +3.32 V  (min =  +0.00 V, max =  +4.38 V)
> +5V:          +4.96 V  (min =  +0.00 V, max =  +6.64 V)
> +12V:        +11.83 V  (min =  +0.00 V, max = +15.94 V)
> 3VSB:         +3.39 V  (min =  +0.00 V, max =  +4.38 V)
> Vbat:         +3.16 V  (min =  +0.00 V, max =  +4.38 V)
> fan1:        1810 RPM  (min =    0 RPM)
> fan2:         899 RPM  (min =    0 RPM)
> fan4:           0 RPM  (min =    0 RPM)
> temp1:        +40.8°C  (low  = -127.0°C, high = +59.0°C)
> SIO Temp:     +43.8°C  (low  = -127.0°C, high = +59.0°C)
> temp3:         +0.0°C  (low  = -127.0°C, high = +127.0°C)
> cpu0_vid:    +1.550 V
> 
> pwm is also working.
> 
> 
> Please find attached my patch.
> 
> 
> Best regards.

Hi,

please have a look into Documentation/hwmon/submitting-patches.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
