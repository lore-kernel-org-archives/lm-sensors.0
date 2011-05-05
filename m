From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 05 May 2011 13:58:20 +0000
Subject: Re: [lm-sensors] [PATCH] sensors-detect: Drop smart battery
Message-Id: <20110505135820.GA13515@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110505110857.3db7a3dd@endymion.delvare>
In-Reply-To: <20110505110857.3db7a3dd@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, May 05, 2011 at 05:08:57AM -0400, Jean Delvare wrote:
> Drop smart battery detection. Rationale:
> * The detection is unreliable, we had reports of false positives.
> * Upon successful detection, the script suggests using the sbs driver,
>   however this is an ACPI driver, not a native driver, so if
>   sensors-detect was able to access device, most likely ACPI won't
>   so the sbs driver won't work.
> * The sbs driver should get loaded automatically where needed anyway.
> 
Looks good. That detection is really more than fishy, so it is good to see it gone.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
