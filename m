From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:21 +0000
Subject: Problems using w83781d (v 2.8.0) on Asus CUV4X
Message-Id: <20031018162003.171cd86e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1066427722.8562.5.camel@localhost>
In-Reply-To: <1066427722.8562.5.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Hm, now i've found it... installation guide.
> But i thought: I read it one year before, why should i read it again?

Mouahhaha :) I already answered one e-mail today, why should I answer
this one? ;)

> You should tell the user, that so much has changed, he should take a
> look at the installation guide, if the modules fails loading.

I expect the user to come to the news page if anything goes wrong. If
the user can't think of that and read 4 lines of English (don't take it
personal ;)) that's his/her problem, not our.

> hm... somebody should tell the package-maintainers from debian that
> the i2c-source-package is redundant, when using the kernel patch and
> that those people who've problems with lm-sensors should try this
> patch. Hm.

Distribution-dependant issue, we are not the ones to blame.
Unfortunately, the packagers never get it touch with us to discuss and
solve that kind of issues (except Axel Thimm, must by why his packages
are appreciated and used by a large number of persons). I estimate they
have to come to us, not the other way around.

> Why is lm-sensors not a part of the kernel? Too young and unstable?

Mostly because it uses procfs a lot, and adding new entries to /proc is,
well... prohibited. The core and some drivers have been rewritten to use
sysfs instead, you can get them in Linux 2.6.0. The major problem now is
that our user-space tools are not aware of the change yet, so you have a
very limited usability under 2.6.0. But at least you don't have to play
with patches, everything's already included in the kernel sources.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
