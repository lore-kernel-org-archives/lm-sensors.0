From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 01 Oct 2008 08:37:34 +0000
Subject: Re: [lm-sensors] [PATCH] new hwmon driver adt7462
Message-Id: <20081001103734.29608fc2@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081001065413.GG10750@tree.beaverton.ibm.com>
In-Reply-To: <20081001065413.GG10750@tree.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Darrick J. Wong" <djwong@us.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, lm-sensors <lm-sensors@lm-sensors.org>, linux-kernel <linux-kernel@vger.kernel.org>, Eric Olsen <eolsen@google.com>

Hi Darrick,

On Tue, 30 Sep 2008 23:54:14 -0700, Darrick J. Wong wrote:
> New driver to feed on.  As Jean mentioned a couple of years ago, this
> chip is a beast with odd combinations of 8 fans, 4 temperatures, and
> 13 voltage sensors.  This driver has been tested on an IntelliStation
> Z30.
> 
> Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>
> ---
> 
>  Documentation/hwmon/adt7462 |   67 +
>  drivers/hwmon/Kconfig       |   10 
>  drivers/hwmon/Makefile      |    1 
>  drivers/hwmon/adt7462.c     | 1991 +++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 2069 insertions(+), 0 deletions(-)

Two years ago, Eric Olsen (Cc'd) asked for support for this device and
even said he would write the driver himself. We didn't hear from him
since then. Now that we have a driver, maybe Eric can help testing it
and maybe even reviewing it?

I clearly do not have the time for this myself (not on my free time, at
least.)

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
