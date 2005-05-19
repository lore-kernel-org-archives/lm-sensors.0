From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:47 +0000
Subject: [Q] lm_sensors-2.8.5 compile error.
Message-Id: <20040313104120.364792e5.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040311152913.5DC0.MYN_KIM@incrementp.co.jp>
In-Reply-To: <20040311152913.5DC0.MYN_KIM@incrementp.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Quoting myself:

> See attached patch, it should do what you need. We should have applied
> it after resolving ticket 1504 but for some reasons we did not. I'll
> do it as soon as you confirm that it worked for you.

OK, I tested it and commited to CVS.

I also noticed that there are many other things that will prevent recent
lm_sensors versions from working on older kernels (__devexit_p,
snprintf, PCI_DEVICE_ID_INTEL_82801CA_3, MODULE_LICENSE, max). Some of
them are easy to fix while others are not.

So we better don't pretend we are compatible with kernels starting with
2.4.9. From what I could see we do not properly support kernels prior to
2.4.17.

Anyway, I'm not sure that fixing this is worth anything before we also
revert the module reference count method to what it was before i2c
2.8.0, so that we are really compatible with 2.4 kernels.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
