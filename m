From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 04 Feb 2012 19:11:24 +0000
Subject: Re: [lm-sensors] it87 chip and kernel 3.2.2 issue.
Message-Id: <20120204201124.530480cd@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CANLOsR7+rDwQ6o=UUysYj2bUQmq8aRK6C+khMqAxasyzQZCbLg@mail.gmail.com>
In-Reply-To: <CANLOsR7+rDwQ6o=UUysYj2bUQmq8aRK6C+khMqAxasyzQZCbLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 4 Feb 2012 16:24:20 -0200, Sergio Cipolla wrote:
> Hello, I have a K7VTA3 mobo with an it87 monitoring chip. In spite of
> http://www.lm-sensors.org/wiki/FAQ/Chapter3#Mysensorshavestoppedworkinginkernel2.6.31
> ,
> sensors work fine here up until kernel 3.2.1 (reporting voltage, all temps
> and fans). As soon as the kernel was upgraded to 3.2.2 sensors stopped
> working.

See:
http://lists.lm-sensors.org/pipermail/lm-sensors/2012-January/034935.html

I'll update the FAQ to mention this, as this is going to be a recurrent
complaint I'm afraid.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
