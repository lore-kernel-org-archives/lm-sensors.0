From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 26 Jun 2006 19:56:08 +0000
Subject: [lm-sensors] snapshot generation
Message-Id: <20060626215608.f453912d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <449D304E.5070603@sh.cvut.cz>
In-Reply-To: <449D304E.5070603@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Axel,

> > I'm attaching a script that creates snapshots from SVN. It seems there is no
> > crontab available on the server, so I'm asking you kindly to run it somewhere.
> > 
> > The script is fairly simple, it just needs to know the target dir, plus the dir
> > where will be the script/temp repo placed. Check first few lines of script please
> > 
> > It may be executed with lm-sensors or i2c as parameter. We would like to have
> > daily snapshots for lm-sensors and weekly for i2c if possible.
> 
> OK. Would it perhaps make sense to have tarballs on demand? I'm doing
> this for ivtv and you get the tarballs for possible branches (and even
> tags aka releases) for free, too.

Either way is fine with me. We don't need both. We don't use branches
either. So, whatever is easier for you.

For releases, it would make more sense to have a "static" download
area, like we had on the old site:
http://secure.netroedge.com/~lm78/archive/
So that we can also sign the archives. Can we have such a download area
on the new site?

It would also be convenient if we could have a "Download" link it
trac's top bar, as this is clearly one of the most popular page. Is it
possible? I'm surprised there isn't one by default.

Thanks,
-- 
Jean Delvare

