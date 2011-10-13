From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 13 Oct 2011 15:12:13 +0000
Subject: Re: [lm-sensors] [PATCH V2] hwmon:lm75 add support for the Analog
Message-Id: <20111013151213.GA12007@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1318495411-20399-1-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1318495411-20399-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Oct 13, 2011 at 04:47:29AM -0400, Jean Delvare wrote:
> On Thu, 13 Oct 2011 10:43:31 +0200, michael.hennerich@analog.com wrote:
> > From: Michael Hennerich <michael.hennerich@analog.com>
> > 
> > Changes since V1:
> > 
> > Remove depreciated ADT75 device detection support.
> > The ADT75, like some other LM75 derivatives needs to be instantiated
> > using methods 1,2 or 4.
> > For more information see Documentation/i2c/instantiating-devices.
> > 
> > Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> 
> Acked-by: Jean Delvare <khali@linux-fr.org>
> 
> I'll let Guenter pick the patch as he has a working development tree
> while at the moment I do not.
> 
Applied.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
