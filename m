From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:58 +0000
Subject: Winbound W83627EHF sensor
Message-Id: <20050511191125.6406c96d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050510203454.27683f7b.medaglia@gmail.com>
In-Reply-To: <20050510203454.27683f7b.medaglia@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Cadu,

> Where is the latest version? I have a patch to linux-2.6.12-rc3. I
> don't know if it is the latest version.
> Are you hacking this driver now? I'm asking that because if the answer
> is yes, we can change the same thing at the same time, and maybe it
> will not be a good thing.

The reference version is the one in Greg KH's i2c tree:
http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/i2c/i2c-w83627ehf.patch

On top of which you have to apply a cleanup patch:
http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/i2c/i2c-w83627ehf-cleanup.patch

And you have it. I am not working on this driver anymore, which is the
very reason why I released it unfinished.

If you go on working on this driver, we can list you on our new drivers
page.

Thanks,
-- 
Jean Delvare
