From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 03 Jun 2012 08:47:54 +0000
Subject: Re: [lm-sensors] Mini ITX fully compatible Lm-sensors
Message-Id: <20120603104754.7da947b7@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAKJpqGHvWrDSCz+7G5UvR2p_96gR98MpmHZ6G-kmr5-5OiMhog@mail.gmail.com>
In-Reply-To: <CAKJpqGHvWrDSCz+7G5UvR2p_96gR98MpmHZ6G-kmr5-5OiMhog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 3 Jun 2012 09:12:33 +0200, clement clem wrote:
> The chip-Nuvoton W83677HG i totally works with Kernel 2.6.35.32 (Ubuntu
> 10.10)?

Not out of the box. See http://www.lm-sensors.org/wiki/Devices :
W83677HG support was added in kernel 2.6.39. That being said you can
always use a manually built standalone driver.

Also note that the fact that the chipset is supported is not a
guarantee that things will work. There is always the possibility that
the vendor did not use the monitoring features, or not all of them, or
that the ACPI BIOS takes control of the chip.

> Do you have information on the chip card mini ITX:
>   ASRock B75M-ITX
>   MSI E35-H61I
> Gigabyte GA-H61N

No we don't.

> These smart you are monitoring it completely taken over by Lm-Sensors certain
> person we make test?

I don't understand your question, sorry.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
