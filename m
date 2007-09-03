From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Mon, 03 Sep 2007 07:53:45 +0000
Subject: Re: [lm-sensors] [PATCH 3/7] libsensors4: Compute mapping as a flag
Message-Id: <46DBBD89.3070306@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070902221136.6b060a26@hyperion.delvare>
In-Reply-To: <20070902221136.6b060a26@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> The compute mapping value is either SENSORS_NO_MAPPING or the same
> feature number as the logical mapping. This means that the compute
> mapping can be turned into a simple boolean flag. Doing so makes
> struct sensors_feature_data smaller, which saves some memory (about
> 17 kB in my tests.)
> 

Looks good too.

Regards,

Hans


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
