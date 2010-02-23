From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Tue, 23 Feb 2010 09:04:26 +0000
Subject: Re: [lm-sensors] reformat: [PATCH] hwmon: Driver for Andigilog
Message-Id: <4B839A1A.6060007@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <000601caa1fd$c6dadb30$54909190$@joseph@fairview5.com>
In-Reply-To: <000601caa1fd$c6dadb30$54909190$@joseph@fairview5.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

On 02/21/2010 09:21 PM, George Joseph wrote:
> On 2/21/2010 1:01 PM, Jean Delvare wrote:
>> Hi George,
>>
>> On Sun, 21 Feb 2010 12:17:41 -0700, George Joseph wrote:
>>> From: George Joseph<george.joseph@fairview5.com>
>>>
>>> Hwmon driver for Andigilog aSC7621 family monitoring chips
>>>
>>> Signed-off-by: George Joseph<george.joseph@fairview5.com>
>>> ---
>>>
>>> Patch against 2.6.33-rc8
>>>
>>> Documentation/hwmon/asc7621 | 295 ++++++++++
>>> MAINTAINERS | 7
>>> drivers/hwmon/Kconfig | 13
>>> drivers/hwmon/Makefile | 1
>>> drivers/hwmon/asc7621.c | 1233
>>> ++++++++++++++++++++++++++++++++++++++++++++
>>> 5 files changed, 1549 insertions(+)
>>
>> I will not have the time to review your driver. Unless Hans steps in,
>> your best chance to get your driver reviewed and merged is to send it
>> to Andrew Morton.
>
> Hans, will you have time to review the patch?
>

As you've already noticed I had already put your last revision on my todo
list and have reviewed it yesterday, before even looking at this thread
again :)

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
