From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 31 Aug 2015 23:17:56 +0000
Subject: Re: [lm-sensors] NCT6793D
Message-Id: <55E4E0A4.600@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <CANOLnOOtAJH9fcZCTRu9fa4cPM-mrBKB37t1pwDYs-JcgF7Oew@mail.gmail.com>
In-Reply-To: <CANOLnOOtAJH9fcZCTRu9fa4cPM-mrBKB37t1pwDYs-JcgF7Oew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 08/31/2015 03:33 PM, Grazvydas Ignotas wrote:
> On Mon, Aug 31, 2015 at 5:59 AM, Guenter Roeck <linux@roeck-us.net> wrote:
>> Turns out the NCT6793D is almost register compatible to NCT6792D. Only
>> difference I can find is that the NCT6792D has "3-wire enable" registers
>> for each fan. Those registers do not exist on NCT6793D.
>>
>> Please try the driver at https://github.com/groeck/nct6775 and let me know
>> if it works.
>
> It doesn't, still says "unsupported chip ID: 0xd121".
>
> With patched ID check I've also noticed that pwmX_step_down_time and
> pwmX_step_up_time are mixed up, don't know if this is something
> NCT6793D specific, looks more like general driver bug.
>

Should now be fixed. Unfortunately, I don't have a system with nct6775
anymore, so we'll have to assume that the datasheets are correct.

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
