From: Krzysztof Helt <krzysztof.h1@wp.pl>
Date: Fri, 06 Jul 2007 19:27:35 +0000
Subject: Re: [lm-sensors] Sensors working on DL360?
Message-Id: <20070706212735.5febd055.krzysztof.h1@wp.pl>
List-Id: <lm-sensors.vger.kernel.org>
References: <57849.83.87.167.242.1183707511.squirrel@webmail4.transip.nl>
In-Reply-To: <57849.83.87.167.242.1183707511.squirrel@webmail4.transip.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 6 Jul 2007 18:12:29 +0200 (CEST)
"Bart van Kuik" <lmsensors@vankuik.nl> wrote:

> We can start with probing for (PCI) I2C or SMBus adapters.
> Do you want to probe now? (YES/no):
> Probing for PCI bus adapters...
> Use driver `i2c-piix4' for device 0000:00:0f.0: ServerWorks OSB4 South Bridge
> 
> We will now try to load each adapter module in turn.
> Module `i2c-piix4' already loaded.
> If you have undetectable or unsupported adapters, you can have them
> scanned by manually loading the modules before running this script.
>
> We are now going to do the I2C/SMBus adapter probings. Some chips may
> be double detected; we choose the one with the highest confidence
> value in that case.
> If you found that the adapter hung after probing a certain address,
> you can specify that address to remain unprobed.

> Some chips are also accessible through the ISA I/O ports. 

This is not problem with my driver (not yet because it hasn't load) but with
I2C/SMBus bus driver. Normally, the I2C bus is scanned and chips are detected (most
fails usually). In your case, there is no scan of I2C bus. 

Try tips from these pages (look for "ServerWorks OSB4"):
http://www.almico.com/foruminfo.php?idP
http://www.lm-sensors.org/browser/lm-sensors/trunk/doc/busses/i2c-piix4

I hope someone more skillful about I2C can help you.

Regards,
Krzysztof

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
