From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 16 Jun 2011 18:46:46 +0000
Subject: Re: [lm-sensors] ... Hi I'm Argentian,
Message-Id: <20110616204646.2c20f1b1@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

On Mon, 13 Jun 2011 23:09:42 -0300, Ciraolo Emanuel wrote:
> Hi, 
> 
>                 My name is Emanuel, from Argentina.
> 
> I saw your Project and this is amazing, it is very complete and powerful.
> 
> Actually my job is a programmer, basically SCADA’s to SIDERAR (STEEL
> INDUSTRY). In this  places we hace an SCADA, and is open source, it was made
> in WATCOM C. 
> 
> My question is about LMSENSORS, ‘cause in our PC’s we use QNX RTOS 6.3.2,
> and we need to use this program to see the voltajes, temperatures y more
> about our motherboards.
> 
> The are posibilities to use LM SENSORS in QNX RTOS 6.3.2 ¿? Is there
> posible?

No. lm-sensors heavily relies on Linux kernel drivers, which QNX
doesn't have, so it just can't work.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
