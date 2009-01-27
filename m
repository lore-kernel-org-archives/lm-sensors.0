From: Volker Kuhlmann <list0570@paradise.net.nz>
Date: Tue, 27 Jan 2009 10:40:41 +0000
Subject: Re: [lm-sensors] Updated fancontrol script
Message-Id: <20090127104041.GA12721@paradise.net.nz>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090102221548.GA19021@paradise.net.nz>
In-Reply-To: <20090102221548.GA19021@paradise.net.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

> > I have updated my improved/extended fancontrol script with the changes
> > from 0.63 to 0.67 of the "official" script. It's backwards compatible.
> 
> Someday we should get rid of these version numbers. Referring to the
> version of the lm-sensors package is much easier IMHO.

No opinion, no difference to me... ;)

> > http://volker.top.geek.nz/linux/tech/lm_sensors/fancontrol-1.1

> If you want us to take anything from you, please send patches against
> our latest version of fancontrol. Preferably incremental ones.

Sure, patch is easy:

  cp whatever-your-latest-version-is-cvs-or-stable fancontrol.orig
  wget http://volker.top.geek.nz/linux/tech/lm_sensors/fancontrol-1.1
  diff -u fancontrol.orig fancontrol-1.1

Adjust diff format to personal taste. However the resulting patch would
be much bigger than either script by itself, so wouldn't really be that
useful. I did quite a bit of tidying up.

HTH,

Volker

-- 
Volker Kuhlmann			is list0570 with the domain in header
http://volker.dnsalias.net/	Please do not CC list postings to me.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
