From: Stephen Warren <swarren@wwwdotorg.org>
Date: Thu, 18 Jul 2013 17:18:05 +0000
Subject: Re: [lm-sensors] [RESEND PATCH V1 0/9] thermal: introduce DT thermal zone build
Message-Id: <51E8234D.1020607@wwwdotorg.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1374074248-31690-1-git-send-email-eduardo.valentin@ti.com> <20130717220942.GB990@roeck-us.net> <51E7F341.8020508@ti.com>
In-Reply-To: <51E7F341.8020508@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, devicetree-discuss@lists.ozlabs.org, wni@nvidia.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, l.stach@pengutronix.de

On 07/18/2013 07:53 AM, Eduardo Valentin wrote:
> Hello Guenter,
> 
> On 17-07-2013 18:09, Guenter Roeck wrote:
>> On Wed, Jul 17, 2013 at 11:17:19AM -0400, Eduardo Valentin
>> wrote:
>>> Hello all,
>>> 
>>> As you noticed, I am working in a way to represent thermal
>>> data using device tree [1]. Essentially, this should be a way
>>> to say what to do with a sensor and how to associate (cooling)
>>> actions with it.
>>> 
>> Seems to me that goes way beyond the supposed scope of devicetree
>> data. Devicetree data is supposed to describe hardware, not its
>> configuration or use. This is clearly a use case.
> 
> Thanks for rising your voice here. It is important to know what
> hwmon ppl think about this.

I meant to find time to read Guenter's original email where he
initially objected to putting data into DT, and determine exactly what
was being objected to. I still haven't:-( However, the arguments that
Eduardo stated in his email do make sense to me; I agree that
temperature limits really are a description of HW. Details of which
cooling methods to invoke when certain temperature limits are reached
is also part of the HW/system design, and hence I would tend to agree
that they're appropriate to include in DT. Anyway, that's just my 2
cents on the matter:-)

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
