From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 16 Mar 2011 14:06:37 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (lineage-pem): Fix in1 voltage
Message-Id: <20110316150637.0fd87f99@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1300233149-2269-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1300233149-2269-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 16 Mar 2011 06:51:10 -0700, Guenter Roeck wrote:
> On Wed, Mar 16, 2011 at 04:26:49AM -0400, Jean Delvare wrote:
> > Note that this means that this device has now in1_alarm and
> > in1_crit_alarm. This is a case your proposed rewrite of the "sensors"
> > code won't properly deal with, as it will only check for limit-specific
> > alarm flags in the absence of a generic alarm flag (so in this case
> > in1_crit_alarm will be ignored.) Not that the original code was better,
> > but maybe it's the right time to get it right.
> > 
> Yes, I know :(. I didn't want to get rid of the _crit attribute, since it is
> supported and adds value. Figured I'd deal with the sensors problem later 
> (if I find a good solution).

Just always check for all possible alarm flags (generic and
limit-specific alike)? The only annoyance I can see is that when
in1_crit_alarm is set, whether or not in1_alarm is also set won't
affect the output, it will be "ALARM (CRIT)" in both cases. But I don't
think it is a problem in practice.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
