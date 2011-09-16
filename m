From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 16 Sep 2011 22:12:24 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon: (coretemp) Let the user force
Message-Id: <1316211144.4630.17.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110916212402.41fc972c@endymion.delvare>
In-Reply-To: <20110916212402.41fc972c@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 2011-09-16 at 15:24 -0400, Jean Delvare wrote:
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
> ---

Applied.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
