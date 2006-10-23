From: udovdh@xs4all.nl (Udo van den Heuvel)
Date: Mon, 23 Oct 2006 08:32:30 +0000
Subject: [lm-sensors] w83627hf 9191-0290: If reset=1 solved a problem
Message-Id: <453C7E1E.8000802@xs4all.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <453B393C.9000204@xs4all.nl>
In-Reply-To: <453B393C.9000204@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Jean,

Jean Delvare wrote:
> On Sun, 22 Oct 2006 11:26:20 +0200, Udo van den Heuvel wrote:
>> I report that I have to use reset=1 for w83627hf to make my fans start
>> again after booting the kernel on VIA Epia EK8000.
>> The w83629hf driver sees a w83697hf chip.
> 
> I'd need more information.

OK.

> Are there options related to fan speed control in your BIOS? If there
> are, what are they set to?

None, as far as I know. Just a System Health page to see status.

> What is the fan status at boot time (i.e. before loading the w83627hf
> driver)?

Fans running. (two fans atached to the system fan connector on the
mainboard)

Udo

