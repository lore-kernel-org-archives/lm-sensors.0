From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 04 Feb 2012 19:35:32 +0000
Subject: Re: [lm-sensors] it87 chip and kernel 3.2.2 issue.
Message-Id: <20120204203532.13e5c975@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CANLOsR7+rDwQ6o=UUysYj2bUQmq8aRK6C+khMqAxasyzQZCbLg@mail.gmail.com>
In-Reply-To: <CANLOsR7+rDwQ6o=UUysYj2bUQmq8aRK6C+khMqAxasyzQZCbLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 4 Feb 2012 17:32:51 -0200, Sergio Cipolla wrote:
> So from kernel 2.6.39 till 3.2.1 it was behaving just as if I set
> acpi_enforce_resources=lax in the kernel cmdline now?

More like acpi_enforce_resources=no, but yes, you got the idea.

> My system is an old Athlon XP, if I disable ACPI in the BIOS would I lose
> anything else besides not being able to shut down the PC from the case
> button?

That I can't tell, it so much depends on the BIOS and ACPI can do so
many things.

> I know this has gone 'off-topic', just asking in case it's a simple answer.

This isn't off-topic at all, no problem.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
