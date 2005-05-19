From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:37 +0000
Subject: Fujitsu Siemens sensor HERMES
Message-Id: <1075279378.40177612eb80e@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F70765D.5060209@gmx.de>
In-Reply-To: <3F70765D.5060209@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > [Don't forget to CC: the mailing list on replies please]
> 
> Well, all mails so far, have had a reply-to address. Just the last
> one had not. I'll have to be more careful then ;-)

Because I have been sending it through IMP instead of my usual mail
client (Sylpheed for that matter). It doesn't let me set a Reply-To
header, I'm sorry about that... Same goes for this one, BTW.

> video:/soft/src/lm_sensors2/kernel/chips # cat \
> 	/sys/bus/i2c/devices/0-0073/fan_div1
> 2
> video:/soft/src/lm_sensors2/kernel/chips # echo 1 > \
> 	/sys/bus/i2c/devices/0-0073/fan_div1
> video:/soft/src/lm_sensors2/kernel/chips # cat \
> 	/sys/bus/i2c/devices/0-0073/fan_div1
> 2
> video:/soft/src/lm_sensors2/kernel/chips #
> 
> Nothing special. The invalid value is simply ignored. Although
> set_fan_div()  returns -1 in that case, echo doesn't show any error.

Could you please check the value returned by echo? (i.e. "echo 1 >
fan_div1 ; echo $?"). I don't really think it can show the error, but
who knows... But why would we be allowed to return errors in these
functions if we cannot catch them later?

> How about adding a printk() for that case?

Sound like a good idea (although I think you have to use dev_info() or
something similar, not printk(), in Linux 2.6).

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
