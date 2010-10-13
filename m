From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 13 Oct 2010 16:03:31 +0000
Subject: Re: [lm-sensors] Detection of W83L771AWG/ASG in lm90
Message-Id: <20101013180331.457f3b72@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <201010131540.19225.alexander.stein@informatik.tu-chemnitz.de>
In-Reply-To: <201010131540.19225.alexander.stein@informatik.tu-chemnitz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 13 Oct 2010 08:54:08 -0700, Guenter Roeck wrote:
> On Wed, 2010-10-13 at 11:43 -0400, Jean Delvare wrote:
> [ ... ]
> > # echo w83L771 0x4c > /sys/devices/i2c-0/new_device
> > 
> Does that work, or would it have to be w83l771 (lower case) ?

Oh, good catch. This is a typo! I definitely meant w83l771 (lower case).

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
