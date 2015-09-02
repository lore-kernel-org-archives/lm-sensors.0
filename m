From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 02 Sep 2015 15:37:06 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon: (nct6775) Add support for NCT6793D
Message-Id: <55E717A2.2080109@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1372180269-3213-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1372180269-3213-2-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

On 09/02/2015 01:45 AM, Jean Delvare wrote:
> Hi Guenter,
>
> On Mon, 31 Aug 2015 16:57:33 -0700, Guenter Roeck wrote:
>> NCT6793D is register compatible with NCT6792D.
>>
>> Tested-by: Grazvydas Ignotas <notasas@gmail.com>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>   Documentation/hwmon/nct6775 |  4 ++++
>>   drivers/hwmon/Kconfig       |  4 ++--
>>   drivers/hwmon/nct6775.c     | 29 ++++++++++++++++++++++-------
>>   3 files changed, 28 insertions(+), 9 deletions(-)
>> (...)
>
> Looks good to me (didn't check the datasheet, trusting you on the fact

I only cound one difference: The "3-wire enable" register (index 0x31 in
various banks) no longer exists. It isn't used by the driver, so no change
was needed. Of course, I may have missed some swapped registers ...

> that the chips are compatible) except that you forgot to add a name
> string for the new chip to nct6775_sio_names[].
>
Good catch!

> With that fixed:
> Reviewed-by: Jean Delvare <jdelvare@suse.de>
>
> Note: given that enum kinds is used to index nct6775_sio_names[], it
> would feel safer to have nct6775_sio_names[] defined closer to enum
> kinds, as nct6775_device_names[] is already.
>
I did that.

Thanks a lot for the review.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
