From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 12 Mar 2008 11:08:31 +0000
Subject: Re: [lm-sensors] W83627DHG driver on MSI 975x board
Message-Id: <20080312120831.456b2f7e@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1205271362.6571.9.camel@montecristo>
In-Reply-To: <1205271362.6571.9.camel@montecristo>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Joakim,

On Tue, 11 Mar 2008 22:36:02 +0100, Joakim Larsson wrote:
> On Sun, 2008-03-09 at 20:08 +0100, Joakim Larsson wrote:
> 
> ok, so I downloaded the Ubuntu Feisty 2.6.20 kernel source and compiled
> the modules and then just copied the driver from the 2.6.24 kernel
> source and recompiled it. Then I did make modules_install. The modules
> now loads successfully:
> 
> $ sudo modprobe hwmon-vid 
> $ sudo modprobe w83627ehf 
> $ dmesg
> <snip>
> [  127.521735] w83627ehf: Found W83627DHG chip at 0x290
> <snip>
> 
> However when I run sensors I got the following output: 
> 
> $ sudo sensors
> w83627dhg-isa-0290
> Adapter: ISA adapter
> 
> And no other output. I'll try to debug but any hint's appreciated! :-)

What version of lm-sensors are you using again? w83627dhg support was
added in 2.10.2.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
