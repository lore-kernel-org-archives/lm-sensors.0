From: Andi Kleen <ak@suse.de>
Date: Sat, 01 Sep 2007 16:33:08 +0000
Subject: Re: [lm-sensors] [PATCH] drivers/firmware: const-ify DMI API and
Message-Id: <200709011833.08581.ak@suse.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070901142719.GA31990@havoc.gtf.org>
In-Reply-To: <20070901142719.GA31990@havoc.gtf.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jeff Garzik <jeff@garzik.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Greg KH <greg@kroah.com>, len.brown@intel.com, linux-ide@vger.kernel.org, dz@debian.org, minyard@acm.org, j.w.r.degoede@hhs.nl, lm-sensors@lm-sensors.org, rlove@rlove.org, bzolnier@gmail.com, dmitry.torokhov@gmail.com, mzxreary@0pointer.de, stelian@popies.net, ibm-acpi@hmh.eng.br, ambx1@neo.rr.com, gimli@dark-green.com


>     And if we're really lucky, this might enable some additional
>     optimizations on the part of the compiler.

Only if the kernel was compiled C++. C compilers generally ignore constness
for optimization purposes because it can be so easily casted away.

-Andi

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
