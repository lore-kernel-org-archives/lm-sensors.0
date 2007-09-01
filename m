From: Jeff Garzik <jeff@garzik.org>
Date: Sat, 01 Sep 2007 16:01:20 +0000
Subject: Re: [lm-sensors] [PATCH] drivers/firmware: const-ify DMI API and
Message-Id: <46D98CD0.9040206@garzik.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070901142719.GA31990@havoc.gtf.org> <20070901153644.GA530@kroah.com>
In-Reply-To: <20070901153644.GA530@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, ak@suse.de, len.brown@intel.com, linux-ide@vger.kernel.org, dz@debian.org, minyard@acm.org, j.w.r.degoede@hhs.nl, lm-sensors@lm-sensors.org, rlove@rlove.org, bzolnier@gmail.com, dmitry.torokhov@gmail.com, mzxreary@0pointer.de, stelian@popies.net, ibm-acpi@hmh.eng.br, ambx1@neo.rr.com, gimli@dark-green.com

Greg KH wrote:
> On Sat, Sep 01, 2007 at 10:27:19AM -0400, Jeff Garzik wrote:
>> commit 457b6eb3bf3341d2e143518a0bb99ffbb8d754c4
>> Author: Jeff Garzik <jeff@garzik.org>
>> Date:   Sat Sep 1 10:16:45 2007 -0400
>>
>>     drivers/firmware: const-ify DMI API and internals
>>     
>>     Three main sets of changes:
>>     
>>     1) dmi_get_system_info() return value should have been marked const,
>>        since callers should not be changing that data.
>>     
>>     2) const-ify DMI internals, since DMI firmware tables should,
>>        whenever possible, be marked const to ensure we never ever write to
>>        that data area.
>>     
>>     3) const-ify DMI API, to enable marking tables const where possible
>>        in low-level drivers.
>>     
>>     And if we're really lucky, this might enable some additional
>>     optimizations on the part of the compiler.
>>     
>>     The bulk of the changes are #2 and #3, which are interrelated.  #1 could
>>     have been a separate patch, but it was so small compared to the others,
>>     it was easier to roll it into this changeset.
> 
> 
> Looks great to me, do you want me to take this through my driver tree?
> I'd be glad to do so.

I was just going to push it myself, but have no strong feelings on the 
matter.

	Jeff




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
