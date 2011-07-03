From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 03 Jul 2011 11:56:15 +0000
Subject: Re: [lm-sensors] Any plans to support  Fintek F71869A
Message-Id: <20110703135615.12123ece@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <00eb01cc3972$4a2a4180$de7ec480$@com>
In-Reply-To: <00eb01cc3972$4a2a4180$de7ec480$@com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 3 Jul 2011 13:22:42 +0200, Ian Dobson wrote:
> From: Mark O. Stitson 
> Sent: Sunday, July 03, 2011 1:13 PM
> To: lm-sensors@lm-sensors.org 
> Subject: [lm-sensors] Any plans to support Fintek F71869A
> 
> I have a Jetway NF99FL-525 Atom ITX motherboard which uses an unsupported Fintek chipset.
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
