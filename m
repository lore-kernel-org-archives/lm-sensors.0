From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:39 +0000
Subject: fscpos driver
Message-Id: <6MSzDBjt.1109314195.9808650.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050104185338.3296d72d.khali@linux-fr.org>
In-Reply-To: <20050104185338.3296d72d.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Stefan,

On 2/25/2005, "Stefan Ott" <ott5@desire.ch> wrote:

> I was wondering whether there was a specific reason, maybe some kind of
> policy I'm not aware of, why the fscpos driver hasn't been added to the
> kernel yet.

It actually has been, just not in Linus' tree yet. Your fscpos driver is
in Andrew Morton's kernels since 2.6.11-rc2-mm1. First it needed to get
some testing there, and now we are next to the 2.6.11 release so Linus
is only accepting bugfixes. Soon after 2.6.11 is released (and it should
be quite soon now), I'd expect Grek KH to send an i2c update to Linus
with all the patches that have been in -mm for quite some time,
including your fscpos driver.

--
Jean Delvare
