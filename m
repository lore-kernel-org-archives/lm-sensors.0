From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 17 Oct 2005 12:10:15 +0000
Subject: [lm-sensors] Support for Linux 2.6 only drivers
Message-Id: <kHXUGQdV.1129543133.8819110.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <507CF24DDCB8114C82ABCC09CBC1E9EE75C1D3@transtech-2000.transtech.local>
In-Reply-To: <507CF24DDCB8114C82ABCC09CBC1E9EE75C1D3@transtech-2000.transtech.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Steve,

On 2005-10-17, Steve Evans wrote:
> I have written a driver for the Analogue Devices AD7417 temperature
> sensor/quad ADC and have a couple of questions:
>
> o My development calls only for Linux 2.6 support. Your "new_drivers"
> document suggests that support should be provided for 2.4 and then
> optionally also for 2.6.

Not quite. Our new_drivers document is meant for people writing code for
the lm_sensors2 project, which supports only the Linux 2.4 kernel as far
as kernel drivers are concerned. This is the reason why it might look
2.4-centric (and probably historical reasons too). We do not actually
care whether people write drivers for Linux 2.4, 2.6 or both.

>                         Is this still the current development model, or
> are you now moving away from 2.4 support? I see from lib/chips.c that
> the W83627EHF device is not supported for 2.4 (yet), so perhaps this is
> the way things are moving?

Writing drivers for Linux 2.6 only if fine. You may want to add
user-space support though, and this happens in the lm_sensors2 project.
There is still a minor issue with 2.6-only drivers (related to alarm
flags) but this is being worked on. If you don't need user-space
support, this part can be skipped.

> o The driver has been written such that it should support the AD7416 and
> AD7418 as well as the AD7417. These devices provide a subset of the
> functionality of the AD7417 (fewer inputs etc.). Unfortunately I am not
> able to test my code with these devices as my hardware only supports the
> AD7417. Would you prefer to see such support present, but with an
> "untested" comment, or removed completely?

Depends on the amount of additional code and the probability that someone
needs it. It also depends on how reliable the chip detection is. If the
detection is poor, we can't afford listing too many possible addresses.

It'll be easier to answer that question once we see the actual driver
code.

> Although all messages/file attachments passing through this gateway are
> scanned for viruses we cannot guarantee that any file is 100%
> virus-free.

Why bother mentioning it then?

--
Jean Delvare
