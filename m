From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:06 +0000
Subject: sensors-detect
Message-Id: <20030721145118.61b4df46.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030610192542.766e220d.khali@linux-fr.org>
In-Reply-To: <20030610192542.766e220d.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > I think it's generally a good idea to detect
> > many chips even if we don't have drivers for them

> agreed - that's why we have a separate column in the new drivers page
> for whether the chip is detected. you can put 'CVS' or a release
> number in that column too.

Argh. I remember I removed this information at the time I cleaned up the
new drivers page. That's partly because I was thinking only really new
drivers (CVS) should be on that page, partly because the info was always
the same as in the "first release" column. About that, I agree that we
can leave recent drivers on that page even if they are already present
in the latest release.

I'll update the new drivers page today and leave drivers that were added
in 2.7.0 and 2.8.0 there. I'll move every other to the supported devices
pages, that I will update too.

Back to the use a revision number in the "detected" column, I think we
can live without it. I agree that users need to know from which version
a given chip is *supported*. But I don't think they care about the first
release since a chip is *detected*. Having his or her chip detected is
useless unless it's also supported by a driver. What's more, it's always
possible to run a recent sensors-detect on an older release of
lm_sensors, since the script is mostly independant, so someone
interested in chip detection will always want the very latest
sensors-detect anyway. If one really wants the
detected-since-this-release info, he/she can simply look at the CHANGES
file or the CVS logs.

So I think I won't bring the information back.

Also, I think I'll make the "supported devices" page look much like the
"new drivers page", which I find clearer.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
