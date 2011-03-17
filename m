From: Hans de Goede <hdegoede@redhat.com>
Date: Thu, 17 Mar 2011 11:28:51 +0000
Subject: Re: [lm-sensors] Call for 3.3.0
Message-Id: <4D81F073.1020908@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110316224142.0493f53b@endymion.delvare>
In-Reply-To: <20110316224142.0493f53b@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

On 03/17/2011 10:59 AM, Jean Delvare wrote:
> On Thu, 17 Mar 2011 09:26:57 +0100, Hans de Goede wrote:
>> Hi,
>>
>> On 03/16/2011 10:41 PM, Jean Delvare wrote:
>>> Hi all,
>>>
>>> Last release of lm-sensors (3.2.0) was in October 2010, 5 months ago.
>>> The list of changes since then is getting large, so it's time for a new
>>> release. The changes are important enough that I would go for 3.3.0
>>> rather than 3.2.1 as originally planned.
>>>
>>> This decision is motivated by the long list of new attributes and even
>>> new sensor types handled by libsensors and sensors. Other changes worth
>>> mentioning are Guenter's generic code to display limit values in
>>> "sensors", the removal of some arbitrary limits in libsensors attribute
>>> enumeration code, and the usual addition of many new devices to
>>> sensors-detect.
>>>
>>> The planned schedule is as follows:
>>> * Saturday, March 19th, 2011: SVN freeze
>>
>> I have not been able to make time yet to add detection of the new
>> models handled by f71882fg, in as far as they are not already
>> present (some probably are haven't checked). I think it would be
>> good to have this in place before 3.3.0. Note I cannot test
>> these changes, so they might as well be done by someone else
>> (hint hint).
>
> Hint received. Here's the patch I have come up with:
>

Looks good, thanks.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
