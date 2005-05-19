From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:22 +0000
Subject: RPM spec file patches for i2c and lm_sensors 2.8.1
Message-Id: <20031028231601.71428e00.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <9D8C1A43309BAD4A9B46071DAF911D9E13FDA5@exch01.paracel.com>
In-Reply-To: <9D8C1A43309BAD4A9B46071DAF911D9E13FDA5@exch01.paracel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I had to make these changes to be able to build i2c and lm_sensors
> rpms that worked.  Also, lm_sensors.init isn't included in any of the
> rpms.  Looks like nobody's touched these for several versions.

You're right, the files were untouched since May 2000. Quite a while
actually. We don't build RPMs anymore. I personnaly consider that this
is the distributor's job, not our. They do that much better than we
would.

> i2c.spec:
> 
> 25c27
> < %define ver 2.8.1
> ---
> > %define ver 2.5.0
> (...)

Please provide unified diffs if you want me to apply them to our files.

You could also consider getting in touch with Axel, who is building
quality RPM packages from our sources, using his own .spec files. Maybe
you both will agree on some version of the spec files that we should
include in our source files. Or maybe we should simply remove the RPM
directory from our source trees - that would be more honest IMHO, since
nobody here seems to be wanting to maintain them, while Axel is doing a
very great job on his side. Let packagers package, that's their job :)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
