From: zdavatz@ywesee.com (Zeno R.R. Davatz)
Date: Thu, 19 May 2005 06:23:56 +0000
Subject: Testing ASUS PU-DLS
Message-Id: <1052834368.613.35.camel@zrr>
List-Id: <lm-sensors.vger.kernel.org>
References: <1052831030.613.28.camel@zrr>
In-Reply-To: <1052831030.613.28.camel@zrr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 2003-05-13 at 15:26, Jean Delvare wrote:
> > I got 'I20', 'I20 PCI' and 'I20 /proc support' compiled into my
> > kernel.
> > 
> > I did not compile 'I20 Block/LAN/SCSI OSM' into the kernel.
> 
> What you need is I2C, not I2O.

thanks for the hint.

I downloaded the packages.

In ../modules I done 'make all'

and I get:
grep: /usr/src/linux/.config: No such file or directory
make: *** No rule to make target `linux/modversions.h', needed by
`kernel/chips/vt1211.d'.  Stop.

Why would that be?

Thanks for your time and help.

Zeno



-- 
Mit freundlichen Gr?ssen / best regards

Zeno Davatz
Strategie & Akquisition

+41 1 350 85 86

www.ywesee.com > intellectual capital connected > www.generika.cc
