From: Axel.Thimm@ATrpms.net (Axel Thimm)
Date: Tue, 26 Sep 2006 19:32:35 +0000
Subject: [lm-sensors] SVN/trac requests
Message-Id: <20060926193235.GP10410@neu.nirvana>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060926140502.00d29dd5.khali@linux-fr.org>
In-Reply-To: <20060926140502.00d29dd5.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

On Tue, Sep 26, 2006 at 09:23:00PM +0200, Jean Delvare wrote:
> > On Tue, Sep 26, 2006 at 07:10:22PM +0200, Jean Delvare wrote:
> > > > Axel Thimm wrote:
> > > >   > Hm, I don't have a solution. First of all I wouldn't loop it through
> > > > > trac, but use the direct svn URL instead, e.g.
> > > > > 
> > > > > http://lm-sensors.org/svn/lm-sensors/trunk/prog/detect/sensors-detect
> > > > > 
> > > > > But this has the same issue, so it doesn't solve the issue at hand.
> > > > > 
> > > > > I would guess that the keyword substitution happens at the client, and
> > > > > svn/trac offer the raw contents only. :(
> > 
> > > Another option is to give the users a simple svn command to type to
> > > retrieve just that file:
> > >   svn export http://lm-sensors.org/svn/lm-sensors/trunk/prog/detect/sensors-detect
> > > 
> > > However it is significantly less convenient, as the user might not have
> > > svn installed. Or maybe we can install a simple CGI script on the web
> > > server which would run this command and return the result to the
> > > user? I can't seem to find an option to output the file to stdout
> > > though, which we would need.
> > 
> > If no native solution in svn/trac is found maybe the scripts doing the
> > snapshots could extract this file w/ keywords and place it to a
> > canonical place?
> 
> This would imply up to 24h of delay before the user can pick the new
> version of the script. I'm OK with daily snapshots for the project
> itself, but sensors-detect is a bit special in that it helps us
> investigating user problems, and being able to update the script with
> new data and tell the user to try the new version the minute after is
> very convenient.

Indeed, stretching feedback cycles to 24 hours is ugly. :/

> I wouldn't bother if the script wasn't run by root. I'd make the file
> available on my server and I'd tell the users to pick it there. But
> from a security point of view, that sucks. I really want people to get
> a file from lm-sensors.org. And I want the file to come right out of
> the Subversion repository, with no man in the middle.

Still assuming there is no native way to ask trac/svn to add keyword
expansion, live cuts could be made by using svn's commit triggering
system instead of using cron.
-- 
Axel.Thimm at ATrpms.net
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060926/a629e43e/attachment.bin 
