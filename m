From: zdavatz@ywesee.com (Zeno R.R. Davatz)
Date: Thu, 19 May 2005 06:23:56 +0000
Subject: your i2c is to old 'error'
Message-Id: <1052840152.614.43.camel@zrr>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi

I got one step further:

'make all' now gives me:

kernel/busses/i2c-amd8111.c:25:2: #error Your i2c is too old - i2c-2.7.0
or greater required!
kernel/busses/i2c-amd8111.c: In function `amd8111_access':

I installed the i2c-sources successfully.

Thanks for your time and help.

Zeno

On Tue, 2003-05-13 at 16:04, Jean Delvare wrote:
> > I downloaded the packages.
> 
> Which packages?
> 
> > In ../modules I done 'make all'
> > 
> > and I get:
> > grep: /usr/src/linux/.config: No such file or directory
> > make: *** No rule to make target `linux/modversions.h', needed by
> > `kernel/chips/vt1211.d'.  Stop.
> > 
> > Why would that be?
> 
> Looks like you are missing kernel sources, but I hardly can help more
> unless you explain in details what you have being doing, where you want
> to go and what's in the way.
-- 
Mit freundlichen Gr?ssen / best regards

Zeno Davatz
Strategie & Akquisition

+41 1 350 85 86

www.ywesee.com > intellectual capital connected > www.generika.cc
