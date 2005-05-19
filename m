From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:26 +0000
Subject: Call for 2.8.2 soon
Message-Id: <20031124212358.22414039.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3FC1646D.18B8555A@paradyne.com>
In-Reply-To: <3FC1646D.18B8555A@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> After -test10 comes out (assuming it has Khali's patches in it),
> then I want to fix up libsensors to match the magnitudes and sysfs
> names that test10 has in it, then release 2.8.2.

Test10 is out, without the patches. Looks like Greg wants to wait until
Linux 2.6.0 is out before applying patches again. This policy is likely
to slow down Mark's plan.

> Anything else people want to get into the next release?

Here comes my TODO list:

1* /proc write problem in libsensors.
2* Get rid of dmidecode dependency in sensors-detect.
3* Remove ACPI method in sensors-detect, leave only VPD in.
4* The limit init removal left a few variables unused. Fix that.
5* Sysfs support in sensors-detect?

Point #1 can obviously be postponed, since it's probable I won't find
the solution in time.
Point #5 would require me to have a working Linux 2.6.0-testX kernel,
which I don't really have at the moment.

Everyone add points to the list if you want.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
