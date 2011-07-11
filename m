From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 11 Jul 2011 14:32:54 +0000
Subject: Re: [lm-sensors] Suggested additions to hwmon sysfs ABI
Message-Id: <20110711143254.GA18739@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110709170759.GA5750@ericsson.com>
In-Reply-To: <20110709170759.GA5750@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Jul 11, 2011 at 08:42:45AM -0400, Guenter Roeck wrote:
> On Mon, Jul 11, 2011 at 04:53:09AM -0400, Jonathan Cameron wrote:
> [ ... ]
> > > 
> > > Based on this list, I suggest adding the following attributes to the ABI.
> > > 
> > > in[0-*]_input_lowest
> > > in[0-*]_input_highest
> > > in[0-*]_average
> > > in[0-*]_reset_history
> > > 
> > > curr[1-*]_input_lowest
> > > curr[1-*]_input_highest
> > > curr[1-*]_average
> > > curr[1-*]_reset_history
> > > 
> > > temp[1-*]_input_lowest
> > > temp[1-*]_input_highest
> > > temp[1-*]_average
> > > temp[1-*]_reset_history
> > > 
> > > It might also be necessary to modify the sensors command to support both instantaneous
> > > and average/peak power readings at the same time.
> > How are you going to do peak power?
> > 
> power already has 
> 
> power[1-*]_average
> power[1-*]_input_highest
> power[1-*]_input_lowest
> power[1-*]_reset_history
> 
> Also, turns out that the following attributes for current sensors already exist.
> 
> curr[1-*]_average
> curr[1-*]_lowest
> curr[1-*]_highest
> curr[1-*]_reset_history
> curr_reset_history
> 
Correction, the above existed for temperature sensors, and I added new attributes
for voltage and current.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
