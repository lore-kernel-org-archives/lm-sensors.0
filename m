From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:03 +0000
Subject: HTMLized FAQ
Message-Id: <20030701032251.GA8669@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030630185800.25a57241.khali@linux-fr.org>
In-Reply-To: <20030630185800.25a57241.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Some weeks ago, I started converting the FAQ to docbook by hand as an
exercise in learning docbook.  I'm sure there are 1001 texi-2-XML tools,
but doing it quickly wasn't the point at the time.  You can see the
results here:

http://members.dca.net/mhoffman/sensors/docbook/

The HTML is there, along with a tarball of what I used to get there.
There is also a list of RedHat 9 RPMS that I installed.  I've learned as
much about docbook as I intended without ever finishing this... but if
you think it's an improvement I'll keep on it.  FWIW I think the source
is easier to read than texi.

* Mark D. Studebaker <mds@paradyne.com> [2003-06-30 13:45:12 -0400]:
> If you think it looks better then go ahead and check it in.
> See instructions in doc/Makefile.
> The version is totally arbitrary. If you want to advance it to 2.8 go ahead.
> 
> Jean Delvare wrote:
> > 
> > I think that we should regenerate the HTML (and possibly text) version
> > of our FAQ using a newer texinfo. I gave it a try and the HTML code
> > seems to have been greatly improved.
> > 
> > And, by the way, why is the faq version set to 2.0? It should be either
> > 2.7.0 (or 2.8.0 by now) if it is supposed to match the lm_sensors
> > release number (I don't think it is) or 2.9 if it has its own numbering
> > scheme.
> > 
> > Pete, what are we supposed to fill in the EDITION and VERSION fields of
> > version.texi? (I mean, what's the difference between these fields?)
> > Also, don't you want your name to be mentioned in the file? You did a
> > great job!

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
