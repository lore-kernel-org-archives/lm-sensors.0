From: phil@netroedge.com (phil@netroedge.com)
Date: Thu, 19 May 2005 06:23:26 +0000
Subject: i2c-keywest & multiple channels
Message-Id: <20011130145253.T5595@Stimpy.netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20011130122643.P5595@Stimpy.netroedge.com>
In-Reply-To: <20011130122643.P5595@Stimpy.netroedge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Nov 30, 2001 at 10:57:51PM +0100, Benjamin Herrenschmidt wrote:
> >
> >So instead of 2 busses, there are actually 4?  It's not hard to treat
> >each as an individual bus and mark them as such in /proc/bus/i2c.  My
> >only source of technical info was from the Darwin code.  Do you have a
> >PDF or something with better technical info which I could get a copy
> >of? 
> 
> No, but it's in the darwin code (the set channel or something). 
> I think there at at least 4 busses on uninorth, dunno about keylargo.
> The channel register allows for 16 channels per cell, but I don't
> think all of these are actually wired.

OK, I'll take another look.  I might have seen what you are talking
about, but dismissed it as something else at the time.
 
> >BTW- If you'd like to have CVS access to make modifications, feel free
> >to ask.  I took a wild stab at it originally, and it was modified by
> >others to work enough to access the mixer chip.  If you'd like to add
> >some more refinements and better overall support, feel free.
> >
> 
> No need ;) I have enough accesses here or there to get lost. I'll do
> work on my tree and eventually submit you a modified driver.

OK, that works too. :')


Phil

-- 
Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
   phil@netroedge.com -- http://www.netroedge.com/~phil
 PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
