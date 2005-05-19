From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:36 +0000
Subject: [PATCH] i2c driver fixes for 2.6.1
Message-Id: <20040120230322.24cbe005.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <10745567571488@kroah.com>
	<1074556757661@kroah.com>
In-Reply-To: <1074556757661@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>, Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com

Quoting myself:

> (...) Greg, could
> you please apply the following patch to the "porting-clients" document
> so that at least the new drivers don't need to be converted
> afterwards?
> 
>  Documentation/i2c/porting-clients |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletion(-)
> 
> 
> diff -Nru a/Documentation/i2c/porting-clients b/Documentation/i2c/porting-clients
> --- a/Documentation/i2c/porting-clients	Mon Jan 19 15:33:17 2004
> +++ b/Documentation/i2c/porting-clients	Mon Jan 19 15:33:17 2004
> @@ -92,7 +92,10 @@
>    i2c_get_clientdata(client) instead.
>  
>  * [Interface] Init function should not print anything. Make sure
> -  there is a MODULE_LICENSE() line.
> +  there is a MODULE_LICENSE() line. MODULE_PARM() is replaced
> +  by module_param(). Note that module_param has a third parameter,
> +  that you should set to 0 by default. See
> include/linux/moduleparam.h+  for details.
>  
>  Coding policy:

On second thought I think I shouldn't have done that change. I2c chip
drivers use SENSORS_INSMOD_* macros which in the end include
MODULE_PARM() calls.

Quoting Rusty Russell: "However, I never implemented mixing old
and new style in the same module, so if you're adding a parameter, it
makes sense to convert them all."

So maybe I shouldn't suggest that new drivers use the new style, since
they will mix old and new in this case. What about forgetting about that
doc change for now? Sorry for the trouble, I should have thought about
that before submitting.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
