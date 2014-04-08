From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 08 Apr 2014 13:50:44 +0000
Subject: Re: [lm-sensors] Ina219 with linux kernel driver
Message-Id: <5343FEB4.6090808@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAK=2HV2_fnfPcK41i2fnAsgR7BMruKq1XB846Tt87wgmBP=NXA@mail.gmail.com>
In-Reply-To: <CAK=2HV2_fnfPcK41i2fnAsgR7BMruKq1XB846Tt87wgmBP=NXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 04/08/2014 06:29 AM, Pierre Kancir wrote:
> Hi,
>
> I am trying to use ina219 sensor (http://www.adafruit.com/products/904)
> with linux kernel driver on beaglebone black.
>
> I want to use device tree overlay to use the sensor. I follow kernel
> indications (
> http://lxr.free-electrons.com/source/Documentation/devicetree/bindings/i2c/ina2xx.txt)
> and the sensor works as expected.
>
> But adafruit board use 0.1ohms and default driver value for shunt-resistor
> is 10mOhms so return value are wrong.
>
> I want to modify value in device tree as indicated
>
> ina219@40 {
>            compatible = "ti,ina219";
>            reg = <0x40>;
>            shunt-resistor = <100000>;
>   };
>
> but changing shunt-resistor value does nothing. The sensor is always create
> with 10mOhms value
>
> ina2xx 1-0040: power monitor ina219 (Rshunt = 10000 uOhm)
>
> How can i change the shunt-resistor value to get the proper return?
>

Good question. This functionality was added mid-2013. What is your kernel version ?

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
