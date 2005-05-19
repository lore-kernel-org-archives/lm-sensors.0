From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:37 +0000
Subject: Additional Support: Ticket 1548
Message-Id: <1075367202.4018cd223b68f@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040128025905.42866.qmail@web20902.mail.yahoo.com>
In-Reply-To: <20040128025905.42866.qmail@web20902.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Now here's something REALLY weird.  The source folder
> for linux (kernel source package) was not included
> with Mandrake Linux 9.2
> 
> When you download the source rpm online... it's
> 2.4.22-26mdk
> 
> Oddly enough, I think the default installed kernel for
> Mandrake 9.2 is 2.4.22-10mdk.

You're right, the original one is -10, then an update named -21 was made
available (that's what I'm running at work). Now there is a -26
available.

> The driver was in the
> /lib/modules/2.4.22-26mdk/blahblah folder, but not in
> the 2.4.22-10mdk folder.  I copied it over there, then
> ran depmod -ae as requested.  It complained at me.
> 
> depmod: *** Unresolved symbols in
> /lib/modules/2.4.22-10mdk/kernel/drivers/i2c/chips
> depmod:         i2c_proc_real_Ra75f2adc
> depmod:         i2c_register_entry_Rf996904e
> depmod:         i2c_sysctl_real_R9ea74e56

I never understood what these _Rxxx things are for, but it seems to
cause much trouble when it comes to compatibility between different
kernels.

> When using Konsole... it searches for stuff in the
> 2.4.22-10mdk folder -- yet the source rpm for 9.2 is
> 2.4.22-26mdk
> 
> That makes absolutely no sense whatsoever to me :)

You really need to have sources that match your running kernel. I
managed to do that here. I think Mandrake is always distributing both
the kernel and its sources with matching versions (as all distributions
do). As we updated to -21 here, /etc/lilo.conf was modified and now
includes both kernels (although -10 is still the default, I can't
understand why they do that).

If you can get the sources that match your running kernel, or, if you
can't get that, the kernel that matches your sources (will require a
reboot and possibly a tweak of your bootloader), I think that your
trouble is over.

> Anyway -- thanks for your help so far.  I'm an
> overclocker, and don't want to push the system too far
> on Linux without having sensors working.

I understand you. I stopped overclocking long ago as I understood how
pointless it was. If your system is new, it's already fast and you
don't need to overclock it. It it's old, it will stay slow even when
overclocked. So the overclocking only makes sense in the middle life of
the hardware. Anyway, I don't have time to play anymore, and I don't
see the benefit of winning 5% on compilation times, at the cost of
unstability or overheating.

Oh well, it's your computer after all ;)

Good luck.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
