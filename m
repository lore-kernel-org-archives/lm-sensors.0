From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 04 Jul 2008 07:06:38 +0000
Subject: Re: [lm-sensors] Support for f75375s (Fintek) sensor
Message-Id: <20080704090638.0e5b1210@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <590975.4376.qm@web32401.mail.mud.yahoo.com>
In-Reply-To: <590975.4376.qm@web32401.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 03 Jul 2008 22:24:42 +0200, Hans de Goede wrote:
> Sundar Narayanaswamy wrote:
> > Hi,
> > I saw an earlier discussion about adding support for F75375S
> > sensor in lm_sensors. Is there a patch available for that sensor ?
> > I tried 2.10.7 lm_sensors, but I don't believe the changes
> > are in that version. Any additional information would be appreciated.
> > 
> 
> According to:
> http://lm-sensors.org/wiki/Devices
> 
> That chip is supported in kernel 2.6.24 and later, I dunno if it is supported 
> in lm_sensors-2.10.x, but it should work fine with lm_sensors-3.0.x

I confirm it's not supported in 2.10.7. If anyone want support for that
driver in the legacy branch, send a patch. But better just upgrade to
3.0.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
