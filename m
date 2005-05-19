From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:20 +0000
Subject: lm83 driver ported to linux 2.6
Message-Id: <20031002204224.GA5645@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030929213648.5ebc26bd.khali@linux-fr.org>
In-Reply-To: <20030929213648.5ebc26bd.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Oct 01, 2003 at 08:58:28PM +0200, Jean Delvare wrote:
> > Tabs are ALWAYS set to 8 in Linux kernel code.  Please use tabs.
> 
> Discussing arbitrary decisions being pointless, I will obey.
> 
> However, I believe that alignments should *not* rely on a particular tab
> size. Thus, I use tabs for indentation only. This makes code "portable"
> between coders. One can switch curly braces positioning policies on the
> fly, but changing tabs size and/or indentation policy requires editor
> properties adjustement, which is painful to do repeatedly.
> 
> (And Larry Wall says that tabs are set to 4. I'd love to hear Larry and
> Linus discuss about that for hours.)

Larry can code perl with tabs at 4, Linus decreed that tabs are to be
set at 8.  There's no valid justification for one over another other
than, "That's the way I like it."

Since Linus likes 8, kernel code is in 8.  We play in his sandbox, we
play by his rules :)

In the end consistancy is the real goal.  And the kernel coding style
guidelines aren't all that strict.  They only state a few small rules.
Nothing like the GNU rules...

thanks,

greg k-h
