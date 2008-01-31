From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Thu, 31 Jan 2008 13:48:57 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (asb100) Various cleanups
Message-Id: <20080131134857.GI8290@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080103231549.3cb00f27@hyperion.delvare>
In-Reply-To: <20080103231549.3cb00f27@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean:

* Mark M. Hoffman <mhoffman@lightlink.com> [2008-01-31 07:51:03 -0500]:
> >  	struct asb100_data *data = dev_get_drvdata(dev);
> 
> The above line is not present in the original, nor in any patch I've
> seen.  I think you probably meant it to be changed by this patch.
> Please respin this one and I'll get it and the rest of the series
> applied.

No, my bad: I found the second vrm patch... sorry.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
