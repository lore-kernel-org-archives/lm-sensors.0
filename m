From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Sun, 02 Mar 2008 19:48:03 +0000
Subject: Re: [lm-sensors] [patch 1/1] hwmon: add 0x8c id for
Message-Id: <20080302194803.GB5324@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Matt:

* Matt Roberds <mattroberds@cox.net> [2008-02-29 17:58:26 -0600]:
> On Fri, 29 Feb 2008, Craig Kelley wrote:
> > +       case 0x85:
> > +       case 0x8c:
> > +               name = "SCH5317";
> > +               break;
> 
> Minor style thing: would
> 
>         case 0x85:
>                 /* fall through */
>         case 0x8c:
>                 name = "SCH5317";
>                 break;
> 
> be clearer?

Yes, but only if there were some code between the two cases.  As
written, I think it's clear enough; it's a pretty standard usage.

Thanks & regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
