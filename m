From: "Odzioba, Lukasz" <lukasz.odzioba@intel.com>
Date: Wed, 14 Oct 2015 11:39:24 +0000
Subject: Re: [lm-sensors] [PATCH 1/1] Bumps limit of maximum core ID from 32 to 128.
Message-Id: <D6EDEBF1F91015459DB866AC4EE162CC02317564@IRSMSX103.ger.corp.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1444650812-17398-1-git-send-email-lukasz.odzioba@intel.com>
 <561DAD1B.9010101@roeck-us.net>
In-Reply-To: <561DAD1B.9010101@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: "jdelvare@suse.de" <jdelvare@suse.de>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Yu, Fenghua" <fenghua.yu@intel.com>

On Wednesday, October 14, 2015 at 3:17 AM, Guenter Roeck wrote: 
> Applied, after fixing up the subject and listing the current required limit
> of 72 cores for Xeon Phi (per published information).

Guenter sorry for inconvenience I forgot that core enumeration on KNL 
is not continuous, so some core ID's are not used. Thus we have to
change limit to 76 instead of 72.

My mistake,
Lukas

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
