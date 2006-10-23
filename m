From: udovdh@xs4all.nl (Udo van den Heuvel)
Date: Mon, 23 Oct 2006 14:41:07 +0000
Subject: [lm-sensors] w83627hf 9191-0290: If reset=1 solved a problem
Message-Id: <453CD483.1010106@xs4all.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <453B393C.9000204@xs4all.nl>
In-Reply-To: <453B393C.9000204@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Jean,

Jean Delvare wrote:
> OK, so let me summarize what I understood:
> 
> * When your computer boots, fans are spinning.
> * If you load the w83627hf driver with no parameter, the fans stop.
> * If you instead load the w83627hf driver with reset=1, the fans don't
>   stop.
> 
> Is that it? 

Not entirely.
If I rename w83627hf.ko to something else and reboot, the fans stop.
Then I rename w83627hf.ko back to its original name and do modprobe
(without stuff in modprobe.conf) and the fans stay still.
I rmmod w83627hf and then try with the reset=1 parameter.
Only then the fans start spinning.

> If so, I consider it a critical issue which needs to be
> addressed quickly.

Depending on the cause, yes.
See my description, also without the w83627hf driver the fans stop. (!?)

> If "sensors -s" is run as part of your init scripts, please remove it
> and check again, I'd like to get it out of the list of suspects.

Is it part of fedora startup scripts? I will do a grep.

> Which kernel are you using? Is it from your distribution, or
> self-compiled?

2.6.18.1, self compiled. I can mail you my config.

> Do you also have the w83781d driver loaded?

Not that I am aware. I only enabled sensors drivers for historical
reasons or for this new board.

 > What if you load w83627hf with init=0 (and not reset=1)?

Will try that later.


Udo

