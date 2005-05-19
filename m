From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:26 +0000
Subject: EP-9NDA3+ w/ Winbond W83627THF LPC
Message-Id: <FvTSuPID.1103296904.7278680.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <32906.216.9.170.171.1103272080.spork@webmail.necrotec.com>
In-Reply-To: <32906.216.9.170.171.1103272080.spork@webmail.necrotec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> the motherboard manufacturer says it has the chip and sensors-detect says
> it has 9 confidence on w83627hf (it should be w83627(T)hf)..

w83627hf is both the name of a chip and the name of the driver which
handles that chip and 3 other ones (including the w83627thf). That might
have confused you. OTOH, if sensors-detect really told you that you had
a W83627HF then that's what you have (it cannot be misdetected).

> my dmesg and /var/log/messages don't show anymore details after that
> error.. i use syslog-ng.. doesn't seem to report much into
> /var/log/messages.. :(
> (what is a better logger?)

Loggers behave the way they are told to, and another logger wouldn't
tell you more (IMHO). I am really surprised that there is no message in
the logs. Try enabling debug mode and recompile, maybe?

--
Jean Delvare
