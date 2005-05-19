From: akpm@osdl.org (Andrew Morton)
Date: Thu, 19 May 2005 06:24:45 +0000
Subject: i2c patch out of 2.6.4-rc1-mm1
Message-Id: <20040301122207.0bebef9a.akpm@osdl.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1078150396.404344fc41690@imp.gcu.info>
In-Reply-To: <1078150396.404344fc41690@imp.gcu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare <khali@linux-fr.org> wrote:
>
>  I just saw that the i2c stuff from Greg's tree have been backed out
>  from 2.6.4-rc1-mm1. Quoting the release notes:
> 
>  "bk-i2c.patch was dropped pending it getting its lmsensors act
>  together."
> 
>  I don't quite understand what I am (well, what we are...) supposed to
>  do (actually, I do not even get the meaning of the sentence itself).

It's no big deal.  The current misfit between i2c and the rest of Linus's
tree means that -mm users have non-working sensors code.  I don't want -mm
users to have to deal with (and report) problems like that, so I leave out
the i2c changes until things have sorted themselves out.

I don't think there's any rush on fixing this up - whenever you guys are
ready.
