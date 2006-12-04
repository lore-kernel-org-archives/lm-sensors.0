From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 04 Dec 2006 08:16:06 +0000
Subject: [lm-sensors] testing w83627hf treiber?
Message-Id: <20061204091606.5f617d8e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20061204090602.07b8d41b.khali@linux-fr.org>
In-Reply-To: <20061204090602.07b8d41b.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

(Huh, please don't use URLs as post subjects.)

On Sun, 03 Dec 2006 09:49:38 +0100, Udo van den Heuvel wrote:
> So we might have the same problem.
> In my situation I have a VIA EK8000 which has the fans running during a
> boot until the kernel loads/starts. Then the fans stop. So is it a Linux
> issue?
> When the w83627hf module is loaded with the reset=1 parameter the fans
> start again. Fancontrol is functional (although I do not use it).
> 
> What can we do to find out more?

I guess the BIOS is enabling the automatic fan speed control, with
parameters such that the fan is stopped by default. I suspect the fan
would start spinning after some time when the temperature is high
enough. Check your BIOS settings for "Smart Fan" or something similar.

Using reset=1 is no good as you lose all the BIOS settings. This should
only be used as a last resort. So look in the BIOS if you can disable
the automatic fan speed control. Or just live with it, it should work
after all.

The w83627hf driver should be updated to let the user disable the
automatic fan speed control at runtime. I think there was a patch doing
that floating around some times ago, but it never got merged.

-- 
Jean Delvare

