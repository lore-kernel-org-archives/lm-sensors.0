From: Axel.Thimm@ATrpms.net (Axel Thimm)
Date: Fri, 06 Jan 2006 21:48:20 +0000
Subject: [lm-sensors] project status and future
Message-Id: <20060106214820.GJ28372@neu.nirvana>
List-Id: <lm-sensors.vger.kernel.org>
References: <43AF1E4A.90902@sh.cvut.cz>
In-Reply-To: <43AF1E4A.90902@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Jan 06, 2006 at 01:42:07PM -0800, Philip Edelbrock wrote:
> 
> 
> Rudolf Marek wrote:
> > I'm also observing the disappearing of pictures on every second
> > page reload, can you please fix it too?
> 
> Ah, are you using Safari?  (Or another KHMTL browser?)  I see the
> disappearing images/stylesheets too.  Same thing on the ivtv site.
> I suspect that it might be because the images/stylesheet are marked
> as not cachable and expire even before the page renders, but I'm not
> sure.

I think it's independent of the browser, I see it with firefox, too (at
least the logo flipping on and off).

I think this is a regression in 0.9.2, because I hadn't seen this
before. Mike has contact to a trac guy and I also contacted the trac
list to get this fixed.
-- 
Axel.Thimm at ATrpms.net
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060106/2dd2d987/attachment.bin
