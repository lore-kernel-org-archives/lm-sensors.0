From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Sun, 08 Jul 2007 18:06:10 +0000
Subject: Re: [lm-sensors] PATCH: hwmon-abituguru-check-dmi-vendor.patch
Message-Id: <46912792.7020708@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <4690D52A.7040402@hhs.nl>
In-Reply-To: <4690D52A.7040402@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Mark M. Hoffman wrote:
> Hi Hans:
> 
> * Hans de Goede <j.w.r.degoede@hhs.nl> [2007-07-08 14:14:34 +0200]:
>> Hi all,
>>
>> With this patch the abituguru refuses to load on non Abit motherboards, as
>> discussed in lkml CONFIG_BREAK_MY_MACHINE thread.
>>
>> Signed-off-by: Hans de Goede <j.w.r.degoede@hhs.nl>
>>
>> Regards,
>>
>> Hans
> 
>> With this patch the abituguru refuses to load on non Abit motherboards, as 
>> discussed in lkml CONFIG_BREAK_MY_MACHINE thread.
>>
>> Signed-off-by: Hans de Goede <j.w.r.degoede@hhs.nl>
> 
> That thread worries me a bit.  Should this get in before 2.6.22?

No 2.6.23 is fine. No worries, they should have named the thread 
CONFIG_SHOOT_MYSELF_IN_THE_FOOT. This patch is just a layer of security to 
prevent people doing stupid things. I only wrote the patch because some people 
thought it would be a good idea to prevent people from doing stupid things with 
regards to medling with the kernel, however when you enter into that realm 
there is really no end of stupid things one can do, so I wonder how wise it is 
to try and protect people against themselves.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
