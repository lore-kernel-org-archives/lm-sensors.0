From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 09 Dec 2010 16:09:18 +0000
Subject: Re: [lm-sensors] Testing LM-Sensor Support of SCH5127 in Acer
Message-Id: <20101209170918.53ace941@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <57920.75.142.173.238.1291011644.squirrel@webmail.myamigos.us>
In-Reply-To: <57920.75.142.173.238.1291011644.squirrel@webmail.myamigos.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 9 Dec 2010 14:46:39 +0100, Juerg Haefliger wrote:
> > Do you happen to know if any of these are internal (so that the
> > mapping/label doesn't depend on the system)? This would help. in2 and
> > in6 would be candidates, maybe in5 as well.
> 
> From the datasheet it looks like in2, in5 and in6 need to be wired as
> specified otherwise the chip will not work properly under certain
> conditions. VTR is the standby voltage and if standby mode is not
> required, could be connected to VCC externally.

I propose the following default configuration file section for the
SCH5217:

chip "sch5127-*"

   label in2  "+3.3V"
   label in5  "3VSB"
   label in6  "Vbat"

> > Do you have any clue what
> > "VTR" stands for?
> 
> VTR is the ATX standby voltage also called trickle voltage (courtesy
> of google :-)

Strange, http://en.wikipedia.org/wiki/ATX doesn't mention either VTR or
trickle voltage. It does mention "+5 V standby" though (purple wire.)

Anyway, I think we can assume this is what other chips name "3VSB".
Which is strange though because apparently ATX has a +5V stand-by but
no +3.3V standby. So I guess that 3VSB/VTR is actually 5VSB with a
scaling factor, either internal or external.

> > For internal voltages we can put the labels in the default
> > sensors3.conf file, to help the users.
> 
> Ah. I just realized that the SCH5127 has another voltage input that
> the other dme1737 clones don't have but which isn't exposed through
> the driver. Register 0x1f, nominal 1.5V, max 2.0V.

Ah ah! Very interesting. It could be where Jeff's mysterious +1.5V is
connected! Could you write a patch adding support?

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
