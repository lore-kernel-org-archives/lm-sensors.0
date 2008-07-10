From: Wilken Gottwalt <wgottwalt@suse.de>
Date: Thu, 10 Jul 2008 06:08:16 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon (c7temp): new driver for VIA C7 CPU
Message-Id: <200807100808.16327.wgottwalt@suse.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0806191620g1f001306r5d26cb67ed12d44b@mail.gmail.com>
In-Reply-To: <191fb4ca0806191620g1f001306r5d26cb67ed12d44b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Am Montag 07 Juli 2008 19:29:00 schrieb Juerg Haefliger:
> Hi Wilken,
>
> > Am Montag 07 Juli 2008 08:11:02 schrieb Juerg Haefliger:
> >> Wilken,
> >>
> >> >> Wilken, what motherboard is this? Are there any BIOS settings
> >> >> (thermal management) that you can play around with? Try different
> >> >> thermal management settings and rerun cpuid and check if the thermal
> >> >> monitors show up as 'true'.
> >> >> I have a cpuid dump from Sergio (C7 on a LN10000 board) and the only
> >> >> difference between his dump and yours is that his shows 'true' for
> >> >> both thermal monitors. Maybe your BIOS disables these features on
> >> >> your CPU.
> >> >
> >> > It's the Artigo-Box from Via with a PX10000 board
> >> > (http://www.via.com.tw/en/products/embedded/artigo/).
> >> > No, there are no bios settings dealing with thermal or power
> >> > management. There is nothing I can play with. The bios is very
> >> > rudimentary.
> >>
> >> Look at page 31 (CPU features) of the user's manual at
> >> http://www.via.com.tw/en/products/mainboards/downloads.jsp?motherboard_i
> >>d=4 72#Manual
> >>
> >> ...juerg
> >
> > Did you ever saw a manual which was 100% identical with a bios? I saw
> > about 30 ones and no one was.
>
> Actually yes. All my BIOSes and manual match 100%.
>
> > With other words: these options are not available in the
> > bios. I only have the two C7 options which are not working at all. :-/
>
> OK, didn't mean to imply that your incapable of navigating the BIOS
>
> :-) Just making sure all the grounds are covered. I'm assuming you're
>
> on the latest BIOS rev?

Yes, I have the latest bios. The fun part is, the board had a more actual bios 
than the bios which was available on the homepage.


> I'll try to get some answers from VIA but I'm out of ideas. Looks like
> your CPU doesn't have those thermal sensors.

This is weird, it's a plain C7.


> ...juerg



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
