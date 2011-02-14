From: Matthew Garrett <mjg59@srcf.ucam.org>
Date: Mon, 14 Feb 2011 18:22:45 +0000
Subject: Re: [lm-sensors] hwmon API update
Message-Id: <20110214182245.GA14311@srcf.ucam.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4D57CC24.1040306@free.fr>
In-Reply-To: <4D57CC24.1040306@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Feb 14, 2011 at 10:19:32AM -0800, Guenter Roeck wrote:

> .. unless there is no benefit for the driver in such an API change.
> I am all for API changes if there are benefits for the affected drivers, 
> and don't care about backwards compatibility. The i2c subsystem changes
> all resulted in much cleaner and less code, which benefits everyone.
> 
> What we have here, though, is a lot of added complexity for each driver with
> no benefit at all for the affected drivers. From a driver perspective, added
> complexity and loss of backward complexity is all we get. In that context
> I consider lack of backward complexity to be a valid argument. Sure, there
> may be other arguments to make which outweigh the concerns, but that doesn't
> mean the argument can not be made.

The benefit to the hwmon drivers is that they actually get to be used in 
the kernel and get some amount of extra development effort as a result.

-- 
Matthew Garrett | mjg59@srcf.ucam.org

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
