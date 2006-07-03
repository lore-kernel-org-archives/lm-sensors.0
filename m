From: stelian@popies.net (Stelian Pop)
Date: Mon, 03 Jul 2006 09:02:11 +0000
Subject: [lm-sensors] [RFC] Apple Motion Sensor driver
Message-Id: <1151917331.10711.8.camel@localhost.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060702222649.GA13411@hansmi.ch>
	 <20060702201415.791c6eb2.akpm@osdl.org>  <20060703065628.GA21113@hansmi.ch>
In-Reply-To: <20060703065628.GA21113@hansmi.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michael Hanselmann <linux-kernel@hansmi.ch>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, khali@linux-fr.org, linux-kernel@killerfox.forkbomb.ch, benh@kernel.crashing.org, johannes@sipsolutions.net, chainsaw@gentoo.org

Le lundi 03 juillet 2006 ? 08:56 +0200, Michael Hanselmann a ?crit :
> Hello Andrew
> 
> On Sun, Jul 02, 2006 at 08:14:15PM -0700, Andrew Morton wrote:
> > On Mon, 3 Jul 2006 00:26:49 +0200
> > Michael Hanselmann <linux-kernel at hansmi.ch> wrote:
> 
> > > Below you find the latest revision of my AMS driver.
> 
> > I was about to merge the below, then this comes along.  Now what?
> 
> > From: Stelian Pop <stelian at popies.net>
> 
> > This driver provides support for the Apple Motion Sensor (ams), which
> > provides an accelerometer and other misc.  data.  Some Apple PowerBooks
> 
> I just noticed yesterday that Stelian sent a patch to lkml in May. My
> work is based on his separate driver from his website.
> 
> Given the fact that my driver includes all of his functionality and that
> replacing his with mine later in the process would mean to remove whole
> files again, I'd suggest to wait until I've fixed the outstanding issues
> (as seen in this thread) and then to merge mine.

I have no problems with this approach. I'll take a look at your patch
ASAP.

Stelian.
-- 
Stelian Pop <stelian at popies.net>


