From: Huaxu Wan <huaxu.wan@linux.intel.com>
Date: Mon, 12 Apr 2010 02:58:06 +0000
Subject: Re: [lm-sensors] 32nm Support vor drivers/hwmon/coretemp.c
Message-Id: <20100412030100.GA10633@owl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Michael,

Sorry for the late reply. We are trying to found a universal method
to support newer CPUs, referring to 
http://lists.lm-sensors.org/pipermail/lm-sensors/2010-March/027966.html

Additional, the TjMax of Clarkdale and Westmere is not 100 C.

Thanks
Huaxu

On 17:14 Sat 27 Mar, Michael Fuckner wrote:
> Hi,
> 
> I just looked into git and saw currently no support for coretemp on
> Intels 32nm CPUs. Currently I just had Xeon 5630 and i5-660 to play
> with.
> 
> Model 25 Westmere
> Model 2C Clarkdale
> 
> [0.38] molli123@c64:/usr/home/molli123/linux-2.6.33.1/drivers/hwmon
> > diff coretemp.c.old coretemp.c
> 458c458
> <                 0x1e (Lynnfield) */
> ---
> >                 0x1e (Lynnfield), 0x25 (Clarkdale), 0x2c (Westmere)  */
> 463c463,464
> <                       (c->x86_model = 0x1e))) {
> ---
> >                       (c->x86_model = 0x1e) || (c->x86_model = 0x25) ||
> >                       (c->x86_model = 0x2C))) {
> 
> 
> Regards,
>  Michael!
> 
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
