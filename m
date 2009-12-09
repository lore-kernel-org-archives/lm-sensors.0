From: Huaxu Wan <huaxu.wan@linux.intel.com>
Date: Wed, 09 Dec 2009 09:10:42 +0000
Subject: Re: [lm-sensors] P55 Xeon X3440 Incorrect temperature detection?
Message-Id: <20091209091042.GA23069@owl>
List-Id: <lm-sensors.vger.kernel.org>
References: <a413d4880912081636j75141237g50aa2c4ce714352b@mail.gmail.com>
In-Reply-To: <a413d4880912081636j75141237g50aa2c4ce714352b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 00:36 Wed 09 Dec, Another Sillyname wrote:
> Hi
> 
> I today received and built my new P55 Chipset LGA 1156 DFI Motherboard
> using a Xeon X3440 processor.

Please help me confirm that whether the CPU model NO. is 30.

> 
> After installing lm-sensors I have two issues.
> 
> 1.  I can't see the temp of the individual cores which I can on a Core
> i7 920 chip?
> 
> 2.  The CPU temp is being incorrectly reported as at about 21 degrees
> C rising at idle rising to about 40 degrees C under load.  The BIOS
> reports the chip at about 40 Degrees C at idle (which is what I would
> expect to be honest).
> 
> I'm running kernel 2.6.31-6 and lm-sensors version 3.1.1 (I know 3.1.2
> is released but 3.1.1 is the latest version in rpmfusion).


AFAIK, the 2.6.31 kernel doesn't support the CPU of model 30 yet. The
patch has been merged into 2.6.32 to enable the sensors.

Thanks
Huaxu

> 
> Any pointers please.
> 
> Thanks in advance.
> 
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
