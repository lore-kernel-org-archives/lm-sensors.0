From: "R, Durgadoss" <durgadoss.r@intel.com>
Date: Fri, 14 Oct 2011 04:49:26 +0000
Subject: Re: [lm-sensors] [PATCH v2 2/2] hwmon: (coretemp) Add support for
Message-Id: <D6D887BA8C9DFF48B5233887EF04654109ED2A019A@bgsmsx502.gar.corp.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1317162831-30628-3-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1317162831-30628-3-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

[snip..]

> 
> FWIW, the Intel datasheet numbers the thresholds #1 and #2. I have no
> idea why Durgadoss decided to go with 0 and 1.

I wanted to make it consistent with attr->nr where we use 0 for T1 and 1 for T2.
This way, the driver will have just 0-1 notions, although the spec uses 1-2.

Thanks,
Durga

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
