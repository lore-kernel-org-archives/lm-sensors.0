From: phil@netroedge.com (phil@netroedge.com)
Date: Thu, 19 May 2005 06:23:31 +0000
Subject: 405 i2c patch
Message-Id: <20020405144539.B4010@Stimpy.netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3CAE05EB.F2EC7BF8@paradyne.com>
In-Reply-To: <3CAE05EB.F2EC7BF8@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


A while ago we converted any // comments to the /* */ kind.  I think
Frodo had some good reasons for doing this, although I don't remember
right now what they were.  Perhaps it is for compiler compatibility? 
I guess if for nothing else, it would be nice to convert those for
consistency sake.

Looking at Linus' CodingStyle doc, he doesn't say how to comment, but
says to try to comment exclusively at the head of functions and to
explain what the code does and not how.  (If it's not clear how the
code works, then it should be rewritten to clarify it.)


Phil

On Fri, Apr 05, 2002 at 03:15:39PM -0500, Mark Studebaker wrote:
> sorry. I did get it.
> The original 405 stuff came from Tom Rini at MontaVista.
> Is it safe to assume that you two are working together?
> 
> WIth files being renamed it will take a little while to get this checked in
> because that's harder in CVS.
> 
> BTW, what does OCP stand for?
> 
> Also, are we allowed to use // comments in the kernel?
> 
> Armin Kuster wrote:
> > 
> > Mark,
> > 
> > I have not heard back on this patch I sent out earlier this week.
> > 
> > Any status?
> > 
> > regards,
> > --
> > ==========================> > Armin Kuster                 MontaVista Software Inc.
> > Embedded Linux Consultant    1237 East Arques Ave
> > Phone (408) 328-0305         Sunnyvale CA 94085
> > Fax   (408) 328-9204         www.support.mvista.com
> > ==========================
-- 
Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
   phil@netroedge.com -- http://www.netroedge.com/~phil
 PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
