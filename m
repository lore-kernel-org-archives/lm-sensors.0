From: roger@planbit.co.uk (Roger Lucas)
Date: Sat, 03 Jun 2006 09:27:42 +0000
Subject: [lm-sensors] LM Sensors autoconfig tool project awarded as
Message-Id: <20060603092603.B3D1E12ED4@bluewhale.planbit.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <44744596.40406@hhs.nl>
In-Reply-To: <44744596.40406@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> >
> > The Motherboard Monitor project had around 1100 known motherboards when
> > it stopped 2 years ago. So depending on how successful we get, the
> > number of configuration files could range from a few hundreds to 2000
> > or so.
> >
> 
> Say worst case scenario is 2000 files each taking 4kb that sums up to
> 8Mb diskspace, sounds acceptable to me, what do others think?
> 

That doesn't sound that big, but it will continue to grow.  The files are
text files, however, and there will be significant common text between them
so I would expect that gzip'd TAR of them would dramatically reduce their
size.  If any tool could work with a tgz archive rather than requiring the
files directly then this could save a lot of space on the disk.



