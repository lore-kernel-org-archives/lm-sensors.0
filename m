From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:11 +0000
Subject: sensors -s & adm1027
Message-Id: <20040813205750.3c8a6e54.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <web-77741@free.net>
In-Reply-To: <web-77741@free.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Sorry, you overestimated me :-) Is the last line in this part of 
> conf-file (follows) wrong ?
> 
> Yours
> Mikhail
> 
> chip "adm1027-*"
>      ignore fan4
>      ignore pwm1
>      ignore pwm2
>      ignore pwm3
>      ignore temp2
>      ignore vid
>      label in0 "VDD 2.5V"
>      label in1 "DDR VTT"
>      label in2 "3VSB"
>      label in3 "+5 V"
>      label in4 "+12V"
>      label fan1 "chs1 fan"
>      label fan2 "chs2 fan"
>      label fan3 "chs3 fan"
>      label pwm1 "pwm1 fan"
>      label pwm2 "pwm2 fan"
>      label pwm3 "pwm3 fan"
>      label temp3 "CPU1 Temp"
>      label temp1 "CPU2 Temp"
>      set vid 2.4

Yes it is. As I said in ticket #1682. You cannot set the vid value by
yourself. Instead, you can select how VID pins are converted to a
voltage by changing the VRM version.

Anyway, you don't seem to display nor use the vid value anyway, so you
can simply delete the line from your configuration file and everything
should be fine.

-- 
Jean "Khali" Delvare
http://khali.linux-fr.org/
