From: Charles <c@catcons.co.uk>
Date: Tue, 06 Dec 2011 03:57:57 +0000
Subject: Re: [lm-sensors] 3 wire fan on 4 pin header (was
Message-Id: <4EDD8FF5.5000704@catcons.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <20111205171537.5286e6ae@endymion.delvare>
In-Reply-To: <20111205171537.5286e6ae@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 06/12/11 00:35, Phil Pokorny wrote:

> Some motherboards have BIOS settings to switch between PWM control and
> voltage/3-wire control.  (I saw this in an ASUS BIOS for the CPU fan
> header).  But your essential point is correct, that a header
> configured to use PWM to control fan speed will not work with a 3-pin
> fan.

> On more than one ASUS motherboard, I have encountered 4-pin headers
> that *do not drive* the PWM pin and instead do voltage control of the
> fan speed.  This is most common on the chassis fan headers.  They are
> 4-pin headers, but they don't have an active PWM signal and you can't
> enable it in the BIOS.  I asked ASUS about it and they said it wasn't
> possible to generate PWM signals on those headers.
> 
> When you plug a 4-pin, PWM controlled fan into such a header, the PWM
> signal is floating and so the PWM fan will run at "full speed", but
> the variable voltage will result in the fan speed changing under the
> control of the motherboard.

Thanks for the explanation Phil

The ASUS P8H67-V behaves that way with CPU_FAN working as a "proper" 4
pin header and CHA_FAN1 and CHA_FAN2 behaving as 4 pin headers with a
floating PWM signal.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
