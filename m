From: Hans de Goede <hdegoede@redhat.com>
Date: Wed, 06 May 2009 07:54:28 +0000
Subject: Re: [lm-sensors] [PATCH] k8temp: Unset driver data in exit_remove
Message-Id: <4A014234.3050200@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090506071741.GA4386@ubuntu>
In-Reply-To: <20090506071741.GA4386@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



On 05/06/2009 09:36 AM, Jean Delvare wrote:
> Hi Andre,
>
>

<snip>

> I'll remember that :) Actually you may want to look at the abandoned
> tmp401 driver. Hans de Goede worked on it originally but it never made
> it into mainline. That's a pity because it was almost ready. I seem to
> remember it needs to be updated due to i2c infrastructure changes, and
> minor cleanups were needed before I would take the driver into mainline:
>
> http://lists.lm-sensors.org/pipermail/lm-sensors/2008-June/023411.html
> http://lists.lm-sensors.org/pipermail/lm-sensors/2008-August/024024.html
>
> Is this something you'd be interested in? If you don't have any
> supported chip, I can send you chip dumps, which you can feed into
> i2c-stub to emulate a chip. Or if you are into soldering, you may be
> able to ask TI for free chip samples.
>

Hi Andre,

Nice to meet you! As Jean said I've been working on a TI tmp401 driver,
which is like 99% finished. If you're interested in working on this, please
let me know, I've got a much newer version sitting on my harddisk, as well
as a wip version which also adds support for the tmp411, so if you want to
work on this I'll dig them up.

As Jean said, you can ask TI for samples, or I can mail them to you if you
prefer, I still have a number of them left, the big question is how good
are you with a soldering iron? All the samples are smd and have a quite narrow
pitch.

When you've got a sample, you ofcourse need an i2c adapter to hook it up to, I
can advice using an i2c-tiny-usb adapter:
http://www.harbaum.org/till/i2c_tiny_usb/index.shtml

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
