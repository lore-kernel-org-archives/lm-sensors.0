From: "Yu, Fenghua" <fenghua.yu@intel.com>
Date: Fri, 16 Sep 2011 19:31:51 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon: (coretemp) Let the user force
Message-Id: <493994B35A117E4F832F97C4719C4C040133348929@orsmsx505.amr.corp.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110916212402.41fc972c@endymion.delvare>
In-Reply-To: <20110916212402.41fc972c@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

 -----Original Message-----
> From: Jean Delvare [mailto:khali@linux-fr.org]
> Sent: Friday, September 16, 2011 12:24 PM
> To: LM Sensors
> Cc: Yu, Fenghua; R, Durgadoss; Guenter Roeck; Alexander Stein
> Subject: [PATCH 2/2] hwmon: (coretemp) Let the user force TjMax
> 
> On old CPUs (and even some recent Atom CPUs) TjMax can't be read from
> the CPU registers, so it is guessed by the driver using a complex
> heuristic which isn't reliable. So let users who know their CPU's
> TjMax pass it as a module parameter.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Fenghua Yu <fenghua.yu@intel.com>
> Cc: "R, Durgadoss" <durgadoss.r@intel.com>
> Cc: Guenter Roeck <guenter.roeck@ericsson.com>
> Cc: Alexander Stein <alexander.stein@systec-electronic.com>

Acked-by: Fenghua Yu <fenghua.yu@intel.com>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
