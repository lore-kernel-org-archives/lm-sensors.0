From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Tue, 29 Jan 2008 12:38:48 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (it87) Delete pwmN_freq files on
Message-Id: <20080129123848.GI29892@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071214144153.222cd653@hyperion.delvare>
In-Reply-To: <20071214144153.222cd653@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean:

* Jean Delvare <khali@linux-fr.org> [2007-12-14 14:41:53 +0100]:
> In commit f8d0c19a93cea3a26a90f2462295e1e01a4cd250 I forgot to delete
> the pwmN_freq files on driver removal, here's the fix.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> ---
>  drivers/hwmon/it87.c |    3 +++
>  1 file changed, 3 insertions(+)

Applied to hwmon-2.6.git/testing, thanks.

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
