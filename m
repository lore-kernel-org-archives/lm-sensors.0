From: Hans de Goede <hdegoede@redhat.com>
Date: Fri, 27 Mar 2009 12:10:41 +0000
Subject: Re: [lm-sensors] PATCH: hwmon-fschmd-add-hds.patch
Message-Id: <49CCC241.5060000@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <49786E06.1050705@hhs.nl>
In-Reply-To: <49786E06.1050705@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

Unfortunately I've found an issue with the Hadess support while
rebasing the driver to apply on top of v3 of the Syleus patch.

I'll mail FSC about this and CC you, I hope I get a timely answer
from FSC, I when I do I will do a new version ASAP.

Regards,

Hans


On 03/26/2009 10:43 AM, Jean Delvare wrote:
> On Thu, 22 Jan 2009 14:00:54 +0100, Hans de Goede wrote:
>> Hi,
>>
>> This patch adds support for the Hades to the FSC hwmon driver, this patch
>> is to be applied on top of the one adding support for the Syleus.
>> Note this patch is untested but it should be ok as the Hades is identical to
>> the Heimdall except for the voltage register addresses
>> (and I've asked FSC to test it).
>>
>> Signed-off-by: Hans de Goede<hdegoede@redhat.com>
>
> Looks alright to me, except for the missing update to
> drivers/hwmon/Kconfig (ditto for the Syleus patch.)
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
