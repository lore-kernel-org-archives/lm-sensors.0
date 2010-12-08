From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 08 Dec 2010 18:02:14 +0000
Subject: Re: [lm-sensors] W83667HG-B w83627ehf
Message-Id: <20101208180214.GA29078@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <BLU0-SMTP144B1A48271E23900BFDB36CE2D0@phx.gbl>
In-Reply-To: <BLU0-SMTP144B1A48271E23900BFDB36CE2D0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Dec 08, 2010 at 08:47:56AM -0500, Jose M. Caballero wrote:
> I've got the sensor W83667HG-B (I get it by sensors-detect) wich is
> controlled by the driver w83627ehf (looking manually in sensors-detect @
> 5883) and I've got many problems installing it in ubuntu 10.10
> (maverick) wich is the kernel 2.6.35-23 with no modifications. The
> motherboard is AsRock H55M Pro.
> 
> Any help is welcome. I am new to all this but I don't want my Motherboard fried, like the last one.
> 
> I first go to
> 
> http://www.lm-sensors.org/wiki/iwizard/ManualInstall
> 
> And do it all carefully. I read the install archive and install all
> dependencies and all that.
> 
> But when I go to:
> 
> http://www.lm-sensors.org/wiki/iwizard/Detection
> 
> I get some doubts:
> 
> there are no file /etc/modules.conf just a /etc/modules
> Is that the file? Should I create the file?
> Similar happens to the file: /etc/rc* I just got a /etc/rc.local and many directories /etc/rc*.d with a lot of files
> So which is the file?
> 
> Must I substitute the sensors-detect provided 5861 by the patch 5883?
> 
> Should I copy the driver needed w83627ehf.c? Where?
> 
> Thanks for all.
> 
Enter "modprobe w83627ehf" and check if you get an output from the sensors command.
If yes, add w83627ehf to /etc/modules.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
