From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Sat, 06 Oct 2007 19:33:17 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Kconfig dependency cleanups
Message-Id: <20071006193317.GA3835@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070829121900.63b7ae85@hyperion.delvare>
In-Reply-To: <20070829121900.63b7ae85@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi:

* Hans de Goede <j.w.r.degoede@hhs.nl> [2007-10-06 08:36:23 +0200]:
> Hi All,
> 
> In this post:
> http://lists.lm-sensors.org/pipermail/lm-sensors/2007-August/021089.html
> 
> Jean Delvare wrote:
> --------------------------------------------
> * Drop HWMON from the dependency list of ABITUGURU3 and LM93: this is
>    now handled at menu level.
> * Make the Abit, Asus and FSC chip drivers depend on X86. These are
>    custom chips which can only be found on their respective manufacturer's
>    systems, and these manufacturers only do x86 hardware AFAIK.
> 
> Signed-off-by: Jean Delvare <khali at linux-fr.org>

(...)

> Acked-by: Hans de Goede <j.w.r.degoede@hhs.nl>


Applied to hwmon-2.6.git/testing, thanks.

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
