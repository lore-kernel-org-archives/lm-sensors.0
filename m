From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 13 Nov 2013 05:10:05 +0000
Subject: Re: [lm-sensors] Nuvoton NCT6791D support
Message-Id: <528309AD.50609@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <CADkjvt_edGO-+NKbsUbNwN=DXod10WTUYmfjRTrQfYq_2no2uw@mail.gmail.com>
In-Reply-To: <CADkjvt_edGO-+NKbsUbNwN=DXod10WTUYmfjRTrQfYq_2no2uw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 11/12/2013 08:38 PM, p. stephen w wrote:
> no, I only deleted the nct6775 folder I used to clone the repo into.
> I can remove it, and run through the install again.
>
>
Hi,

That is not what I meant. To load the new version of the module, you need to unload the old version first,
using "modprobe -r". Just installing the new version of a module doesn't unload the old one.

Thanks,
Guenter

> On Tue, Nov 12, 2013 at 8:29 PM, Guenter Roeck <linux@roeck-us.net <mailto:linux@roeck-us.net>> wrote:
>
>     On Tue, Nov 12, 2013 at 08:07:09PM -0800, p. stephen w wrote:
>      > Please see attached.
>      > _______________________________________
>      > The attached shows all the commands and their output as I ran through them.
>      >
>      > Let me know if I missed something, or more info is needed.
>      >
>     Puzzled. Did you unload the old driver with "modprobe -r nct6775" before reloading it ?
>
>     Thanks,
>     Guenter
>
>
>
>
> --
>
>
> _____________________________
> Stephen Wille | pstephenwille.com <http://pstephenwille.com>
> /new address p.stephenwille@gmail.com <mailto:p.stephenwille@gmail.com>/


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
