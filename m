From: Axel.Thimm@ATrpms.net (Axel Thimm)
Date: Thu, 19 May 2005 06:24:51 +0000
Subject: possible bug - lm_sensors
Message-Id: <20040407083656.GE9551@neu.nirvana>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Apr 06, 2004 at 09:35:46PM -0700, bishop wrote:
> Not sure if this was a bug, so I've not logged anything in the  bz.
> 
> Diffing my config files recently showed this gem:
> 
> /etc/sensors.conf
> >@@ -1630,12 +1630,28 @@
> > # Analog inputs
> >
> >    ignore ain_conf
> >-   set    ain_conf    0
> >+# Since Linux 2.6, input configuration is set as module parameter,
> >+# so the line below is for older kernels only.
> >+#  set    ain_conf    0
> >+
> >+# You may discard ch2 and ch3 if you don't use them (depends on the input
> >+# configuration)
> >+#  ignore ch2
> >+#  ignore ch3
> >+
> >    label  ch0         "Chan. 0"
> >    label  ch1         "Chan. 1"
> >    label  ch2         "Chan. 2"
> >    label  ch3         "Chan. 3"
> 
> The recent change seems to have removed some behaviour that seems - by 
> comments - to be required for kernel 2.4 .  This is my FC1 mythtv 
> system, which is running kernel-2.4.22-1.2174.nptl_37.rhfc1.at .
> 
> Should the package have a conflicts: so it doesn't install with 2.4 
> kernels?  Should another package be built for 2.4 with that option 
> uncommented?  It all depends on whether it's really an important bit, I 
> guess.

I think this is there by mistake, the built packages are meant for 2.4
(or from the source code's POV for both 2.6 and 2.4). I suggest that
either the comment is wrong (works also with 2.4), or that you should
uncomment that part. Of course, at the end of the day, what really
counts is whether you have decent output from lm_sensors.

> So I wasn't sure, and thought I'd report it to the maintainer, at least.

I am copying the lm_sensors list. I am not sure myself ;)
-- 
Axel.Thimm at ATrpms.net
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040407/b97105e5/attachment.bin
