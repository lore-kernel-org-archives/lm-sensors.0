From: Curt Brune <curt@cumulusnetworks.com>
Date: Thu, 04 Dec 2014 00:18:45 +0000
Subject: Re: [lm-sensors] adt7475 driver: PWM invert configuration bit
Message-Id: <20141204001845.GI23773@cumulusnetworks.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20141203041242.GD11971@cumulusnetworks.com>
In-Reply-To: <20141203041242.GD11971@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Guenter,

On Tue Dec 02 21:29, Guenter Roeck wrote:
> 
> This is usually a system attribute, not something to configure at
> runtime. As such, expectation would be that it is set either with
> platform data and/or with a devicetree property, not with a sysfs
> attribute.
> 

Thanks for the input.  I will consider the platform data and/or
devicetree property approach.

Cheers,
Curt

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
