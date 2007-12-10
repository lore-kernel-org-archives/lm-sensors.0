From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 10 Dec 2007 14:44:12 +0000
Subject: Re: [lm-sensors] Intel Core voltage monitoring
Message-Id: <20071210154412.7cc4e04f@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <475BDA45.70400@googlemail.com>
In-Reply-To: <475BDA45.70400@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf,

On Mon, 10 Dec 2007 14:43:13 +0100, Rudolf Marek wrote:
> Hi Peter,
> 
> IMHO the CPU-Z reads the VID code from CPU, so the voltage is not the real 
> voltage, but the voltage that the CPU wants (not what it is actually getting).
> 
> The driver could be extended to show the voltage, but that would not be a real 
> voltage, but just voltage it wants... Don't know if it is benefit for user?
> 
> What others think?

Well, that's what other hardware monitoring drivers export as cpu0_vid.
If you can read the value from the CPU directly, that would be
interesting, as this means that we can get the value even if the VID
lines aren't (properly) wired to the hardware monitoring chip. So, yes,
I'd say it's worth exporting from the coretemp driver if that can be
done easily and reliably.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
