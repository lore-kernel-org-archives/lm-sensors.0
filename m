From: Hans de Goede <hdegoede@redhat.com>
Date: Fri, 13 Aug 2010 10:01:36 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: f71882fg: Add support for the
Message-Id: <4C651800.6030804@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100801132226.GE3711@salidar.me.mortis.eu> <1280669402-31213-1-git-send-email-me@mortis.eu> <4C5950B6.5010503@redhat.com> <20100810191117.GN14382@salidar.me.mortis.eu>
In-Reply-To: <20100810191117.GN14382@salidar.me.mortis.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Giel van Schijndel <me@mortis.eu>
Cc: Laurens Leemans <laurens@signips.com>, Jonathan Cameron <jic23@cam.ac.uk>, Randy Dunlap <rdunlap@xenotime.net>, Jean Delvare <khali@linux-fr.org>, Andrew Morton <akpm@linux-foundation.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Samuel Ortiz <sameo@linux.intel.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org

Hi,

On 08/10/2010 09:11 PM, Giel van Schijndel wrote:
> On Wed, Aug 04, 2010 at 01:36:22PM +0200, Hans de Goede wrote:
>> On 08/01/2010 03:30 PM, Giel van Schijndel wrote:
>>> Allow device probing to recognise the Fintek F71808E.
>>>
>>> Sysfs interface:
>>>    * Fan/pwm control is the same as for F71889FG
>>
>> My datasheet strongly disagrees with this ...
>
> I just noticed this patch was applied to mainline anyway.  Regardless, I
> will (try to) address these issues you raised.
>
> Right now however, I am prioritising personal stuff above this
> driver---bachelor's thesis and graduation presentation.  When finished
> with that (september) I'll allocate time to these issues again.
>

I've send a mail directly to akpm asking for this to be removed, hopefully
this will help.

> PPS I do have a patch ready that addresses some of the issues you
>      raised.  Those are only the cosmetic changes though (e.g. change
>      naming of chip, comment updates, etc.).  Would you suggest me to
>      send it right now already or wait until I have time to address the
>      other issues as well?

My goal for 2.6.36 is to pull the patch, and then we can wait til all
issues are fixed properly before re-introducing it.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
