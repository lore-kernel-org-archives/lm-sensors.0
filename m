From: "Mark O. Stitson" <mark@stitson.com>
Date: Mon, 04 Jul 2011 07:54:22 +0000
Subject: Re: [lm-sensors] Any plans to support  Fintek F71869A
Message-Id: <013901cc3a1f$969499a0$c3bdcce0$@com>
List-Id: <lm-sensors.vger.kernel.org>
References: <00eb01cc3972$4a2a4180$de7ec480$@com>
In-Reply-To: <00eb01cc3972$4a2a4180$de7ec480$@com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Ok, I recompiled my kernel with the new module code and used the new
sensors_detect, and it works fine.

I guess it's not worth releasing a new lm-sensors until the kernel has the
new code as well, maybe just worth updating the wiki.

Many thanks for the help.

Mark

-----Original Message-----
From: Jean Delvare [mailto:khali@linux-fr.org] 
Sent: 03 July 2011 12:56
To: Ian Dobson; Mark O. Stitson
Cc: lm-sensors@lm-sensors.org
Subject: Re: [lm-sensors] Any plans to support Fintek F71869A

On Sun, 3 Jul 2011 13:22:42 +0200, Ian Dobson wrote:
> From: Mark O. Stitson 
> Sent: Sunday, July 03, 2011 1:13 PM
> To: lm-sensors@lm-sensors.org 
> Subject: [lm-sensors] Any plans to support Fintek F71869A
> 
> I have a Jetway NF99FL-525 Atom ITX motherboard which uses an unsupported
Fintek chipset.
> 
> Output from sensors-detect 3.3.0:
> 
> Driver `to-be-written':
> 
>   * ISA bus, address 0x290
> 
>     Chip `Fintek F71869A Super IO Sensors' (confidence: 9)

The latest version of sensors-detect, at:
  http://dl.lm-sensors.org/lm-sensors/files/sensors-detect
points to the correct driver meanwhile.

Which makes me think that probably it's about time to release
lm-sensors 3.3.1.

> Can you fix it? I can help to test drivers.
> 
> Mark

Ian, please fix your quoting style, it took me a minute to actually see
your sentence.

> Theres already a patch on it's way upstream
> http://www.spinics.net/lists/lm-sensors/msg32588.html

Right, and on tits way to Linus for kernel 3.0 as we speak.
Alternatively, if you don't feel like patching your kernel tree or
running a 3.0-rc kernel, I've updated the standalone driver at:
  http://khali.linux-fr.org/devel/misc/f71882fg/

-- 
Jean Delvare


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
