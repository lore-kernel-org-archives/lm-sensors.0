From: Hans de Goede <hdegoede@redhat.com>
Date: Fri, 01 Jun 2012 13:37:55 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon/sch56xx: Depend on watchdog for watchdog core functions
Message-Id: <4FC8C5B3.2060108@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1337890738-26533-1-git-send-email-hdegoede@redhat.com>  <20120524205426.GW3074@spo001.leaseweb.com> <1338307894.478.68.camel@groeck-laptop>
In-Reply-To: <1338307894.478.68.camel@groeck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: guenter.roeck@ericsson.com
Cc: Wim Van Sebroeck <wim@iguana.be>, "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, LM Sensors <lm-sensors@lm-sensors.org>

Hi,

On 05/29/2012 06:11 PM, Guenter Roeck wrote:
> On Thu, 2012-05-24 at 16:54 -0400, Wim Van Sebroeck wrote:
>> Hi Hans,
>>
>>> Since the watchdog code in sch56xx-common now uses the watchdog core, the
>>> Kconfig entires for the sch5627 and sch5636 should depend on WATCHDOG
>>> being set.
>>>
>>> Signed-off-by: Hans de Goede<hdegoede@redhat.com>
>>
>> I added also the "select WATCHDOG_CORE" lines for both drivers.
>> In linux-watchdog-next now.
>>
> Hi Wim,
>
> looks like Hans' patches are all in your tree, so I assume I don't have
> to take anything through my hwmon tree. Please let me know if I got that
> wrong.

Right, the sch56xx watchdog code conversion to the watchcore depended on
some pending watchdag core changes, so it seemed sensible to get them all
in though Wim's tree. Sorry if that caused any confusion.

Now that we've a common watchdog core, I would also like to convert the
fschmd watchdog code to it (one of these days). Which raises the question
through which tree should that conversion go in. fschmd is primarily a hwmon
driver, but the changes will only touch the watchdog part...

I guess it would be best to get the conversion in to Wim's tree, even though
that slightly increases the chance of conflicts. The fschmd driver does not see
a lot of churn, and I think Wim is a better reviewer for watchdog related
patches :)

Thanks & Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
