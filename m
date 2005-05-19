From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:09 +0000
Subject: i2c & lm_sensors for RH
Message-Id: <20030802201107.7be0ae9d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030802172008.GA10034@puariko.nirvana>
In-Reply-To: <20030802172008.GA10034@puariko.nirvana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Is anyone working on this? If not, I'd be interested (I have been
> maintaining rpms for kernel and userland parts for i2c/lm_sensors
> 2.7.0 at atrpms).

We don't build packages anymore, we leave the job to the distribution
maitainers.

> I am already trying to patch the i2c core and surrounding patches into
> the latest RH errata kernel (based on 2.4.21-pre3). I might have a
> question or two, and could use testers, since I am doing it upon
> request, and the machines I currently have available aren't that
> sensor friendly (one is a Thinkpad ...).

Questions are welcome and will be answered the best we can.

BTW: We would like packagers to report fixes they add to their packages.
I have seen many i2c and lm_sensors packages for various distributions
(Red Hat and Gentoo come to mind) including bugfixes to our code and not
letting us know about it. If you want us to fix the bugs, you have to
report, we just can track all packages all the time to see if some bugs
have been locally found and fixed.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
