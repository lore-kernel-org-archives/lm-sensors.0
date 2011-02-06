From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 06 Feb 2011 20:18:29 +0000
Subject: Re: [lm-sensors] cannot start lm_sensors daemon on Fedora 14 on AMD
Message-Id: <20110206211829.021cccbc@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <AANLkTim1aYMz+PGQnBLVkcZjmgRKa_HOS86rgQsDM-58@mail.gmail.com>
In-Reply-To: <AANLkTim1aYMz+PGQnBLVkcZjmgRKa_HOS86rgQsDM-58@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 6 Feb 2011 19:46:57 +0200, Daniil Ivanov wrote:
> Just forgot to mention that adding
> HWMON_MODULES="k10temp"
> to the /etc/sysconfig/lm_sensors solved the problem,
> but I should not edit configuration files manually.

Please don't top-post.

Did by any chance Fedora blacklist the k10temp driver, preventing it
from loading automatically? Check with:

$ /sbin/modprobe -c | grep k10temp

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
