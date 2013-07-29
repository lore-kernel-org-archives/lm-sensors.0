From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 29 Jul 2013 11:19:01 +0000
Subject: Re: [lm-sensors] Design decisions implementing an I2C LDD
Message-Id: <51F64FA5.7090603@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <CA+TH9VktNEiLHmU1WJAUG0QWPsCCXrG5O=KjynBasR5h8LhpPw@mail.gmail.com>
In-Reply-To: <CA+TH9VktNEiLHmU1WJAUG0QWPsCCXrG5O=KjynBasR5h8LhpPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 07/29/2013 03:47 AM, Angelo Compagnucci wrote:
> Hello list,
>
> I'm implementing an LDD for the MCP3422 ADC from microchip. I'm heading
> at kernel inclusion, so I'm asking here before doing it too much wrong.
>
> I'm reading Documentation/hwmon/sysfs-interface, and I find that the
> chip adhere poorly to that specification:
>
> 0) The chip has an 18bits ADC, but the unit of in0_input should be in
> mV, I don't want to waste the 18bits precision. Right now I have the
> unit in nV and it works quite well, but If I understand correctly, it's
> not right for hwmon specs.

No it isn't.

> 1) The chip provides up to 4 differential input channels, but only one
> at a time could be read after setting the corresponding channel in a
> registry. How should I manage 4 different inputs that maps the same
> device registry to be compliant?

You wouldn't. Each attribute should be associated with exactly one 
input. The code would have to multiplex to provide respective readings.

> 2) Cause the device has 4 differential inputs, it could output negative
> values. Are they permitted?

Sure, voltages can be negative.

> 3) The device has various configuration parameters (like varialbe
> 12/14/16/18bits precision, variable gain), could them be added as
> external attributes?

I don't think so.

> 4) The update_interval depends on the precion (device is faster with
> less precision), could it be updated at runtime if user changes precision?
>
Yes, but ...

Have you considered writing an iio driver instead ? That might be more 
appropriate given the more likely use of this chip for generic ADC, not 
for hardware monitoring. If it is used for hardware monitoring, the 
iio/hwmon bridge driver could be used.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
