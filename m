From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 16 Sep 2011 17:48:55 +0000
Subject: Re: [lm-sensors] [PATCHv4 1/1] Hwmon: Add core/pkg Threshold
Message-Id: <1316195335.4630.4.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1310468836-5517-1-git-send-email-durgadoss.r@intel.com>
In-Reply-To: <1310468836-5517-1-git-send-email-durgadoss.r@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

On Fri, 2011-09-16 at 13:00 -0400, Jean Delvare wrote:
> On Mon, 12 Sep 2011 18:18:00 +0200, Jean Delvare wrote:
> > On my Core Duo T2600, the output looks like:
> > 
> > coretemp-isa-0000
> > Core 0:      +54.0°C  (high = +47.0°C, hyst = +64.0°C)  ALARM
> >                       (crit = +100.0°C)
> > Core 1:      +55.0°C  (high = +47.0°C, hyst = +64.0°C)  ALARM
> >                       (crit = +100.0°C)
> > 
> > High at 47°C by default seems unreasonable, and hyst > high even more
> > so. But at least the ALARM flags are consistent with these limits.
> 
> BTW, the high and hyst values on this CPU appear to be random. Today
> they are 89°C and 96°C. Very odd.
> 
Not initialized, maybe ? Still odd, though.

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
