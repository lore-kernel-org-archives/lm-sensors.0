From: Axel.Thimm@ATrpms.net (Axel Thimm)
Date: Tue, 26 Sep 2006 18:27:35 +0000
Subject: [lm-sensors] SVN/trac requests
Message-Id: <20060926182735.GJ10410@neu.nirvana>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060926140502.00d29dd5.khali@linux-fr.org>
In-Reply-To: <20060926140502.00d29dd5.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Sep 26, 2006 at 05:43:46PM +0200, Michael Renzmann wrote:
> Axel Thimm wrote:
>   > Hm, I don't have a solution. First of all I wouldn't loop it through
> > trac, but use the direct svn URL instead, e.g.
> > 
> > http://lm-sensors.org/svn/lm-sensors/trunk/prog/detect/sensors-detect
> > 
> > But this has the same issue, so it doesn't solve the issue at hand.
> > 
> > I would guess that the keyword substitution happens at the client, and
> > svn/trac offer the raw contents only. :(
> 
> Keyword substitution is disabled by default and must be enabled 
> explicitly if wanted.
> 
> See: 
> http://svnbook.red-bean.com/en/1.2/svn.advanced.props.html#svn.advanced.props.special.keywords

But the file in question already has svn:keywords properly set.
-- 
Axel.Thimm at ATrpms.net
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060926/2bda417a/attachment.bin 
