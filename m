From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:31 +0000
Subject: 405 i2c patch
Message-Id: <3CB35B74.2954C288@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3CAE05EB.F2EC7BF8@paradyne.com>
In-Reply-To: <3CAE05EB.F2EC7BF8@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Phil,
For this 405 patch, is it possible for you to do renames in CVS and save
the history? Is it worth it?
Or should I just remove the old and add the new?


BTW the // comments were in the old 405 files so I guess I won't
reject the patch for that.


frodol@dds.nl wrote:
> 
> phil@netroedge.com wrote:
> >
> >
> > A while ago we converted any // comments to the /* */ kind.  I think
> > Frodo had some good reasons for doing this, although I don't remember
> > right now what they were.  Perhaps it is for compiler compatibility?
> > I guess if for nothing else, it would be nice to convert those for
> > consistency sake.
> 
> // is not ISO-C. GCC accepts it, though, but some versions emit warnings,
> depending on compiler flags.
>
