From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 05 Aug 2015 20:56:59 +0000
Subject: Re: [lm-sensors] [PATCH v3] hwmon: (it87) Add support for IT8732F
Message-Id: <55C2789B.5000407@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1438804388-21266-1-git-send-email-jmaggard@netgear.com>
In-Reply-To: <1438804388-21266-1-git-send-email-jmaggard@netgear.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Justin,

On 08/05/2015 01:50 PM, Justin Maggard wrote:
> On Wed, Aug 5, 2015 at 1:36 PM, Phil Perry <phil@elrepo.org> wrote:
>> On 05/08/15 20:53, Justin Maggard wrote:
>>> Add support for the IT8732F.  This chip is pretty similar to IT8721F,
>>> with the main difference being that the ADC LSB is 10.9 mV instead of
>>> 12 mV.
>>>
>>> Signed-off-by: Justin Maggard <jmaggard@netgear.com>
>>> ---
[ ... ]
>>>
>>>   static unsigned short force_id;
>>>   module_param(force_id, ushort, 0);
>>> @@ -147,6 +149,7 @@ static inline void superio_exit(void)
>>>   #define IT8720F_DEVID 0x8720
>>>   #define IT8721F_DEVID 0x8721
>>>   #define IT8726F_DEVID 0x8726
>>> +#define IT8732F_DEVID 0x8732
>>>   #define IT8728F_DEVID 0x8728
>>
>> Nit-picking, but shouldn't these be kept in numerical order?
>>
>
> Oops...  yes, I'll fix that.
>
I think you were just testing us :-)

> Anything else for v4? :-)
>
Not worth a v4 just for that. The patch looks good to me otherwise.
I fixed this up and applied the patch to hwmon-next.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
