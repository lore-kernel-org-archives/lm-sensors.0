From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Wed, 31 Oct 2007 15:29:44 +0000
Subject: Re: [lm-sensors]
Message-Id: <47289F68.8010800@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <87ekb9s3tn.wl%info@wore.ma.cx>
In-Reply-To: <87ekb9s3tn.wl%info@wore.ma.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> On Wed, 31 Oct 2007 09:42:38 +0100, Hans de Goede wrote:
>> Hi All,
>>
>> As discussed on the lm-sensors list, using the fixed scaling factors from the
>> fscpos datasheet for the fscher and newer models as wel, was nood a good idea,
>> as the actual scaling factors may be different and can be read from OEM DMI
>> entries.
>>
>> This patch changes the behaviour of the merged FSC familiy fschmd driver to be
>> the same as the old standalone fscher driver for fscher and newer models,
>> leaving the scaling to userspace.
>>
>> This also preserves compatibility of existing sensors.conf files.
>>
>> Signed-of-by: Hans de Goede <j.w.r.degoede@hhs.nl>
>>
>> ---
>>
>> Jean, can you review this please?
>> Mark, can you send this to Linus for 2.6.24 please, otherwise we will have one 
>> official kernel release with different scaling for the voltage inputs of the 
>> fschmd compared to the next releases.
>>
>>
>> And yes I tested my patch this time.
> 
> Assuming that you definitely excluded the possibility to retrieve the
> DMI data from the kernel

Definitely is a big word, I've looked at the DMI parser currently in the 
kernel, tried to come up with a way to get the info there which would be more 
generic then just being an fschmd specific hack and couldn't. Then I slept a 
night on it and still couldn't come up with something clean, esp since there 
are many type 185 entries in the DMI table of FSC machines, of which we need 
only one.

> and you have additional information about the
> Heimdall and Heracles also using DMI data for the scaling
That indeed has been ackknowledge by my Siemens contact.

Regards,

Hans


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
