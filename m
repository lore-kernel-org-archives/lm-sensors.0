From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Mon, 16 Jul 2007 13:37:30 +0000
Subject: Re: [lm-sensors] [PATCH 3/3] libsensors4:
Message-Id: <469B749A.6050008@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Minor optimizations to sensors_feature_get_type():
> * We no longer support any single type, so no need to handle this case.
> * We can start looking for "_" at offset 3 rather than the beginning
>   of the string (the shortest valid prefix is "in0", 3 characters.)
> 

Nice cleanup!

I've checked the whole bunch of patches, and they look okay. Once you've 
applied them to svn I'll do some testing to see if there are any regressions, 
but I don't expect any,

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
