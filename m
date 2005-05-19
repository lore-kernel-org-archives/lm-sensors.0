From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:27 +0000
Subject: Call for 2.8.2 soon
Message-Id: <20031130170925.30157a7a.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3FC1646D.18B8555A@paradyne.com>
In-Reply-To: <3FC1646D.18B8555A@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Here comes my TODO list:
> 
> 1* /proc write problem in libsensors.
> 2* Get rid of dmidecode dependency in sensors-detect.
> 3* Remove ACPI method in sensors-detect, leave only VPD in.
> 4* The limit init removal left a few variables unused. Fix that.
> 5* Sysfs support in sensors-detect?
> 
> Point #1 can obviously be postponed, since it's probable I won't find
> the solution in time.
> Point #5 would require me to have a working Linux 2.6.0-testX kernel,
> which I don't really have at the moment.

Everything but #1 is done. I added code to catch problem #1 (embraced
with #ifdef DEBUG), it doesn't have to be fixed before we release 2.8.2.
If another user complains someday, we'll have him/her compile with
DEBUG=1 and see.

I have two new items on my TODO list:
6* Unknown adapters in sensors.
7* Addresses exclusion mechanism in sensors-detect.

Should be quite easy, after that we can release if everyone's OK.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
