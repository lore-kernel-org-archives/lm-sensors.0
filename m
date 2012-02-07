From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 07 Feb 2012 19:55:42 +0000
Subject: Re: [lm-sensors] [BUG] kernel 3.0.19 LTS and archlinux
Message-Id: <20120207205542.031ce63c@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4F318101.7050407@gmail.com>
In-Reply-To: <4F318101.7050407@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 07 Feb 2012 20:52:33 +0100, David Kremer wrote:
> Hello,
> 
> I cannot load the w83627ehf kernel driver into linux.
> 
> $sudo modprobe  w83627ehf
> ERROR: could not insert 'w83627ehf': Device or resource busy
> 
> fancontrol stopped to work since I upgraded my kernel to the 3.0.19 LTS 
> version.
> 
> Can you help ?

The FAQ can help:

http://www.lm-sensors.org/wiki/FAQ/Chapter3#Mysensorshavestoppedworkinginkernel3.33.2.23.0.18

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
