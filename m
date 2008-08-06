From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Wed, 06 Aug 2008 08:30:52 +0000
Subject: Re: [lm-sensors] [PATCH 3/4] hwmon: (w83791d) add pwm_enable support
Message-Id: <4899613C.70405@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <200808060029.41402.m.hulsman@tudelft.nl>
In-Reply-To: <200808060029.41402.m.hulsman@tudelft.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Marc Hulsman wrote:
>> And here you store the register val + 1 again, making show_pwmenable
>> actually show the less value, unless pwm#_enable is read very quickly after
>> a write, in which case w83791d_update won't do anything and the shown
>> pwm_enable value will be one to small.
>>
>> I think it would be best to consistently store the val as seen by userspace
>> - 1 (iow the actual reg val) in pwm_enable (as you do in store_pwmenable)
>> and then add the + 1 when showing it.
> 
> Thanks for spotting that one, I should have seen it. Hereby a new version of 
> the patch:
> 
> ---
> Add support for pwm_enable.
> 
> Signed-off-by: Marc Hulsman <m.hulsman@tudelft.nl> 
> 

Looks good now:
Acked-by: Hans de Goede <j.w.r.degoede@hhs.nl>

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
