From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Mon, 30 Jul 2007 02:00:39 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon/f71805f: List the F71805F/FG as
Message-Id: <20070730020039.GE31314@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070715103606.3375e2bb@hyperion.delvare>
In-Reply-To: <20070715103606.3375e2bb@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi:

> Jean Delvare wrote:
> >The Fintek F71806F/FG is compatible with the F71872F/FG, so it is
> >already supported by the f71805f hardware monitoring driver. In fact,
> >both chips have the same chip ID, so the driver can't even
> >differentiate between them.
> >
> >Signed-off-by: Jean Delvare <khali@linux-fr.org>

* Hans de Goede <j.w.r.degoede@hhs.nl> [2007-07-15 10:51:20 +0200]:
> Looks good to me.
> 
> Not really sure if this is appropriate:
> Acked-by: Hans de Goede <j.w.r.degoede@hhs.nl>

Applied to hwmon-2.6.git/testing, thanks.

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
