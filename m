From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:37 +0000
Subject: gl518sm chip driver for 2.6 kernel
Message-Id: <1075468680.401a59888a1a1@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <1075295349.4017b475e9031@imp.gcu.info>
In-Reply-To: <1075295349.4017b475e9031@imp.gcu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Quoting Chew Hong Gunn <hgchew@gunnet.org>:

> On Fri, Jan 30, 2004 at 10:47:38AM +0100, Jean Delvare wrote:
>
> > Looks like we are not that far from a "final" version? Maybe some
> > changes to bring comments, authorship and copyrights in line with
> > the other drivers, and we should have something good for
> > inclusion.
> 
> If you can point me to one to use as a template, I could work on it.

In fact I misexpressed myself. I don't think there is an "absolute"
template to start from. It was more about random thoughts that came to
me, such as:

1* I wouldn't use tabs in the heading comment.

2* I wouldn't mention "internal" revisions into the history.

3* I think we should mention the important changes we just made
(removal
of the ugly iteration stuff).

4* I wonder who should be listed in MODULE_AUTHOR(). This is really a
general question. I just don't know wether it should be seen as a kind
of hall of fame, in which case all names should appear, or a pointer to
one or more contacts, in which case only people still in activity
should be listed. The names of the original authors are still in the
sources, whatever.

Also, in the case of a driver being ported, I don't know wether the
names and contacts of the porters are to be mentioned there. I used to
think no, but when people port the driver for hardware they have and
use, they are probably the right people to contact for help and
feedback (together with the list, of course). So I don't really know
what should be done.

Greg, any advice as of good practices with respect to this topic?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
