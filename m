From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Tue, 09 Oct 2007 00:59:09 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon/w83781d: Add individual alarm and
Message-Id: <20071009005909.GM3835@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071007205740.0c52f8cf@hyperion.delvare>
In-Reply-To: <20071007205740.0c52f8cf@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi:

* Hans de Goede <j.w.r.degoede@hhs.nl> [2007-10-08 20:02:22 +0200]:
> Jean Delvare wrote:
> > The upcoming libsensors 3 needs these individual alarm and beep files.
> > For the W83781D, this is quirky because this chip has a single alarm
> > bit for both temp2 and temp3.
> > 
> > Signed-off-by: Jean Delvare <khali@linux-fr.org>
> > ---
> > Second revision after Hans de Goede's review.
> > 
> 
> Looks good now:
> Acked-by: Hans de Goede <j.w.r.degoede@hhs.nl>

Applied to hwmon-2.6.git/testing, thanks.

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
