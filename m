From: alex@alexdalton.org (Alexandre d'Alton)
Date: Thu, 19 May 2005 06:25:03 +0000
Subject: [PATCH 2.6] ADM1030 and Co sensors chips support for 2.6.7-mm1
Message-Id: <1088667632.40e3bff099103@imp1-q.free.fr>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040622195209.77f852a6.alex@alexdalton.org>
In-Reply-To: <20040622195209.77f852a6.alex@alexdalton.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Greg, Mark,

Please find (attached because my mailer wraps lines.) an incremental patch that
applies on top of the previous one (the one from the first message of the
thread) and that adds parenthesis to the macro as pointed out by Mark.

Please apply,

Alex.

Quoting "Mark M. Hoffman" <mhoffman@lightlink.com>:

> Hello:
> 
> > Quoting "Mark M. Hoffman" <mhoffman@lightlink.com>:
> > > A recent driver core patch *necessitates* the trailing semicolon for
> > > DEVICE_ATTR().
> 
> * Alexandre d'Alton <alex@alexdalton.org> [2004-06-30 09:33:01 +0200]:
> > In fact, I already put the semicolons on the iner calls to DEVICE_ATTR(),
> but as
> > when I "instanciate"
> > the macros I put a semicolon, I thought that it was unnecessary on the last
> one.
> > If you confirm that I have to add them, I'll be glad to do it.
> 
> No, you're right.  Sorry for the noise.
> 

Mark : No problem :-) better to put only almost perfect stuff on Linux.

> Regards,
> 
> -- 
> Mark M. Hoffman
> mhoffman@lightlink.com
> 
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: adm1031-mmh-incremental.diff
Type: text/x-patch
Size: 577 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040701/0a09578a/adm1031-mmh-incremental.bin
