From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Sun, 07 Oct 2007 19:33:01 +0000
Subject: Re: [lm-sensors]
Message-Id: <20071007193301.GC3828@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <87ekb9s3tn.wl%info@wore.ma.cx>
In-Reply-To: <87ekb9s3tn.wl%info@wore.ma.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans:

* Hans de Goede <j.w.r.degoede@hhs.nl> [2007-10-07 20:38:07 +0200]:
> Mark M. Hoffman wrote:
> >Hi Jean:
> >
> >>Jean Delvare wrote:
> >>>Additionally, I think that the examples are a bit difficult to read,
> >>>one level of indentation would probably be better than the begin/end
> >>>code markers. Thus, I propose the following incremental patch:
> >>>
> >>> Documentation/hwmon/sysfs-interface |   30 
> >>> ++++++++++++++----------------
> >>> 1 file changed, 14 insertions(+), 16 deletions(-)
> >
> >* Hans de Goede <j.w.r.degoede@hhs.nl> [2007-10-07 13:37:53 +0200]:
> >>I agree with all changes, Mark pleaee apply:
> >>
> >>Acked-by: Hans de Goede <j.w.r.degoede@hhs.nl>
> >
> >Could you please re-generate this one against the hwmon testing tree and
> >w/ a Signed-off-by?
> >
> 
> I must admit I'm a total git noob, can you give me a git one liner to get 
> your testing tree (IOT the "cvs co" equivalent of git)?

Sorry I was ambiguous... I was asking for Jean to do this since it was his
patch.  Really, I just need his Signed-off-by - I can take care of the rest.

Nonetheless, here's what you do...

1) Make a clone of my repo:

$ git clone git://lm-sensors.org/kernel/mhoffman/hwmon-2.6.git hwmon.git

2) cd to it

$ cd hwmon.git

3) You can list my public branches like this:

$ git branch -r

(mnemonic '-r' for remote)

4) You can checkout and create a local branch which is based on a remote
branch, e.g.

$ git checkout -b testing origin/testing

At this point, you've done the "cvs co" equivalent; you can ignore git now
and create patches based on this if you prefer.

* * * * *

Although, I suppose it would be easier for you and maybe Jean if I just publish
a patch series myself.  It shouldn't be too hard to script that up; I'll look
into it.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
