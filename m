From: Hans de Goede <hdegoede@redhat.com>
Date: Mon, 07 May 2012 06:58:00 +0000
Subject: Re: [lm-sensors] [PATCH 1/3] watchdog_dev: Add support for having more then 1 watchdog
Message-Id: <4FA77278.5030705@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1331812757-3491-1-git-send-email-hdegoede@redhat.com> <1331812757-3491-2-git-send-email-hdegoede@redhat.com> <20120315131131.1096f8c8@pyramind.ukuu.org.uk> <4F61FA18.70104@redhat.com> <20120315153833.40bd2f16@pyramind.ukuu.org.uk> <20120504123434.GR3074@spo001.leaseweb.com>
In-Reply-To: <20120504123434.GR3074@spo001.leaseweb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wim Van Sebroeck <wim@iguana.be>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-watchdog@vger.kernel.org, LM Sensors <lm-sensors@lm-sensors.org>, Thilo Cestonaro <thilo.cestonaro@ts.fujitsu.com>, =?ISO-8859-1?Q?P=E1dra?= =?ISO-8859-1?Q?ig_Brady?= <P@draigBrady.com>

Hi,

On 05/04/2012 02:34 PM, Wim Van Sebroeck wrote:
> Hi Alan,
>
>>> You do this even for watchdog0 / for the watchdog we've also registered as
>>> misc_dev. I guess this is intentional and you want the watchdog to be
>>> available as both misc,130 as well as as MAJOR(dog_devt),0 ?
>>
>> Yes - so that it appears in the watchdog class in sysfs for example.
>
> What happens if one program opens the miscdevice and another program opens the MAJOR(dog_devt),0 device?
> I presume that the WDOG_DEV_OPEN status bit will prohibit the opening of the second device in that case...

Correct.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
