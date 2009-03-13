From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 13 Mar 2009 16:29:08 +0000
Subject: Re: [lm-sensors] Revision of sensors-detect
Message-Id: <20090313172908.28b73102@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090312131620.29f81395@hyperion.delvare>
In-Reply-To: <20090312131620.29f81395@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Axel,

Thanks for your quick answer.

On Thu, 12 Mar 2009 19:41:30 +0200, Axel Thimm wrote:
> Hi,
> 
> On Thu, Mar 12, 2009 at 01:16:20PM +0100, Jean Delvare wrote:
> > Hi Axel,
> > 
> > We often ask our users to test the latest version of sensors-detect.
> > They typically get it from SVN through the trac interface:
> >   http://www.lm-sensors.org/browser/lm-sensors/trunk/prog/detect/sensors-detect?format=txt
> > Unfortunately, trac doesn't honor keyword substitutions, so when the
> > user reports the output, we get:
> > 
> > # sensors-detect revision $Revision$
> > 
> > Not very useful. The bug (or at least missing feature) has already been
> > reported upstream 5 years ago, and I've added a comment there yesterday:
> >   http://trac.edgewall.org/ticket/717#comment:10
> > I don't expect this ticket to get fixed soon.
> > 
> > An alternative is to use the SVN web interface:
> >   http://www.lm-sensors.org/svn/lm-sensors/trunk/prog/detect/sensors-detect
> > Unfortunately there is no keyword substitution there either. Does
> > anyone know if there is a way to enable it?
> 
> I don't know, but that would be the best solution. Anyone with more
> svn (web) experience under the belt?

I tried asking on IRC but didn't get any useful answer. That's
unfortunate because that would clearly have been the best solution.

> > If not, it would be nice to have a workaround. I have one, which is a
> > simple CGI script which fetches the file using the svn command line
> > client and prints its contents:
> > 
> > #!/bin/sh
> > echo "Content-type: text/plain"
> > echo
> > svn cat http://www.lm-sensors.org/svn/lm-sensors/trunk/prog/detect/sensors-detect
> > 
> > I've tested it locally and it works fine for me. I could run it on my
> > home server, however I think it is better for the users if they get the
> > script from lm-sensors.org. They really have no reason to trust my
> > personal server (which may also disappear someday.)
> > 
> > Axel, is there a chance we could run this CGI script on lm-sensors.org
> > and point users to it when we want them to test the latest version of
> > sensors-detect?
> 
> I think I'd rather prefer a static solution, e.g. create a daily
> checkout w/ keyword substitution. Could be part of the snapshot
> creation script.

It isn't uncommon that I commit a fix and ask a user to give it a try
right away. Having to wait for one day would be inconvenient in this
case. I can live with it if there's no other way (that's probably
better than the current situation) but I'd prefer a more frequent
update rate.

Wouldn't it be possible to add an exception for sensors-detect to the
post-commit hook? If file = sensors-detect then run "svn cat
sensors-detect > some path" or something? That way we would ensure
there is no delay between the commit and the snapshot, and also no
daily checkout when the file doesn't change.

> CGIs are nasty in the sense that for security one may turn it off on a whitelist
> basis (actually nothing uses CGI currenlty) and a simply CGI script
> could be forgotten in a server update/hardening messing up the
> download.

This wouldn't be a critical CGI, so if it breaks, we can simply fix it
when we notice the breakage. But anyway, as the server admin it's up to
you. If you say no CGI then no CGI.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
