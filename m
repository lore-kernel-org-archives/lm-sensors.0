From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 14 Jan 2014 18:49:09 +0000
Subject: Re: [lm-sensors] Call for lm-sensors 3.3.5
Message-Id: <20140114194909.223e15ae@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20140114165101.4958fc13@endymion.delvare>
In-Reply-To: <20140114165101.4958fc13@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 14 Jan 2014 10:39:41 -0800, Phil Pokorny wrote:
> On Tue, Jan 14, 2014 at 8:17 AM, Jean Delvare <khali@linux-fr.org> wrote:
> >
> > Hi Phil,
> >
> > On Tue, 14 Jan 2014 08:07:51 -0800, Phil Pokorny wrote:
> > > AMD announced Kaveri boxed proc availability today.
> > > http://finance.yahoo.com/news/amd-revolutionizes-compute-ultrahd-entertainment-130000053.html
> > >
> > > K10temp needs a new PCI table entry for this proc.  I've tested and it
> > > gives readings that change as expected. PCI ID is already in mainline
> > > PCI-ids.h
> > >
> > > Or did I misunderstand and you are talking about userspace?
> >
> > I was talking about user-space, yes. But sensors-detect would need to
> > be taught about the new PCI ID too.
> >
> > Maybe we already have it:
> > http://www.lm-sensors.org/changeset/6191
> >
> > Or is it yet another PCI ID?
> 
> 
> New PCI ID:  141d  aka  PCI_DEVICE_ID_AMD_15H_M30H_NB_F3 for A10-7850K
> and others in Kaveri family for k10temp driver.
> 
> I suppose I should send a new e-mail with just the patch and description...

Ideally two: one for the kernel and one for sensors-detect.

But if you can't / don't want to deal with sensors-detect, just say so
and I'll take care of it based on the kernel patch.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
