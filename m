From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 26 Mar 2008 10:08:14 +0000
Subject: Re: [lm-sensors] [PATCH 1/3] hwmon (dme1737): demacrofy for
Message-Id: <20080326110814.5116bf89@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <47E9D5BE.8020905@gmail.com>
In-Reply-To: <47E9D5BE.8020905@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Juerg,

On Tue, 25 Mar 2008 21:49:02 -0700, Juerg Haefliger wrote:
> This patch gets rid of a couple of macros previously used for sysfs 
> attribute generation and manipulation. This makes the source a little 
> bigger but a lot more readable and maintainable. It also fixes an issue 
> with pwm5 & pwm6 attributes not being created read-only initially.

Note that separate patches are preferred in this case, to better
differentiate bug fixes (which distributions might want to backport)
from code cleanups.

> Signed-Off-By: Juerg Haefliger <juergh at gmail.com>

Looks OK to me.

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
