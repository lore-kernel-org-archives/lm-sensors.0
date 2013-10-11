From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 11 Oct 2013 06:14:56 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: (lm90) Add support for TI TMP451
Message-Id: <20131011081456.28371ad8@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1381297248-13375-1-git-send-email-wni@nvidia.com>
	<20131009151744.GA7787@roeck-us.net>
	<20131009173555.74c0d5f5@endymion.delvare>
	<52575B1E.60504@nvidia.com>
In-Reply-To: <52575B1E.60504-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi Wei,

On Fri, 11 Oct 2013 09:57:50 +0800, Wei Ni wrote:
> Hi, Jean, do you have git repository, so that I can clone it to get
> latest changes.

No, I don't. I'm using quilt. But at this point there's nothing in my
public quilt tree because this patch depends on another one from you
(hwmon: (lm90) split set&show temp as common codes) which I need to
update first. When this is done, they will both appear at:

http://khali.linux-fr.org/devel/linux-3/jdelvare-hwmon/

Note though that quilt patch series are not carved in stone, so just
because a patch ever appears here doesn't mean it will go upstream
unchanged (or at all.)

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
