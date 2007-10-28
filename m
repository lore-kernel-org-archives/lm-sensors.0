From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 28 Oct 2007 12:36:21 +0000
Subject: Re: [lm-sensors] HP maxilife chips have a '-' in their prefix
Message-Id: <20071028133621.677021d7@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4722FA54.4080503@hhs.nl>
In-Reply-To: <4722FA54.4080503@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Sat, 27 Oct 2007 10:44:04 +0200, Hans de Goede wrote:
> While working on a new driver I wanted to use a '-' or '_' in the driver name / 
> prefix. Since I thought a '-' wasn't allowed I checked lib/chips.h in trunk.
> 
> And there are already chips with a - in the prefix, the HP maxilife family.
> 
> This will work with the 2.10.x variant of sensors_parse_chip_name() but not 
> with the 3.0.0 variant of sensors_parse_chip_name().

Pretty much on purpose:
http://www.lm-sensors.org/ticket/2221

> Now I don;t see a 2.6 driver for the hp maxilife chips, so this probably isn't 
> a problem, still I wanted people to know.

That's indeed not a problem. If the maxilife driver is ever ported to
Linux 2.6, it'll have to use different prefixes, that's all.

The rationale for the change is that dashes were almost unused (the only
exceptions being the lm78-j and maxilife chips, all rare chips) but the
cost to support that was important. As it is very easy not to use
dashes in prefixes, I thought we would just do that.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
