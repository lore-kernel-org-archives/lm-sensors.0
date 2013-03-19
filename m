From: Clemens Ladisch <clemens@ladisch.de>
Date: Tue, 19 Mar 2013 08:19:56 +0000
Subject: Re: [lm-sensors] Getting temps for all CPU cores to show up on an AMD chip
Message-Id: <51481FAC.20702@ladisch.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAO2Qn5nT3FPbyrzJCF3NfyQ2y4sgR62w5JhMQeVNsHEcWY5HDA@mail.gmail.com>
In-Reply-To: <CAO2Qn5nT3FPbyrzJCF3NfyQ2y4sgR62w5JhMQeVNsHEcWY5HDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

dag dg wrote:
> I wish that was the case so I could close the book but CPUID's
> HWmonitor and OCCT PT both report all 6 temps which show the temps
> fluxuating(within a degree of each other but still enough to tell
> they're different measurements)

I don't know where they get these values from; there's nothing in the
AMD datasheets except the per-die northbridge sensor.  (Even the Boost
function is documented as just counting idle cores.)


Regards,
Clemens

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
