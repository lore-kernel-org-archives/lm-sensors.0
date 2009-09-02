From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 02 Sep 2009 13:04:56 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: include <linux/io.h> instead of
Message-Id: <20090902150456.6c3c0767@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <BD79186B4FD85F4B8E60E381CAEE190901BE9DA3@mi8nycmail19.Mi8.com>
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE190901BE9DA3@mi8nycmail19.Mi8.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: H Hartley Sweeten <hartleys@visionengravers.com>
Cc: lm-sensors@lm-sensors.org, mactel-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, alistair@devzero.co.uk, nicolas@boichat.ch, juergh@gmail.com, frank@f-seidel.de, jim.cromie@gmail.com, mhoffman@lightlink.com, vt8231@hiddenengine.co.uk

On Thu, 13 Aug 2009 16:56:56 -0400, H Hartley Sweeten wrote:
> Drivers should be including <linux/io.h> instead of <asm/io.h>.
> 
> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Alistair John Strachan <alistair@devzero.co.uk>
> Cc: Nicolas Boichat <nicolas@boichat.ch>
> Cc: Juerg Haefliger <juergh@gmail.com>
> Cc: Jean Delvare <khali@linux-fr.org>
> Cc: Frank Seidel <frank@f-seidel.de>
> Cc: Jim Cromie <jim.cromie@gmail.com>
> Cc: "Mark M. Hoffman" <mhoffman@lightlink.com>
> Cc: Roger Lucas <vt8231@hiddenengine.co.uk>

Applied, thanks.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
