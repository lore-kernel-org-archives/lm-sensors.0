From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 27 Apr 2015 16:15:26 +0000
Subject: Re: [lm-sensors] Asus Nuvoton NCT6791D Fans not detected.....no expected fix?
Message-Id: <20150427161526.GB14248@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAOS+5GHnd+uq9-=tu1LN_5An0LboCuQa1Ymj+yGbUNDEVXaMFg@mail.gmail.com>
In-Reply-To: <CAOS+5GHnd+uq9-=tu1LN_5An0LboCuQa1Ymj+yGbUNDEVXaMFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Apr 27, 2015 at 03:07:13PM +0100, Another Sillyname wrote:
> Hi
> 
> I have an Asus motherboard with the NCT6791D chip and the dreaded ACPI
> memory address conflict in DMESG.
> 
What exactly is your problem ? The ACPI memory conflict, or something else ?
NCT6791D is supported by Linux, so presumably that is not the problem.

> I've read around and googled extensively and I just want to confirm
> that there's currently no likelyhood of this chip being supported for
> fan detection speeds in the near term?
> 
ASUS doesn't support Linux on their consumer boards, so it is quite unlikely
that the situation will change, at least not if it is an ASUS specific problem.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
