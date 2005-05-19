From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:15 +0000
Subject: Support DB Entry 1770
Message-Id: <20040915201335.6f1036fc.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <007201c49733$ef934970$0a01a8c0@enterprise>
In-Reply-To: <007201c49733$ef934970$0a01a8c0@enterprise>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > Most (if not all) of the docs in the lm_sensors2 CVS repository are
> > targeted at 2.4 kernels. The reason is both historical (obviously)
> > and technical (2.6 drivers are not part of the package).
> 
> Ahh, guess I found it confusing, as the source is in the 2.6 tree.  I
> assumed it was all part of the same project.  Written by the same
> folks, but not part of the LM Sensors project?

Yes, that's the idea. It may sound confusing at first, but the truth is
that kernel code belongs to the kernel tree. Drivers should have been
merged into the main Linux tree many months earlier (if not years) but
it wasn't as easy as it sounds, thus the delay.

> Or is it a 2.4 module being compiled for a 2.6 kernel?

Drivers usually need quite some porting work, although most of it is the
same for all drivers.

> > (BTW, I cannot possibly connect to the CVS repository for now, so
> > someone else will have to apply the patch.)
> 
> As long as it gets there eventually.  :p

Correction, I have access again now. Slow access, but still...

> The key point was for me to disable "Dalayed Transactions" between
> ISA<->PCI.

Oh, really? You mean like changing settings in the BIOS setup screen?
This sure would need to be documented. I can't remember similar cases
being reported in the past.

Thanks.

-- 
Jean "Khali" Delvare
http://khali.linux-fr.org/
