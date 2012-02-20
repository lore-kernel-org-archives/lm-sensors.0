From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 20 Feb 2012 17:39:57 +0000
Subject: Re: [lm-sensors] [Patch] hwmon: (max6639) Set Pulse per revolution loop for both channels
Message-Id: <20120220173957.GA10776@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAO7tRnjoSKUKoL4445e+Gud7Dhe=K9K1MYnGNCYcBs-d4X2O6A@mail.gmail.com>
In-Reply-To: <CAO7tRnjoSKUKoL4445e+Gud7Dhe=K9K1MYnGNCYcBs-d4X2O6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Feb 16, 2012 at 04:29:22PM -0500, Jean Delvare wrote:
> On Mon, 13 Feb 2012 00:56:00 -0500, Chris wrote:
> > Removed initialization to leave bios or hardware defaults alone.
> 
> Err, this is going too far. The original author of the code obviously
> needed the driver to initialize the chip, otherwise he wouldn't have
> defined a platform data for this purpose. Killing the initialization
> function altogether makes no sense. All I said was that it seemed
> curious to do it all _by default_.
> 
> Anyway, this is really a secondary issue at this point. The main
> problems is the two functional bugs we spotted in the driver. We should
> fix them first, and then we can discuss the rest if there is an
> interest. I'm not using this driver and I don't know who is in
> practice, so I don't care that much.
> 
> Please resubmit a (-p1) patch fixing the issue your originally spotted
> instead.
> 
We really need input from Roland on the initialization problem.
Might make sense to kwwp him copied on this exchange.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
