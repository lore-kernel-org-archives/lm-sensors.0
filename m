From: adrian@humboldt.co.uk (Adrian Cox)
Date: Thu, 19 May 2005 06:25:16 +0000
Subject: [PATCH][2.6] Add command function to struct i2c_adapter
Message-Id: <1095843365.18365.48.camel@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <414F111C.9030809@linuxtv.org>
	 <20040921154111.GA13028@kroah.com>	 <41506099.8000307@web.de>
	 <9e4733910409211039273d5a2f@mail.gmail.com>  <41506D78.6030106@web.de>
In-Reply-To: <41506D78.6030106@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michael Hunold <hunold-ml@web.de>
Cc: Jon Smirl <jonsmirl@gmail.com>, Greg KH <greg@kroah.com>, Michael Hunold <hunold@linuxtv.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>, sensors@stimpy.netroedge.com

On Tue, 2004-09-21 at 19:05, Michael Hunold wrote:

> With that addition, it's possible for the i2c core to check if the 
> .class entries of the adapter and the client match. If they don't then 
> there is no need to probe a driver. This will help to keep non-i2c 
> drivers to be probed on dvb i2c busses (and screw them up accidently). 
> Currently it's up to the driver to decide wheter to probe a bus or not.

I've said it before, but:
This is all the wrong way round. I2C probing is a solution for the
problem of finding sensors on a pre-ACPI PC. We'd never have invented it
if all we had was DVB cards and monitor detection. 

These .class entries are workarounds that shouldn't be required. For DVB
cards, TV capture cards, monitor detection, and embedded systems the
required behaviour is normally known in advance. Why should the top
level driver have to use these workarounds to steer the result of
probing when it already has all the information?

My rough proposal would be:
1) One by one, disable probing on these I2C adapters.

2) In the pci probe function of the DVB or capture card, do a sequence
like this:
my_dev_priv->i2c_adapter = i2c_adapter_create(...);
my_dev_priv->tea6415 = tea6415_create(my_dev_priv->i2c_adapter,
                                      &my_tea6415_parameters);
my_dev_priv->saa7111 = saa7111_create(my_dev_priv->i2c_adapter);

3) Then to use the i2c client:
tea6415_switch(my_dev_priv->tea6415, &vm);

This is type safe, it allows out of tree DVB and capture drivers, and it
never ever sends an unexpected event down an I2C bus. It doesn't even
need to change the I2C core very much.

- Adrian Cox
Humboldt Solutions Ltd.

