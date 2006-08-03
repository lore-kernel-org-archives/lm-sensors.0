From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 03 Aug 2006 16:40:14 +0000
Subject: [lm-sensors] Flex Scanner Jammed Problem
Message-Id: <20060803164013.GA3096@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <1064332995.5787.33.camel@nils>
In-Reply-To: <1064332995.5787.33.camel@nils>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean:

* Jean Delvare <khali at linux-fr.org> [2006-08-03 17:40:45 +0200]:
> > Try our latest default configuration file:
> > http://lm-sensors.org/svn/lm-sensors/trunk/etc/sensors.conf.eg
> > 
> > If that works, then the problem is definitely the configuration file you
> > created. If not... Please tell us with which versions of flex and bison
> > you built lm_sensors.
> > 
> > Note that you can use the "-c" option of "sensors" to select a
> > configuration file. This should help you test different files.
> > 
> > -- I tried the newest config file, still flex scanner jammed, working on
> > getting a copy to send to you.
> > 
> > -- using flex version 2.5.4
> > -- using bison version 1.875c
> 
> I just tried this combination but was unable to reproduce the problem.
> 
> Can you try removing the following line from lib/conf-lex.l:
> 
> %option nodefault
> 
> As I understand it, it should cause libsensors to output anything it
> doesn't understand in the config file to stdout. Maybe that will
> provide some hint. Other than that, I don't know what to suggest.

I have been watching this thread closely, even though I haven't spoken
up until now.

Version 2.5.4 of flex is current[1] (same as mine), version 1.875c of bison
is ancient (I have 2.0).  OTOH, I'm pretty sure that's irrelevant to this
problem because the "flex scanner jammed" message happens prior to the
parser (from bison) receiving the token from flex.

I.e. we both have the same version of flex; AFAICT that's all that matters.

As for the %option nodefault... I think there is some bad interaction 
between that one and %option yylineno.  Some time ago I played with
getting rid of %option yylineno (and keeping track of line numbers with
explicit rules) as a performance optimization.  As soon as I turned off
the yylineno option, flex started complaining about the nodefault option
being specified even though the default rule was still in use.  But
those two options should be unrelated... I haven't figured it out yet.

I'm not sure how helpful any of this is for the problem at hand... sorry.

Regards,

[1] Well, not really.  Flex has been updated a lot since 2.5.4, but that
all happened outside of the GNU project and I don't think any distro ships
the newer non-GNU flex versions.  If you look on ftp.gnu.org, they claim
the latest is 2.5.4.

-- 
Mark M. Hoffman
mhoffman at lightlink.com


