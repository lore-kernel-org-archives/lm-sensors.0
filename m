From: Rudolf Marek <rudolf.marek@sysgo.com>
Date: Mon, 30 Jul 2007 13:57:09 +0000
Subject: Re: [lm-sensors] w83627dhg and coretemp temperature mismatch?
Message-Id: <46ADEE35.3010603@sysgo.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1185800852.23876.91.camel@pancake>
In-Reply-To: <1185800852.23876.91.camel@pancake>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hi Florian
> Thanks - I suspected something along these lines. But why is the
> external sensor then giving a higher temperature reading than the
> internal sensors? Is there some sort of compensation built in, because
> the mainboard manufacturer wants to stay on the safe side? (The
> difference seems to be around 4-5 °C).
>   
I'm the author of coretemp driver. Intel wont tell the Tjmax temperature 
as described in the documentation so
the temperature might be a bit off. Because the CPU provides only a 
relative temperature to hottest possible, one can say
that:

temp1:       +42°C  (high =   +85°C) 

"85-42" C (relative to TjMax) so you are still 43C bellow dangerous level. In other words
if you get close to 85C it is bad, If the temperature reported by coretemp reaches 85C CPU will start to switch itself
on and off. The optimal point when to start massive cooling is set by intel usually 85-16 = 69C 

To sum it up. You are absolutely safe until 69C reported by coretemp. Above this temperature you need to cool the CPU bit more, so it never
reaches 85C.

Hope it is clear, I'm in office and so in hurry ;)


-- 

S přátelským pozdravem / Best regards / Mit freundlichen Grüßen

Ing. Rudolf Marek
SYSGO s.r.o.
Zelený pruh 99
CZ-14800 Praha 4
Phone: +420 222138 627, +49 6136 9948 627
Fax: +420 296374890, +49 6136 9948 1 627
rudolf.marek@sysgo.com

http://www.sysgo.com | http://www.elinos.com | http://www.pikeos.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
