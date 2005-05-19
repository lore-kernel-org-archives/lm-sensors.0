From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:42 +0000
Subject: Last call 2.7.0
Message-Id: <3DE2BB4D.A6B73F17@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

everything should be in by now.
Please review / update documentation for dependencies on i2c, etc.
I already took a shot at README, INSTALL, QUICKSTART.
Please test compilation/installation on 2.2/2.4.
Would like to give Phil the goahead on Thursday or Friday.
thanks
mds


Jean Delvare wrote:
> 
> > i2c-proc.[ch] were moved from lm_sensors to i2c in 2.6.0.
> > This allowed other drivers (particularly non-sensors drivers)
> > to easily use our /proc interface.
> >
> > One unfortunate consequence was increased dependencies on i2c.
> > But I don't think we want to take i2c-proc back.
> 
> Not i2c-proc in its whole, only the incriminated macros.
> 
> Maybe a good solution to prevent us from breaking the dependencies for a
> single macro would be to define it in both i2c (for the long term) and
> lm_sensors (in some compatibility header file, for the short term, with
> the appropriate #ifndef to prevent redundant declarations). The same
> header file could serve the same puprose if the occasion arise again.
> 
> Anyway, I am simply suggesting this in case we *don't* want to break
> dependencies. If we decide we don't care, all this makes little sense.
> Personaly I don't care, I'll always have an up-to-date i2c ;)
> 
> > 2.1, 2.3, 2.5 were not considered unstable for us.
> 
> OK, so the debate is over for this part. Now it's between 2.6.6 and
> 2.7.0, and I am definitely not the one who can decide. I think we've
> been discussing enough and it's time to make our mind and prepare for
> the release.
