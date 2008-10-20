From: Matthew Garrett <mjg59@srcf.ucam.org>
Date: Mon, 20 Oct 2008 10:00:00 +0000
Subject: Re: [lm-sensors] Using hwmon in-kernel
Message-Id: <20081020100000.GA5208@srcf.ucam.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081008003041.GA20169@srcf.ucam.org>
In-Reply-To: <20081008003041.GA20169@srcf.ucam.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Oct 20, 2008 at 09:05:09AM +0200, Jean Delvare wrote:

> There's nothing preventing you from accessing the LM99's registers
> directly and retrieve the temperature that way. Alternatively, we could
> add an internal interface to access some of the hwmon device features.
> It would take some time to define something everybody agrees on. If you
> have an interest in this, please make a proposal and we can discuss it.

Using the registers directly seems like duplication of existing code, so 
I'd prefer the access interface. I've fleshed out a rough interface that 
simply changes the hwmon device to its own struct containing the device 
structure, and then added an ops structure to that for getting and 
setting parameters. Accessor functions in the generic hwmon code then 
let other drivers use these. The advantage of this approach is that 
porting the drivers over to the new interface is trivial and there's no 
need to actually add the functions to specific drivers until they're 
needed. I'll tidy up the patch and send it.

-- 
Matthew Garrett | mjg59@srcf.ucam.org

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
