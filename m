From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sun, 12 Sep 2010 16:24:02 +0000
Subject: Re: [lm-sensors] [PATCH v2] sensors-detect: Add support for
Message-Id: <20100912162402.GA29905@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1283976237-6067-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1283976237-6067-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Sep 12, 2010 at 05:17:57AM -0400, Jean Delvare wrote:
> On Fri, 10 Sep 2010 11:23:59 -0700, Guenter Roeck wrote:
> > On Fri, 2010-09-10 at 10:45 -0400, Jean Delvare wrote:
> > > On Fri, 10 Sep 2010 06:33:10 -0700, Guenter Roeck wrote:
> > > > I don't have a svn account, as least not to my knowledge.
> > > > Guess it is time to create one for me.
> > > 
> > > Oh, good point. I've moved you to the lm-sensors commiters group, so it
> > > should be OK now. Use the same login and password as for the wiki.
> >
> > Unfortunately we are behind a proxy, and svn doesn't seem to like that.
> > And https doesn't work, as it looks like because of a problem with svn
> > on Ubuntu Lucid :-(.
> > 
> > I'll keep playing with it.
> 
> If there's anything that can be done on the server side that would make
> it easier for you, please let me know and we can ask Axel Thimm (the
> lm-sensors.org server admin, Cc'd) if he can help.
> 
I managed to commit using http by switching to another system.
Turns out the culprit was not the proxy, but NAT.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
