From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Wed, 16 Dec 2009 19:23:34 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] Wrong ADT7462_VOLT_COUNT for
Message-Id: <20091216192334.GC10356@tux1.beaverton.ibm.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <AFEAE911EE22F64BACAB05ED86B4D4FC018DA312@EXVBE012-13.exch012.intermedia.net> <AFEAE911EE22F64BACAB05ED86B4D4FC018DA31A@EXVBE012-13.exch012.intermedia.net>
In-Reply-To: <AFEAE911EE22F64BACAB05ED86B4D4FC018DA31A@EXVBE012-13.exch012.intermedia.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ray Copeland <ray.copeland@aprius.com>
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, Arvind Vasudev <arvind.vasudev@aprius.com>

On Wed, Dec 16, 2009 at 09:58:32AM -0800, Ray Copeland wrote:
> From: Ray Copeland <ray.copeland@aprius.com>
> Date: Wed, 16 Dec 2009
> Subject: [PATCH 1/2] Wrong ADT7462_VOLT_COUNT for linux-2.6.30 adt7462 hwmon driver 
> 
> Description:
> 
> The #define ADT7462_VOLT_COUNT is wrong, it should be 13 not 12. All the 
<snip>
> -#define ADT7462_VOLT_COUNT	13
> +#define ADT7462_VOLT_COUNT	12

Uh... I think this patch is reversed?  This part of the diff replaces 13 with
12, which is the opposite of what I think you want.

--D

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
