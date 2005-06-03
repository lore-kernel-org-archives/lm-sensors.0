From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 03 Jun 2005 22:16:56 +0000
Subject: [lm-sensors] Re: RFC PATCH lm_sensors2: w83781d: remove non-i2c
Message-Id: <20050603221726.48d1f187.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <0cci9197ou579v4v9drecriedotimshe6i@4ax.com>
In-Reply-To: <0cci9197ou579v4v9drecriedotimshe6i@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Grant,

> Resend of patch to remove non-i2c w83697hf from w83781d driver 
> includes documentation changes as requested.
> 
> Code patch applied cleanly to this morning's CVS so I didn't 
> reboot to 2.4 to test it, added doc changes only.

Looks OK to me. I've applied it to my local working directory, and plan
to commit it, but under the two following conditions:

1* The equivalent change in Linux 2.6 has made it to a stable kernel
(presumably 2.6.13).

2* Nobody objects until then.

Thanks,
-- 
Jean Delvare
