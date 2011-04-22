From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 22 Apr 2011 18:22:07 +0000
Subject: Re: [lm-sensors] therm_adt746x: attach_adapter method is deprecated
Message-Id: <1303496527.31666.15.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <alpine.DEB.2.01.1104211758220.18728@trent.utfs.org>
In-Reply-To: <alpine.DEB.2.01.1104211758220.18728@trent.utfs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 2011-04-21 at 20:59 -0400, Christian Kujau wrote:
> Hi,
> 
> Starting with 2.6.38+, I noticed the following messages during bootup:
> 
> i2c i2c-0: attach_adapter method is deprecated
> Please use another way to instantiate your i2c_client
> 
> adt746x seems to continue to work, though. This is on a PowerBook G4.
> 
> Is this something to be worried about?
> 
attach_adapter is scheduled to be removed in September 2011. The message
above is a help call from the adt746x driver, asking for someone to
rewrite it to match the current API.

In other words, it is nothing to worry about right now, but it does
inform you that the driver may disappear unless it is rewritten soon.

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
