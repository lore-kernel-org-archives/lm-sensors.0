From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 20 Oct 2007 09:47:29 +0000
Subject: Re: [lm-sensors] PATCH: hwmon-abituguru3-new-motherboards.patch
Message-Id: <20071020114729.37e3f77f@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <47190047.6020803@hhs.nl>
In-Reply-To: <47190047.6020803@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 19 Oct 2007 21:06:47 +0200, Hans de Goede wrote:
> Hi Mark & All,
> 
> This patch adds support for 2 new motherboards to the abituguru3 driver. Its a 
> pretty trivial patch and it would be nice if this could make 2.6.24.
> 
> Signed-of-by: Hans de Goede <j.w.r.degoede@hhs.nl>

Acked-by: Jean Delvare <khali@linux-fr.org>

Out of curiosity, what's the plan to get the actual board names instead
of "unknown"? Shouldn't you ask people to report (e.g. in
Documentation/hwmon/abituguru3) when their board is listed as unknown?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
