From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:04 +0000
Subject: Pre-release tests
Message-Id: <20030709093309.553f8da8.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030707213700.3eef7104.khali@linux-fr.org>
In-Reply-To: <20030707213700.3eef7104.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I don't know much about #6 below but it seems like a minor issue
> we can defer until next time.

I don't think so. Old modules are not compatible, so loading them could
have unpredictable results. Let's have them deleted at install time, for
this release at least. This is the same kind of safety measure I took as
the resolution of problem #1. It just can't hurt, and should lower the
severity, if not number, of reports. And I prefer by far having reports
saying "hey, where have these module gone?" than ones saying "hey, lm
sensors crashed my system".

We'll take some time after the release to see why theses modules are so
special and what we should do with them.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
