From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 23 Oct 2006 06:51:07 +0000
Subject: [lm-sensors] w83627hf 9191-0290: If reset=1 solved a problem
Message-Id: <20061023085107.de9dc7bf.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <453B393C.9000204@xs4all.nl>
In-Reply-To: <453B393C.9000204@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Udo,

On Sun, 22 Oct 2006 11:26:20 +0200, Udo van den Heuvel wrote:
> I report that I have to use reset=1 for w83627hf to make my fans start
> again after booting the kernel on VIA Epia EK8000.
> The w83629hf driver sees a w83697hf chip.

I'd need more information.

Are there options related to fan speed control in your BIOS? If there
are, what are they set to?

What is the fan status at boot time (i.e. before loading the w83627hf
driver)?

Thanks,
-- 
Jean Delvare

