From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Tue, 16 Oct 2007 01:13:02 +0000
Subject: Re: [lm-sensors] [ patch .24-rc0 5/5 ] SuperIO locks coordinator -
Message-Id: <20071016011302.GA3731@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <4712F66F.8040806@gmail.com>
In-Reply-To: <4712F66F.8040806@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi David:

> > On Sun, Oct 14, 2007 at 11:34:11PM -0700, David Hubbard wrote:
> > > $ git clone http://lm-sensors.org/kernel?p=kernel/mhoffman/hwmon-2.6.git
> > > hwmon.git
> > > Initialized empty Git repository in hwmon.git/.git/
> > > Cannot get remote repository information.
> > > Perhaps git-update-server-info needs to be run there?
> > >
> > > Axel, is this something easy to fix on the server side?

That's a gitweb URL, for browsers.  You can't 'git clone' from that.

> On 10/15/07, Axel Thimm <Axel.Thimm@atrpms.net> wrote:
> > Looks more like a broken URL, where did you get the above? The correct
> > one is:
> > git://lm-sensors.org/kernel/mhoffman/hwmon-2.6.git

This is correct.  Also, I gave some step-by-step instructions in an earlier
message to Hans:

http://lists.lm-sensors.org/pipermail/lm-sensors/2007-October/021440.html

* David Hubbard <david.c.hubbard@gmail.com> [2007-10-15 11:35:54 -0600]:
> I can't connect to any git servers on the git port. Can you please
> look at the http url?

At the moment, you can get by without git by grabbing the 2.6.23-git8 patch
from kernel.org.  That includes all the patches I've accepted up to now.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
