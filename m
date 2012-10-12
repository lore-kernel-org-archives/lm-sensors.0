From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 12 Oct 2012 15:50:50 +0000
Subject: Re: [lm-sensors] Hello everyone and a small request
Message-Id: <20121012175050.638dc453@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CACFgSatfCsq=UbieG8d8oDF0xibhcNOm84ZyviujEiProi4MOQ@mail.gmail.com>
In-Reply-To: <CACFgSatfCsq=UbieG8d8oDF0xibhcNOm84ZyviujEiProi4MOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Bonjour Julien,

On Fri, 12 Oct 2012 15:25:33 +0300, julien perrier-cornet wrote:
> I'm new to the list and i have a small problem. My motherboard was not
> listed in the supported boards, so as
> it is an ASUS P9 X79 WS model, i've tried the small tool to check the
> acpi. Unfortunately, i don't really

We don't actually have a list of supported boards. We have a list of
supported chips, but some boards can have a supported chip and still be
unsupported (for example due to ACPI getting in the way.)

> have the skill to get anything useful from it. I was thinking to
> attach the file to this email, in case one of you
> could have a more insightful look at it, to see if it is possible to
> monitor the cpu temperature using lm-sensors.

Did you run sensors-detect? Hopefully a recent version? Which chips
were found, if any? Did you load the recommended drivers? Then what was
the output of "sensors"?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
