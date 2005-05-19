From: me@andrew.net.au (Andrew Pollock)
Date: Thu, 19 May 2005 06:25:18 +0000
Subject: email address scrambling in archive
Message-Id: <20041005012227.GF20837@daedalus.andrew.net.au>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041003175642.35e3f47f.khali@linux-fr.org>
In-Reply-To: <20041003175642.35e3f47f.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Oct 04, 2004 at 02:30:51PM +0100, Jean Delvare wrote:
> On Mon, 4 Oct 2004 18:43:50 +1000, Andrew Pollock wrote
> > On Sun, Oct 03, 2004 at 05:56:42PM +0200, Jean Delvare wrote:
> > > Hi Andrew,
> > >
> > > I just noticed that a number of archived mails from the lm_sensors
> > > mailing-list have their email addresses non-scrambled. Examples:
> > > http://archives.andrew.net.au/lm-sensors/msg18608.html
> > > http://archives.andrew.net.au/lm-sensors/msg18529.html
> > > http://archives.andrew.net.au/lm-sensors/msg18510.html
> > >
> > > Care to take a look and fix the problem?
> > 
> > Umm, I've taken a look, and unfortunately, I cannot see why this is the
> > case. I haven't changed the email address obfuscation option of 
> > mhonarc, and messages either side of the ones above have been 
> > obfuscated fine.
> 
> That's not what I see here.
> 
> All messages from 9531 to 18623 are not obsucated.
> 
> Also note that message 9531+N seems to be the same as message N, except that
> it's not obfuscated. This explains why the archive suddenly claims to have
> over 18000 messages while it was around 9000 not that long ago.

Hmmm.
 
> > I cannot see anything out of the ordinary in these 
> > messages that would make them not get obfuscated.
> >
> > If I think of anything else, I'll let you know. If you could keep an 
> > eye on it and make sure it doesn't start missing a sizable amount of 
> > messages
> > (preferably no more) or you can find a pattern in the messages it is 
> > missing, let me know.
> 
> I don't think the messages have anything special. I would rather suspect the
> reinstall of the host system some times ago. Does the date September 10 2004
> means anything special to you as far as this system is concerned? This is when
> the duplicates seem to have been generated.

That's not relevant to when I reinstalled daedalus, but it is relevant to
when I finally cracked the shits about the filesystem that serves the
archive filling up all the time. I discovered I'd been running mhonarc
incorrectly, and every hour I was regenerating the entire archive from
scratch, with the net effect of every single attachment being duplicated,
which slowly ate up all the space on that filesystem.

I then discovered that I should only be adding new messages each hour, which
is what I would have started doing around this time. It certainly solved the
disk space issues, but it seems that at some point, it all lost the plot and
duplicated the messages. I'll have a fiddle. I fear that some of your
messages that cross-reference each other by way of archive URL may become invalid though...
 
> The most simple thing to do now would probably be to delete all these duplicates.

I'll delete the range you quote above, and attempt to regenerate the index.
Hopefully the index will then point to the obfuscated messages rather than
non-existent non-obfuscated messages.

Stay tuned.

-- 
linux.conf.au 2005   -  http://lca2005.linux.org.au/  -  Birthplace of Tux
April 18th to 23rd   -  http://lca2005.linux.org.au/  -       LINUX
Canberra, Australia  -  http://lca2005.linux.org.au/  -    Get bitten!
