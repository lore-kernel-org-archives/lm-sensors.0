From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 24 Nov 2007 10:50:43 +0000
Subject: Re: [lm-sensors] binaries for both 2.4 and 2.6
Message-Id: <20071124115043.76c7231d@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <x6wss99w1j@gzp>
In-Reply-To: <x6wss99w1j@gzp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Gabor,

On Fri, 23 Nov 2007 09:59:52 +0100, Gabor Z. Papp wrote:
> I would like to contact someone, who successfully built lm-sensors
> binaries that works both with 2.4 and 2.6 kernels.
> 
> Built went fine on 2.4, linking with sysfs, but using on 2.4 does not
> works, sensors tries accessing /sys all the time.
> 
> The same binaries works fine on 2.6.
> 
> v2.10.5

You are correct, it doesn't work for me either. I presume that you are
using sysfsutils >= 2.0.0, where libsysfs initializes successfully even
if sysfs isn't mounted. I added a workaround for this some times ago,
but unfortunately only to the lm-sensors-3.0.0 branch. I forgot to
backport the fix to SVN trunk.

This is done now, changeset is here if you want to apply it to your
local tree:
http://lm-sensors.org/changeset/5036

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
