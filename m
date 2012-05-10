From: Luca Tettamanti <kronos.it@gmail.com>
Date: Thu, 10 May 2012 12:15:31 +0000
Subject: Re: [lm-sensors] asus_atk0110 doesn't work on motherboard P8B WS
Message-Id: <CAKPcRGrQaKCKsnLCxD2iudVphG2p51=BkD_MSocvvxaAjY52Gg@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4FAAF8EA.3070202@free.fr>
In-Reply-To: <4FAAF8EA.3070202@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, May 10, 2012 at 1:08 AM, ACCART Julien <bigjulius@free.fr> wrote:
> Hello,
>
> I'm trying to get sensors informations on Asus P8B WS but it doesn't work.
>
> kernel : 3.2.15
> lm-sensors : 3.1.2
>
> When I launch :
> modprobe asus_atk0110
> the module loads successfully (no message in dmesg and it is visible in
> lsmod) but it doesn't create anything in /sys/class/hwmon/
>
> Could you help me?

Please send me a copy of this file:
/sys/firmware/acpi/tables/DSDT

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
