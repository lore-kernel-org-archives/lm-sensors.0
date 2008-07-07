From: Wilken Gottwalt <wgottwalt@suse.de>
Date: Mon, 07 Jul 2008 06:41:06 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon (c7temp): new driver for VIA C7 CPU
Message-Id: <200807070841.06330.wgottwalt@suse.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0806191620g1f001306r5d26cb67ed12d44b@mail.gmail.com>
In-Reply-To: <191fb4ca0806191620g1f001306r5d26cb67ed12d44b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Am Montag 07 Juli 2008 08:11:02 schrieb Juerg Haefliger:
> Wilken,
>
> >> Wilken, what motherboard is this? Are there any BIOS settings (thermal
> >> management) that you can play around with? Try different thermal
> >> management settings and rerun cpuid and check if the thermal monitors
> >> show up as 'true'.
> >> I have a cpuid dump from Sergio (C7 on a LN10000 board) and the only
> >> difference between his dump and yours is that his shows 'true' for
> >> both thermal monitors. Maybe your BIOS disables these features on your
> >> CPU.
> >
> > It's the Artigo-Box from Via with a PX10000 board
> > (http://www.via.com.tw/en/products/embedded/artigo/).
> > No, there are no bios settings dealing with thermal or power management.
> > There is nothing I can play with. The bios is very rudimentary.
>
> Look at page 31 (CPU features) of the user's manual at
> http://www.via.com.tw/en/products/mainboards/downloads.jsp?motherboard_id=4
>72#Manual
>
> ...juerg

Did you ever saw a manual which was 100% identical with a bios? I saw about 30 
ones and no one was. With other words: these options are not available in the 
bios. I only have the two C7 options which are not working at all. :-/

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
