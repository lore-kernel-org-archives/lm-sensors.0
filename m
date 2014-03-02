From: Jean Delvare <jdelvare@suse.de>
Date: Sun, 02 Mar 2014 15:04:14 +0000
Subject: Re: [lm-sensors] PROBLEM: it87 not restoring temp?_offset after resume from suspend
Message-Id: <20140302160414.0e7451d8@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CACcUPpZ6NRA8+8tjrqT9cfEYxsYkh9GjoqJpJQO0ruev=qT+fg@mail.gmail.com>
In-Reply-To: <CACcUPpZ6NRA8+8tjrqT9cfEYxsYkh9GjoqJpJQO0ruev=qT+fg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Stefan,

On Sat, 1 Mar 2014 20:44:47 +0100, Stefan Seidel wrote:
> I'm running kernel 3.13.5 (on Arch Linux) and I noticed this problem:
>  - sensor temp1 is of type Intel PECI, so the temps are negative
>  - the firmware sets the temp1_offset to 80000 to make these values > 0 in
> order to make the automatic fan control working
>  - when I suspend->resume the system, temp1_offset will be 0, meaning that
> the fan will always stay at the lowest speed
> This could possibly destroy some hardware, since even when running at very
> high temperatures, the fan will not spin faster because the temp1 reading
> remains negative (or at least only comes close to 0).
> I've worked around this with a system on-resume script, but obviously the
> driver should restore the previous temp?_offset values upon system resume
> from S1/S3.

No. "Obviously" the firmware should do it. They set it at boot, they
are responsible for setting it at resume time too. Just try to not load
the it87 driver at all, the problem is the same, right?

> The actual hardware is a Zotac ZBOX IQ01.

Have you reported to the hardware vendor? Have you looked for a
firmware update?

We could save and restore the temperature offsets in the it87 driver,
but that would only be working around the firmware bug. Automatic fan
speed control is too critical to be left to the OS.

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
