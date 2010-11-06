From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 06 Nov 2010 22:33:26 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (ltc4261) Fix error message format
Message-Id: <20101106223326.GA32117@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101105155929.39a5412f@endymion.delvare>
In-Reply-To: <20101105155929.39a5412f@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Nov 06, 2010 at 04:22:24PM -0400, Jean Delvare wrote:
> On Fri, 5 Nov 2010 09:48:42 -0700, Guenter Roeck wrote:
> > On Fri, 2010-11-05 at 10:59 -0400, Jean Delvare wrote:
> > > adapter->id is deprecated and not set by any adapter driver, so this
> > > was certainly not what the author wanted to use. adapter->nr maybe,
> > > but as dev_err() already includes this value, as well as the client's
> > > address, there's no point repeating them. Better print a simple error
> > > message in plain English words.
> > > 
> > > Signed-off-by: Jean Delvare <khali@linux-fr.org>
> > > Cc: Guenter Roeck <guenter.roeck@ericsson.com>
> > 
> > Applied.
> 
> Thanks. Can you please update the LTC4261 entry in wiki/Devices too?
> 
Done.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
