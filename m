From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 14 Mar 2012 23:06:41 +0000
Subject: Re: [lm-sensors] ERROR: could not insert 'w83627ehf': Device or resource busy
Message-Id: <20120314230641.GA9205@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4F60A0AA.2050107@gmail.com>
In-Reply-To: <4F60A0AA.2050107@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Mar 14, 2012 at 04:57:51PM -0400, David Kremer wrote:
> Thank you Guenter. I read your driver's README and I would like to thank 
> you for that work.
> 
> What I wonder is, if there is actually an automatic mode and a 
> temperature range that could be defined for the NCT6776F to stay in (so 
> called "cruiser mode"), why this is not accessible from whithin the BIOS 
> setting ?
> 
David,

that is really a question to ask the board vendor. NCT6776F actually has several
automatic modes - thermal cruise mode, fan speed cruise mode, and SmartFan IV mode.
In SmartFan IV mode, one can also enable an additional "weight" mode, in which
fan speed is controlled by two temperatures. This is configured on my Intel board
and works quite well. That mode can be configured with the various "weight" attributes
in the latest version of the nct6775 driver.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
