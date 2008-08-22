From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Fri, 22 Aug 2008 18:19:09 +0000
Subject: Re: [lm-sensors] PATCH: hwmon-new-driver-ti-tmp401.patch
Message-Id: <48AF031D.6010205@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <4853E081.1020109@hhs.nl>
In-Reply-To: <4853E081.1020109@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Hans,
> 
> On Sat, 14 Jun 2008 17:15:13 +0200, Hans de Goede wrote:
>> Hi All,
>>
>> This is a new hwmon driver for TI's TMP401 temperature sensor IC. This driver
>> was written on behalf of an embedded systems vendor under the
>> linuxdriverproject.
>>
>> It has been tested using a TI TMP401 sample attached to a i2c-tiny-usb adapter.
>> Which was provided by Till Harbaum, many thanks to him for this!
>>
>> Signed-off-by: Hans de Goede <j.w.r.degoede@hhs.nl>
> 
> One more thing that was brought to my attention by a friend of mine who
> tested your code:
> 

Cool, someone is actually using it :) (I wrote it for a linuxdriverproject.org 
request, but it the company who wanted it never followed through).

ANd many thanks for this review and for the fschmd watchdog patch review!!

Unfortunately currently I'm rather swamped. But I will do new version in the 
next couple of weeks.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
