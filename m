From: Stefan Seidel <tech@stefanseidel.info>
Date: Sat, 01 Mar 2014 19:44:47 +0000
Subject: [lm-sensors] PROBLEM: it87 not restoring temp?_offset after resume from suspend
Message-Id: <CACcUPpZ6NRA8+8tjrqT9cfEYxsYkh9GjoqJpJQO0ruev=qT+fg@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I'm running kernel 3.13.5 (on Arch Linux) and I noticed this problem:
 - sensor temp1 is of type Intel PECI, so the temps are negative
 - the firmware sets the temp1_offset to 80000 to make these values > 0 in
order to make the automatic fan control working
 - when I suspend->resume the system, temp1_offset will be 0, meaning that
the fan will always stay at the lowest speed
This could possibly destroy some hardware, since even when running at very
high temperatures, the fan will not spin faster because the temp1 reading
remains negative (or at least only comes close to 0).
I've worked around this with a system on-resume script, but obviously the
driver should restore the previous temp?_offset values upon system resume
from S1/S3.

The actual hardware is a Zotac ZBOX IQ01.

Let me know if there's any additional information you need.

Best regards,

Stefan Seidel
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
