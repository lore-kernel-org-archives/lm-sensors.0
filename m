From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:15 +0000
Subject: Donation of an I2C host adapter to lm_sensors
Message-Id: <414A279A.9050000@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1095095083.3132.28.camel@localhost.localdomain>
In-Reply-To: <1095095083.3132.28.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

thanks for the offer.
I briefly reviewed the information about the product on your website.
It is a USB device, correct?

We'd like to know more about the software work required.
Must an i2c driver talk to the device through the "aardvark dll"
or will it work directly with the USB device?
Will the source for the DLL, or the API, be available and GPL'ed?

All our drivers are kernel modules. I'm not sure it's feasible or wise
to try and interface to a binary userspace library from a kernel driver.
In fact I'm sure it isn't.

If you could describe or sketch the SW and the interfaces, and what
software you'll be providing to us, and what you have in mind, 
we'll then like to discuss further how best to get involved.

thanks
mds



Derek Fung wrote:
> Hi everyone on lm_sensors,
> 
> My company, Total Phase, would like to make a donation to your cause.
> We make the Aardvark I2C/SPI Host Adapter.  It is one of the few
> fully cross-platform I2C host adapters on the market for Linux.  
> 
> I know that lm_sensors is geared primarily to access I2C-based
> sensors that are already on motherboards and not the development of
> de novo systems.  But, we are sure that a Linux compatible I2C host
> adapter can help developers hack their hardware and see what's going
> on under the hood.
> 
> We have just released a version 3.00 of our product.  Some of the
> features that you guys might be interested in are:
> - I2C Bus Monitor
> - Rosetta Language Bindings for C/C++ and Python 
> - Batch Scripting Capabilities in the GUI
> 
> Please let us know where we can send this adapter.  If you guys find
> it useful, we would appreciate a mention or a link on your website.
> 
> Looking forward to hearing from you.
> 
> Best Regards,
> Derek
> 
