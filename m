From: Hans de Goede <hdegoede@redhat.com>
Date: Wed, 28 Oct 2009 08:54:51 +0000
Subject: Re: [lm-sensors] [PATCH 1/4] hwmon-f71882fg: Cleanup sysfs attr
Message-Id: <4AE806DB.3070100@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4AE02EFB.9090309@redhat.com>
In-Reply-To: <4AE02EFB.9090309@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

Thanks for the review!

On 10/28/2009 09:39 AM, Jean Delvare wrote:
> Hi Hans,
>
> On Thu, 22 Oct 2009 12:07:55 +0200, Hans de Goede wrote:
>> hwmon-f71882fg: Cleanup sysfs attr creation 1/2
>>
>> This patch makes a number of cleanups to the sysfs attr creation
>> in the f71882fg driver, this is a preparation patch for adding f71889fg
>> support:
>>
>> * Add some comments to explain why some models need separate sysfs attr
>>    arrays for in / temp / fan / pwm
>> * Rename a number of sysfs attr arrays to make their function clearer
>> * Move the pwm#_auto_channels_temp attribute from the common to all
>>    models fan attr array to the per model auto mode pwm attr arrays, so
>>    that all the auto mode pwm attr are grouped together, and thus can be
>>    left out on models where we don't support auto pwm mode
>> * Put fan_beep attr in their own array, so that only auto mode pwm attr
>>    remain in the per model pwm sysfs attr arrays.
>> * Put the 4th special fan input for the f8000 in its own array, so that only
>>    auto mode pwm attr remain in the per model pwm sysfs attr arrays.
>
> Only minor comments (which I may fix myself if you have no objections):
>

I agree with all comments and I've no objections with you fixing them yourself.

Thanks & Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
