From: Hans de Goede <hdegoede@redhat.com>
Date: Sun, 22 Aug 2010 18:04:38 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: f71882fg: Add support for the
Message-Id: <4C7166B6.1080505@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100801132226.GE3711@salidar.me.mortis.eu>	<1280669402-31213-1-git-send-email-me@mortis.eu>	<4C5950B6.5010503@redhat.com>	<20100810191117.GN14382@salidar.me.mortis.eu>	<4C651800.6030804@redhat.com> <20100818112418.a25a50d6.akpm@linux-foundation.org>
In-Reply-To: <20100818112418.a25a50d6.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Giel van Schijndel <me@mortis.eu>, Laurens Leemans <laurens@signips.com>, Jonathan Cameron <jic23@cam.ac.uk>, Randy Dunlap <rdunlap@xenotime.net>, Jean Delvare <khali@linux-fr.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Samuel Ortiz <sameo@linux.intel.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org

Hi,

On 08/18/2010 08:24 PM, Andrew Morton wrote:
> On Fri, 13 Aug 2010 12:01:36 +0200
> Hans de Goede<hdegoede@redhat.com>  wrote:
>
>> Hi,
>>
>> On 08/10/2010 09:11 PM, Giel van Schijndel wrote:
>>> On Wed, Aug 04, 2010 at 01:36:22PM +0200, Hans de Goede wrote:
>>>> On 08/01/2010 03:30 PM, Giel van Schijndel wrote:
>>>>> Allow device probing to recognise the Fintek F71808E.
>>>>>
>>>>> Sysfs interface:
>>>>>     * Fan/pwm control is the same as for F71889FG
>>>>
>>>> My datasheet strongly disagrees with this ...
>>>
>>> I just noticed this patch was applied to mainline anyway.  Regardless, I
>>> will (try to) address these issues you raised.
>>>
>>> Right now however, I am prioritising personal stuff above this
>>> driver---bachelor's thesis and graduation presentation.  When finished
>>> with that (september) I'll allocate time to these issues again.
>>>
>>
>> I've send a mail directly to akpm asking for this to be removed, hopefully
>> this will help.
>
> It seems that I managed to muck up my paperwork and the patch was
> merged into mainline.
>
> We can revert it, or we can fix it up in place in time for 2.6.36.
> What do you guys suggest?

Since both Giel and I are low on time to work on this, and since missing
hwmon support on a system is not really a big deal (for most users) I suggest
that this patch is reverted until we find the time to do it properly.

Regards,

Hans

p.s.

I've already seen mails that you've dropped this patch from -mm, does that
mean it thas been removed from mainly too ? If not please remove it from
mainline / ask Linus to remove it.

Thanks.

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
