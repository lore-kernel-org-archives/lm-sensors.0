From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 26 Sep 2006 16:56:35 +0000
Subject: [lm-sensors] SVN/trac requests
Message-Id: <20060926185635.ffc78804.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060926140502.00d29dd5.khali@linux-fr.org>
In-Reply-To: <20060926140502.00d29dd5.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Hi,
> 
> On Tue, Sep 26, 2006 at 02:05:02PM +0200, Jean Delvare wrote:
> > I have the two following requests with regards to lm-sensors' SVN/trac:
> > 
> > 1* Can the "V-2-3-1" tag be renamed to "V2-3-1"?
> 
> Yes, the contents of "tags" is (for svn) just another folder, so just
> as you rename conventional files/folders under svn you ranme this one,
> too, e.g. "svn mv V-2-3-1 V2-3-1; svn ci ." in the tags folder should
> be enough.

Yeah, it worked :) Thanks! I expected something more obscure. In fact I
didn't expect it to be possible from the client side. Now the only
drawback is that the timestamp on the renamed directory changed, but
that's a minor annoyance we should be able to live with.

> > 2* We often need to ask people to try the latest version of
> > sensors-detect. For now we point them to:
> > http://www.lm-sensors.org/browser/lm-sensors/trunk/prog/detect/sensors-detect?format=txt
> > 
> > The problem is that this version of the SVN file doesn't have its
> > keywords substituted, so the version string reads:
> >   '$Revision$ ($Date$)'
> > This might become a problem in the long run when users report with this
> > version string, as we will be unable to tell what version of the file
> > they have. So, is it possible to ask trac to provide the file with
> > keywords substituted? I'm surprised this isn't the default...
> 
> Hm, I don't have a solution. First of all I wouldn't loop it through
> trac, but use the direct svn URL instead, e.g.
> 
> http://lm-sensors.org/svn/lm-sensors/trunk/prog/detect/sensors-detect

Then this is considered an external link by trac, which adds a special
icon in front of it. I linked to trac to avoid that.

> But this has the same issue, so it doesn't solve the issue at hand.
> 
> I would guess that the keyword substitution happens at the client, and
> svn/trac offer the raw contents only. :(

I guessed so, but trac could be seen as a client.

-- 
Jean Delvare

