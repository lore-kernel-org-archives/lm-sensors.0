From: yani.ioannou@gmail.com (Yani Ioannou)
Date: Thu, 19 May 2005 06:25:06 +0000
Subject: PATCH: bmcsensors port to 2.6.7, associated patch for
Message-Id: <25381867040714202818006201@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <2538186704071412096450d7e0@mail.gmail.com>
In-Reply-To: <2538186704071412096450d7e0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Just one more update (I hope) - attached is the kernel patch but with
debugging disabled - the debugging in the previously submitted patch
was quite verbose and quickly fills your logs if you check the sensors
frequently.

Yani

On Wed, 14 Jul 2004 15:54:58 -0400, Yani Ioannou <yani.ioannou@gmail.com> wrote:
> Just resubmitting the lm_sensors-2.8.7 patch, corrected a silly
> numbering error where the voltage sensor thresholds displayed by the
> sensors utility was for the wrong sensor (e.g. in10_max/in10_min 10
> shown for in9_input) . Please use this patch instead of that
> previously posted.
> 
> Thanks,
> Yani
> 
> 
> 
> On Wed, 14 Jul 2004 15:09:08 -0400, Yani Ioannou <yani.ioannou@gmail.com> wrote:
> > Hi,
> >
> > Attached is my port of the ipmi bmcsensors driver (along with
> > associated i2c-ipmi dummy driver) from 2.4 to 2.6.7. Also attached you
> > will find a patch allowing the lm_sensors 2.8.7 userspace utilities to
> > work with the driver.
> >
> > The patches have been tested and works on my machine (HP x4000
> > Workstation w/ early IPMI 1.0 implementation) and could do with some
> > more testing on other ipmi implementations. Obviously ipmi is not
> > widespread yet, so any testing help and feedback is very much
> > appreciated.
> >
> > Thanks,
> > Yani
> >
> > P.S. Could someone add me to this mailing list? :-)
> >
> >
> >
> 
> 
>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: patch-linux-2.6.7-bmcsensors.diff.gz
Type: application/gzip
Size: 14178 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040714/1e120f72/patch-linux-2.6.7-bmcsensors.diff.bin
