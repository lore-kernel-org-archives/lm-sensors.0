From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Tue, 26 Feb 2008 13:14:40 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (lm75) Fix an incorrect comment
Message-Id: <20080226131440.GC2947@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080219124258.2917de6e@hyperion.delvare>
In-Reply-To: <20080219124258.2917de6e@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean:

* Jean Delvare <khali@linux-fr.org> [2008-02-19 12:42:58 +0100]:
> High-byte first is not opposite to the usual practice - that's what
> almost all hardware monitoring drivers do. It is opposite to the SMBus
> standard though.
> 
> Also delete a duplicate comment.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> ---
>  drivers/hwmon/lm75.c |    5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 

Applied to hwmon-2.6.git/testing, thanks.

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
