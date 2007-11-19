From: Alan Stern <stern@rowland.harvard.edu>
Date: Mon, 19 Nov 2007 03:04:52 +0000
Subject: Re: [lm-sensors] broken suspend [Was: 2.6.24-rc2-mm1]
Message-Id: <Pine.LNX.4.44L0.0711182156330.22727-100000@netrider.rowland.org>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <4740BC36.2070200@gmail.com>
References: <4740BC36.2070200@gmail.com>
In-Reply-To: <4740BC36.2070200@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jiri Slaby <jirislaby@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@linux-foundation.org>, Greg KH <greg@kroah.com>, Kernel development list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, r.marek@assembler.cz, lm-sensors@lm-sensors.org

On Sun, 18 Nov 2007, Jiri Slaby wrote:

> > gives coretemp_cpu_callback -> coretemp_device_remove ->
> > platform_device_unregister, so coretemp seems to be what I have and you don't.

Yes.

For the coretemp developers: coretemp_cpu_callback() needs to be more 
careful about what it does.  During a system sleep transition (suspend, 
hibernate, resume) it isn't possible to register or unregister a 
device.  Attempts to register will fail and attempts to unregister will 
block until the system sleep is over -- and for this callback that 
means hanging.

It's not clear what the best way is to fix this.  Perhaps the CPU 
notification should be sent along with a special flag indicating that 
the CPU transition is part of a system sleep (although this seems 
racy).  Perhaps the driver should notice when a system sleep begins, 
and defer all CPU-change handling until after the sleep is over.

Alan Stern


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
