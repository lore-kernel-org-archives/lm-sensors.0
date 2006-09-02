From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 02 Sep 2006 05:28:00 +0000
Subject: [lm-sensors] vt1211 module parameters
Message-Id: <20060902072800.1ba25f52.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060901154635.6be81700.khali@linux-fr.org>
In-Reply-To: <20060901154635.6be81700.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Juerg,

> > I noticed that the vt1211 module parameters are not documented. Usually
> > have a section for them in the Documentation/hwmon/$driver file. Can
> > you please provide a documentation update adding it?
> 
> Sure, will do.
> 
> > The patches I applied for the vt1211 driver and documentation are:
> > http://khali.linux-fr.org/devel/i2c/linux-2.6/hwmon-vt1211-new-driver.patch
> > http://khali.linux-fr.org/devel/i2c/linux-2.6/hwmon-vt1211-documentation.patch
> >
> > Any change you make from now needs to be an incremental patch against
> > these.
> 
> What's the command to generate an inc patch?

Nothing special, just run "diff" between the current and the new
version of the file. Something like:
  diff -u Documentation/hwmon/vt1211.orig Documentation/hwmon/vt1211
should work fine.

By "incremetal", all I meant was: new patches to apply on top of the
current files, and not a complete replacement for the previous patches.

And if you think handling a patch stack manually is difficult, I can
only recommend using quilt:
  http://savannah.nongnu.org/projects/quilt

-- 
Jean Delvare

