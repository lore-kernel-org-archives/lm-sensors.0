From: Jiri Slaby <jirislaby@gmail.com>
Date: Sun, 18 Nov 2007 22:27:02 +0000
Subject: Re: [lm-sensors] broken suspend [Was: 2.6.24-rc2-mm1]
Message-Id: <4740BC36.2070200@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.44L0.0711181203220.5712-100000@netrider.rowland.org> <47408DFF.9070701@gmail.com>
In-Reply-To: <47408DFF.9070701@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@linux-foundation.org>, Greg KH <greg@kroah.com>, Kernel development list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, r.marek@assembler.cz, lm-sensors@lm-sensors.org

Aah, we probably should let coretemp people known.

Whole thread:
http://marc.info/?t9507205800001&r=1&w=2

On 11/18/2007 08:09 PM, Jiri Slaby wrote:
> On 11/18/2007 06:07 PM, Alan Stern wrote:
>> You'll get more useful results if you redo your changes to 
>> notifier_call_chain().  Have it print out the address of the routine 
>> _before_ making the call, and don't limit it to 20.  That way you'll 
>> know exactly which notifier routine ends up hanging.
> 
> The problem is, that notifier_call_chain is called again and again zillion times
> by somebody else...
> 
> Anyway you led me to another idea:
> * _cpu_down
>         printk("%s: u\n", __func__);
>         BUBAK=1;
>         /* CPU is completely dead: tell everyone.  Too late to complain. */
>         if (raw_notifier_call_chain(&cpu_chain, CPU_DEAD | 0x88000 | mod,
>                                     hcpu) = NOTIFY_BAD)
>                 BUG();
>         BUBAK=0;
> -----
> * notifier_call_chain
>         unsigned int a = val & 0x88000;
>         unsigned int yes = a = 0x88000;
> 
>         nb = rcu_dereference(*nl);
> 
>         if (a && a != 0x88000)
>                 printk("Somebody calls with val: %lx\n", val);
>         else
>                 val &= ~0x88000;
> 
>         while (nb && nr_to_call) {
>                 next_nb = rcu_dereference(nb->next);
>                 if (unlikely(BUBAK && yes))
>                         printk("%s: %p\n", __func__, nb->notifier_call);
>                 ret = nb->notifier_call(nb, val, v);
> -----
> gives coretemp_cpu_callback -> coretemp_device_remove ->
> platform_device_unregister, so coretemp seems to be what I have and you don't.

Just in case you are curious:
http://www.fi.muni.cz/~xslaby/sklad/susp_hang3.diff
produces:
http://www.fi.muni.cz/~xslaby/sklad/susp_hang3.png



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
