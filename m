From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:04 +0000
Subject: About to release
Message-Id: <20030707154107.556a1372.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Agreed, I think the last thing is fixing the perl problem in
> sensors-detect.

Hopefully fixed. I had no answer from Jim Morris, but I really expect my
fix to make everyone happy (old Perls as well as brand new UTF-8
systems).

> Let's not check in anything else except for that fix and
> documentation updates.

I finished committing my code changes, and I updated some docs. Let's
freeze the CVS now (except for necessary bugfixes of course). There is
no need to worry anyway. I think we'll have a 2.8.1 release rather soon
after 2.8.0, after the first wave of bug reports will have crushed on
our mailing list. This has been almost 7 months since 2.7.0 was released
and I think this is way too much.

Phil (Edelbrock), are you ready for a release?

Do we have any reason to wait for Mark Hoffman's return before releasing
(I don't see any)?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
