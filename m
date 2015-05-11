From: Jean Delvare <jdelvare@suse.de>
Date: Mon, 11 May 2015 10:50:40 +0000
Subject: Re: [lm-sensors] Additional PWM driver support for w83792d
Message-Id: <20150511125040.7b22390e@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <003901d08a57$bc46f8a0$34d4e9e0$@hiddenengine.co.uk>
In-Reply-To: <003901d08a57$bc46f8a0$34d4e9e0$@hiddenengine.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 10 May 2015 14:42:18 +0100, vt8231@hiddenengine.co.uk wrote:
> With regards to generating the patch, I've checked the LM-Sensors Wiki for
> submitting patches (http://lm-sensors.org/wiki/FAQ/Chapter5) and it refers to
> CVS as the reference... but I can't see the chip drivers there.  As far as I
> can tell, they are in the Linux kernel itself.  Where is the reference source 
> code for the chip drivers?  I patch that I offered above was against the 
> Ubuntu source for kernel 3.19.0 but this isn't the latest kernel...

The FAQ is old, and only refers to the user-space side of things now.
So you can ignore it. Better read Documentation/SubmittingPatches and
Documentation/hwmon/submitting-patches in the kernel tree.

A patch against kernel 3.19.0 will be just fine, the w83792d driver
didn't see any change for over a year.

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
