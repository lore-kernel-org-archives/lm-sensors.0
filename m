From: Luca Tettamanti <kronos.it@gmail.com>
Date: Mon, 14 May 2012 12:40:16 +0000
Subject: Re: [lm-sensors] asus_atk0110 doesn't work on motherboard P8B WS
Message-Id: <CAKPcRGrcQ=O1=oVDXmq_wMghkoWd2xhkAZd=eeruqQuQ4X8uRQ@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4FAAF8EA.3070202@free.fr>
In-Reply-To: <4FAAF8EA.3070202@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, May 14, 2012 at 2:27 PM, Luca Tettamanti <kronos.it@gmail.com> wrote:
> On Thu, May 10, 2012 at 9:05 PM, ACCART Julien <bigjulius@free.fr> wrote:
>>> Please send me a copy of this file:
>>> /sys/firmware/acpi/tables/DSDT
> [...]
>> Here it is.
>
> As Jean suspected there's no ATK0110 device, Asus is moving away from it.
> There's a lot of WMI stuff in there, but I'm not really familiar with it...

Oh, BTW: some of it seems to be supported by asus-wmi module, but
looking at DSDT it seems that most of the methods are stubs, the don't
really do anything useful....
I think that the only thing that's implemented is the notification of
the CPU temp going over a threshold (read from the NVS).

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
