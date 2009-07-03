From: Hans de Goede <hdegoede@redhat.com>
Date: Fri, 03 Jul 2009 17:25:49 +0000
Subject: Re: [lm-sensors] no PWM output with pwmconfig
Message-Id: <4A4E3F1D.6000405@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4A4B9B3C.1040104@chello.nl>
In-Reply-To: <4A4B9B3C.1040104@chello.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

On 07/03/2009 04:54 PM, Jean Delvare wrote:
> On Fri, 03 Jul 2009 16:35:57 +0200, Hans de Goede wrote:
>> On 07/03/2009 04:27 PM, Jean Delvare wrote:
>>> I admit the current configuration is a little odd. Usually point2 has
>>> pwm and temperature values above point1, not below. I am not familiar
>>> with the Fintek F71862FG and its driver though. Hans?
>> Yes, erm well the F718xx family has them in reverse order in hardware and
>> I kept the hardware order for sysfs files. A bit strange I must admit.
>>
>> In hindsight it might have been better to reverse the order in sysfs
>> for consistency with other drivers.
>
> I agree. It shouldn't be too difficult, and even though we can't easily
> get a fully consistent interface for automatic speed mode due to each
> chip being different in its own creative way, being as consistent as we
> can makes things easier for the users.
>

Yes, but do we want to change this now, after the fact, that would
basically come down to ABI breakage.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
