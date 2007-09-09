From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 09 Sep 2007 11:17:28 +0000
Subject: Re: [lm-sensors] Missing thmc50 support in sensors
Message-Id: <20070909131728.58edb10f@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070906130600.028cf7f5@hyperion.delvare>
In-Reply-To: <20070906130600.028cf7f5@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Krzysztof,

On Sun, 9 Sep 2007 10:42:20 +0200, Krzysztof Helt wrote:
> On Thu, 6 Sep 2007 13:06:00 +0200 Jean Delvare wrote:
> > In ticket #2250, someone using your new thmc50 driver is complaining
> > about the lack of pretty-print support in "sensors":
> > 
> > http://www.lm-sensors.org/ticket/2250#comment:2
>
> The current lmsensors2 displays all information it can get
> from 2.6 driver. The only problem is the lmsensors2 cannot
> get information about non-existing entries.
> 
> How can I hide entries (like die_code) which do not exist
> in the 2.6 driver?

With the current code, you can't because "sensors" has no pretty-print
routine for the thmc50/adm1022. So it falls back to the "unknown chip"
printing routine, which blindly trusts the feature list provided by
libsensors. This somewhat worked for Linux 2.4 drivers but no longer
for Linux 2.6 drivers, as you found out.

The solution is to write a pretty-print routine for the thmc50/adm1022.
Or more simply, copy and paste a similar one (for example print_lm63)
and change the symbols to the THMC50 ones. In this custom routine you
can simply omit the error messages for features which you now might be
missing for the Linux 2.6 driver.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
