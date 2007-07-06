From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Fri, 06 Jul 2007 10:12:06 +0000
Subject: Re: [lm-sensors] [PATCH] THMC50 support for 2.6 (2nd revision)
Message-Id: <468E1576.9030703@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070702195448.2814dfb7.krzysztof.h1@wp.pl>
In-Reply-To: <20070702195448.2814dfb7.krzysztof.h1@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Krzysztof,
> 
>>> What about user-space support? Looking at the libsensors/sensors code,
>>> I see that at least the 3rd temperature sensor of the ADM1022 is not
>>> supported in libsensors. And support is entirely missing from sensors?
>>> Do you have a patch to add support? At least the code in the
>>> lm-sensors-3.0.0 branch should support it right away.
>> It works with sensors3 and after addition to the sensors.conf it works with the AP550
>> MB (motherboard).
> 
> Don't you want to submit support for lm-sensor 2.10.x too? We have no
> clear idea when lm-sensors 3.0.0 will be released.
> 

I know writing support for 2.10.x is not a fun job (see my grumpy mails about 
this a couple of days ago). But I think we will be stuck with 2.10.x for a 
while to come. So it would be best if you could write 2.10.x support soon, 
preferably before the july 8th deadline for the 2.10.4 release svn freeze. That 
way by the time your driver gets into the kernel, people will hopefully also 
have a libsensors + sensors supporting it.

Regards,

Hans


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
