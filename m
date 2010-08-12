From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 12 Aug 2010 07:57:48 +0000
Subject: Re: [lm-sensors] [PATCH] x86,
Message-Id: <20100812095748.021e10e5@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 4 Aug 2010 09:52:36 +0200, Harald Welte wrote:
> On Tue, Aug 03, 2010 at 05:03:44PM -0700, H. Peter Anvin wrote:
> > The via-cputemp hwmon driver was probably intending "typedef enum {
> > ... } SHOW;", but the "typedef" was missing creating a global variable
> > named "SHOW".  There is absolutely no reason to have this in the
> > global namespace.
> 
> good catch, thanks for the cleanup
> 
> Acked-By: Harald Welte <HaraldWelte@viatech.com>

Applied, thanks.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
