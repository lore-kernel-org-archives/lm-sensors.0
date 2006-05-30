From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 30 May 2006 08:16:31 +0000
Subject: [lm-sensors] svn resync
Message-Id: <20060530101631.f2ae99c6.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <44621B6E.6070500@sh.cvut.cz>
In-Reply-To: <44621B6E.6070500@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Axel,

> I made a conversion, please have a look. i2c and lm-sensors are
> separated and could indeed have different commit rights as you once
> suggested.

Looks good to me.

> The "(author)" bits haven't been touched, I'll retry with the list you
> gave. Also we need to discuss how to deal with svn and trac write
> access. The idea is to use htdigest for both and not the ssh
> accounts. This is because trac doesn't deal with ssh account data and
> the account information could be shared between trac and svn (at least
> partly). But it also depends on how you'd like to have authorization
> handled in lm-sensors vs i2c.

We want very limited access to the i2c repository. Basically me, Mark
Hoffman, and that could be it. For the lm-sensors repository we want
more persons to have write access: Rudolf Marek of course, but also new
contributors. We have been quite conservative so far (I take my part of
responsability for this) and it's about time to trust good contributors
more.

As for trac, I'm not really familiar with it, but it looks to me like
users could be different from code contributors, so I'm not certain it
makes sense to have a common authentication method. What are the
benefits of using htdigest for subversion compared to ssh? Are there
drawbacks? I really don't care much as long as it works, so if others
have stronger (motivated) opinions, please speak up.

Thanks,
-- 
Jean Delvare

