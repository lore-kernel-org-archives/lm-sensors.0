From: perrye@gilfillan.org (Perry Gilfillan)
Date: Thu, 19 May 2005 06:24:57 +0000
Subject: Any one using i2c-voodoo3 module on the 2.6 kernel?
Message-Id: <40A424D3.7060006@gilfillan.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sensors <lm78@stimpy.netroedge.com>, kernel <linux-kernel@vger.kernel.org>

Hello,

I've made some progress with the v3tv project.  Using the recent 2.4 
kernels, with various patches for v4l2, i2c-2.8.x, and sensors-2.8.x, 
I've got all of the v4l modules to attach to the i2c-voodoo3 module.

I've also got a v4l2 radio device working on the 2.4 kernel :)

Now I'd like to start looking at the 2.6 kernel.  At this point it does 
not seem that the i2c-voodoo3 module is loading correctly.  The module 
is totaly silent in the logs, so I can't offer any immediate list of 
symptoms, except to say I can find no reference to it in the sysfs and 
proc directories.

The client module probe functions never see the Voodoo3 adapter.

The call to pci_module_init returns zero. Replacing that with a call to 
pci_register_driver yeilds a one, but this may not be representative, 
since pci_register_driver always returns a non-zero value.

I'm going to add more printk's to the pci-driver.c file, and reboot when 
I have time for it.

I'd appreciate any advice on where to look first, and where in sysfs to 
look for evidence that the module loaded correctly.

Has anyone used the Banshee or Voodoo3 card with the i2c-voodoo3 module 
in the 2.6 kernel with success?



Thanks,

Perry
-----
Projects:
   V3TV:		http://www.gilfillan.org/v3tv/
   VPX3224:	http://www.gilfillan.org/vpx3224/
   V3TV-radio:	http://www.gilfillan.org/v3tv-v4l2/
   snd-tvmixer:	http://www.gilfillan.org/ALSA/

