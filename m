From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Thu, 25 Jun 2009 17:04:12 +0000
Subject: Re: [lm-sensors] [RFC] LM75 add regulator support
Message-Id: <19F003B3-C906-4630-AEB9-C070BDECD9D9@opensource.wolfsonmicro.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4A43A1CC.2040701@cam.ac.uk>
In-Reply-To: <4A43A1CC.2040701@cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 25 Jun 2009, at 17:11, Jonathan Cameron <jic23@cam.ac.uk> wrote:

>
> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
>
> ---
> Data sheet trawling has established that, of the devices listed by
> this driver, there are two voltage ranges. (2.7-5.5 or 3-5.5)

You shouldn't need to have the driver request the voltage range it  
needs like this - the machine constraints should deal with that. In  
general you should only actively manage the voltage in a consumer if  
you need to change voltages dynamically.

Doing this would also mean that the driver would be able to use the  
stub consumer API that is provided when regulator support is disabled.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
