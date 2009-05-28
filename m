From: Greg KH <greg@kroah.com>
Date: Thu, 28 May 2009 14:49:01 +0000
Subject: Re: [lm-sensors] [stable] [PATCH-tip] x86: hwmon/k8temp.c
Message-Id: <20090528144901.GA7153@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4A165F67.3020005@assembler.cz> <1242981748.10642.3.camel@localhost.localdomain> <1242984648.16532.3.camel@localhost.localdomain> <4A182B61.5010503@assembler.cz> <1243339833.12303.2.camel@localhost.localdomain> <4A1C08C6.7060103@assembler.cz> <1243352672.31783.10.camel@localhost.localdomain> <1243511849.3669.5.camel@localhost.localdomain> <20090528142837.530ba070@hyperion.delvare> <1243520014.3143.11.camel@localhost.localdomain>
In-Reply-To: <1243520014.3143.11.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jaswinder Singh Rajput <jaswinder@kernel.org>
Cc: Jean Delvare <khali@linux-fr.org>, x86 maintainers <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, stable <stable@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, LM Sensors <lm-sensors@lm-sensors.org>, Ingo Molnar <mingo@elte.hu>

On Thu, May 28, 2009 at 07:43:34PM +0530, Jaswinder Singh Rajput wrote:
> On Thu, 2009-05-28 at 14:28 +0200, Jean Delvare wrote:
> > On Thu, 28 May 2009 17:27:29 +0530, Jaswinder Singh Rajput wrote:
> > > Hello Andrew, Greg and Ingo:
> > > 
> > > Do you think this patch should go to stable and latest git.
> > 
> > Definitely not to stable, it's not fixing any bug.
> > 
> 
> Ok, so you suggested this should go to latest git.
> 
> I proposed for stable because I was using AMD 11H from last 6 months and
> I was missing temperature monitor badly because my earlier Laptop was
> broken by overheating. So I thought if it goes to stable then users will
> start getting benefit of it, but if you want that users should wait for
> another 2 years. Then it is OK ;-)

2 years?  The next kernel release will be out in 3 months, we have a
very predictable release schedule.

thanks,

greg k-h

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
