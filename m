From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 28 Nov 2013 05:10:00 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon: (fam15h_power) use DEFINE_PCI_DEVICE_TABLE macro
Message-Id: <5296D028.5050405@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <001701ceebdf$f0f70d00$d2e52700$%han@samsung.com>
In-Reply-To: <001701ceebdf$f0f70d00$d2e52700$%han@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 11/27/2013 08:33 PM, Jingoo Han wrote:
> On Thursday, November 28, 2013 12:03 PM, Guenter Roeck wrote:
>> On 11/27/2013 06:17 PM, Jingoo Han wrote:
>>> This macro is used to create a struct pci_device_id array.
>>>
>>> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
>>> ---
>>
>> Applied to -next.
>
> Please, drop these patches.
> According to the Greg Kroah-Hartman,
>
> "Yeah, and it's a horrid macro that deserves to be removed, please don't
> use it in more places.
>
> Actually, if you could just remove it, that would be best, sorry, I'm
> not going to take these patches."
>
> So, I will send the patch to remove 'DEFINE_PCI_DEVICE_TABLE' instead.
> Sorry for annoying. :-)
>

Ok, I'll drop the patches. I hope Greg's statement is the "final" word from
senior maintainers, though - I don't want to have to go back and forth with this.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
