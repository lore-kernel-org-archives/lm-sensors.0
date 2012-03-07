From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 07 Mar 2012 13:32:47 +0000
Subject: Re: [lm-sensors] unable to use pwmcontrol
Message-Id: <20120307143247.6c92b147@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4F5751F6.8030502@gmail.com>
In-Reply-To: <4F5751F6.8030502@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi David,

On Wed, 07 Mar 2012 13:17:58 +0100, David Kremer wrote:
> Hello,
> 
> since a while, pwmcontrol doesn't work anymore. pwmconfig doesn't work.
> 
> It is strange because it worked in the past prior to some upgrade of the 
> kernel.
> 
> Can you give me a way to fix this ?

Not if you don't provide a lot more technical details than you did so
far. Which kernel version was working, which is failing, what's the
output of pwmconfig, which hardware monitoring drivers your system
uses, etc.

A blind shot would be
http://www.lm-sensors.org/wiki/FAQ/Chapter3#Mysensorshavestoppedworkinginkernel2.6.31
or
http://www.lm-sensors.org/wiki/FAQ/Chapter3#Mysensorshavestoppedworkinginkernel3.33.2.23.0.18
but maybe not.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
