From: "Yu, Fenghua" <fenghua.yu@intel.com>
Date: Thu, 10 Feb 2011 02:51:15 +0000
Subject: Re: [lm-sensors] [PATCH RFC] Merging_Pkgtemp_with_Coretemp
Message-Id: <493994B35A117E4F832F97C4719C4C04E1196924@orsmsx505.amr.corp.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1297188123-8924-1-git-send-email-durgadoss.r@intel.com>
In-Reply-To: <1297188123-8924-1-git-send-email-durgadoss.r@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> -----Original Message-----
> From: R, Durgadoss
> Sent: Tuesday, February 08, 2011 10:02 AM
> To: guenter.roeck@ericsson.com; khali@linux-fr.org; Yu, Fenghua
> Cc: lm-sensors@lm-sensors.org; R, Durgadoss
> Subject: [lm-sensors][PATCH RFC] Merging_Pkgtemp_with_Coretemp
> 
> This patch merges the pkgtemp driver with the coretemp driver, by
> creating the required pkg temp interfaces under the same
> hwmonX/device directory as that of the coretemp.
> None of the coretemp interfaces are changed.
> 

You need to have topology for package and core temp instead of separating core and package temp interfaces.

Thanks.

-Fenghua


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
