From: Jean Delvare <jdelvare@suse.de>
Date: Wed, 15 Jul 2015 21:07:34 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: coretemp: use list instead of fixed size array for temp data
Message-Id: <20150715230734.76347af2@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1436976253-4810-1-git-send-email-lukasz.odzioba@intel.com>
In-Reply-To: <1436976253-4810-1-git-send-email-lukasz.odzioba@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lukasz Odzioba <lukasz.odzioba@intel.com>
Cc: fenghua.yu@intel.com, linux@roeck-us.net, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On Wed, 15 Jul 2015 18:04:13 +0200, Lukasz Odzioba wrote:
> Removes the limits of supported CPU cores and max core ID.

I see the benefit of removing the arbitrary limit, but why use a list
instead of a dynamically allocated array? This is turning a O(1)
algorithm into a O(n) algorithm. I know n isn't too large in this case
but I still consider it bad practice if it can be avoided.

Do you expect core IDs to become arbitrarily large? Significantly
larger than the core count?

You need a better patch description for sure. Saying what the patch
does isn't sufficient, you need to explain why this is needed and why
this is the right way to do it.

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
