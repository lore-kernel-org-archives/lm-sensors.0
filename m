From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Sun, 26 Aug 2007 18:50:24 +0000
Subject: Re: [lm-sensors] [PATCH] Don't export thermistor beta
Message-Id: <20070826185024.GE3679@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070816143001.461f92e2@hyperion.delvare>
In-Reply-To: <20070816143001.461f92e2@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Hans de Goede <j.w.r.degoede@hhs.nl> [2007-08-16 17:01:25 +0200]:
> Jean Delvare wrote:
> >Deprecate the use of thermistor beta values as thermal sensor types.
> >No driver supports changing the beta value anyway.
> >
> >Signed-off-by: Jean Delvare <khali@linux-fr.org>
> 
> Looks good to me:
> Acked-by: Hans de Goede <j.w.r.degoede@hhs.nl>

Applied to hwmon-2.6.git/testing, thanks.

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
