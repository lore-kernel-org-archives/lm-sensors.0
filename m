From: willy@w.ods.org (Willy TARREAU)
Date: Thu, 19 May 2005 06:25:41 +0000
Subject: [PATCH-2.4] build fix for amd756 in sensors 2.9
Message-Id: <20050306105757.GA4805@pcw.home.local>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050306103039.GA18356@alpha.home.local>
In-Reply-To: <20050306103039.GA18356@alpha.home.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Salut Jean,

On Sun, Mar 06, 2005 at 11:49:11AM +0100, Jean Delvare wrote:
> Except that this wouldn't be correct. i2c-amd756 doesn't belong to the
> main 2.4 kernel tree, it's added there by the sensors patch. So the
> correct fix was to teach the lm_sensors patch maker how to properly add
> an export declaration for i2c-amd756.
> 
> If you regenerate the sensors patch from lm_sensors CVS and apply it
> instead of the patch generated from lm_sensors 2.9.0, it should just
> work.

That's what I did indeed, but did not notice the export-objs += i2c-amd756.o
hidden between several obj-* lines ;-)

Thanks, I don't need this patch anymore.

Cheers,
Willy
