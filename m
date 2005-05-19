From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:29 +0000
Subject: Last Call 2.8.2
Message-Id: <20031210081113.3c96dbaa.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3FD4F7A2.9070608@paradyne.com>
In-Reply-To: <3FD4F7A2.9070608@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > 2* I had a report that my checksum calculation for VPD records
> > sometimes fails. This would make us miss IBM systems. Not had the
> > time to investigate the issue yet, will do tomorrow (I hope). The
> > exact checksum method isn't decribed in IBM's doc, I thought I had
> > it correct but maybe not.

OK, done that. Seems that a few IBM systems have an incorrect VPD
checksum. This can be fixed by upgrading BIOSes, but not everybody does
that. Until I know more about the issue, I ignore incorrect VPD
checksums. This might make sensors-detect detect VPD records where they
are not, also this is unlikely (1 chance out of 2^28, as opposed to 1
out of 2^36 with the checksum, on any given system after my quick
estimations). If this ever happens, the user is invited to report so
that I can fix the problem.

Having done that, I am ready for a release.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
