From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 26 Sep 2006 17:10:22 +0000
Subject: [lm-sensors] SVN/trac requests
Message-Id: <20060926191022.995817b7.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060926140502.00d29dd5.khali@linux-fr.org>
In-Reply-To: <20060926140502.00d29dd5.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

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

Well we did enable keyword substitution for this file:
$ svn propget svn:keywords prog/detect/sensors-detect
Author Date Id Revision

And it works well on my side. What I would like is to get it to work in
trac, i.e. trac would serve keyword-substituted files rather than "raw"
files. Any idea how to do that, if possible at all?

Another option is to give the users a simple svn command to type to
retrieve just that file:
  svn export http://lm-sensors.org/svn/lm-sensors/trunk/prog/detect/sensors-detect

However it is significantly less convenient, as the user might not have
svn installed. Or maybe we can install a simple CGI script on the web
server which would run this command and return the result to the
user? I can't seem to find an option to output the file to stdout
though, which we would need.

-- 
Jean Delvare

