From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 18 Nov 2014 17:43:57 +0000
Subject: Re: [lm-sensors] Support for SMSC EMC1402
Message-Id: <20141118174357.GA11245@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <546B770B.7030204@riseup.net>
In-Reply-To: <546B770B.7030204@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Nov 18, 2014 at 05:42:51PM +0100, Juraj Fiala wrote:
> Hiya.
> 
> I tried running sensors-detect, and it said that support for SMSC
> EMC1402 is "to be written".
> 
It is already supported by the emc1403 driver, starting with kernel version
3.16. We'll need to update sensors-detect.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
