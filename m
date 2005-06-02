From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 02 Jun 2005 23:31:44 +0000
Subject: [lm-sensors] [PATCH 2.6.12-rc4] PCA9539 - new driver
Message-Id: <429F7AB1.5060000@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <F06EB2894F3F0D45AD9BEA7246DE9C906F50EC@WCSEXCMBS1.ad.wabtec.com>
In-Reply-To: <F06EB2894F3F0D45AD9BEA7246DE9C906F50EC@WCSEXCMBS1.ad.wabtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

> Here's the i2cdump output. 
> The device only supports 8 registers (0-7), so the output isn't too
> surprising.

I was waiting if "undefined" registers will alias or something like that but it seems
that answer is "no".

> AFAIK, this device isn't likely to be on any common motherboard.
> Perhaps detection isn't necessary?

Maybe Jean can suggest something? We can add it later...

Please fix the driver so it works with -mm- kernels and maybe also the alphabetical issue.
Then I think it is quite ready. Please next time include greg@kroah.com in your post,
he is the official kernel I2C subsystem maintainer.

If you want you can create some documentation for the driver. Here is the guide:

Common formatting can be found for example here:
http://ftp.sh.cvut.cz/MIRRORS/kernel/linux/kernel/people/gregkh/gregkh-2.6/gregkh-02-i2c/i2c-docs-update-2.patch
We can add documentation in separate patch.
The documentation should reflect the use of syfs files. You can inspire from PCF8574 chip.

Thanks,
regards

Rudolf
