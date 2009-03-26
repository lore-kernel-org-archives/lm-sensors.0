From: Michael Hampton <error@ioerror.us>
Date: Thu, 26 Mar 2009 17:51:44 +0000
Subject: Re: [lm-sensors] LM-sensors and ASUS P6T.
Message-Id: <49CBC0B0.8050405@ioerror.us>
List-Id: <lm-sensors.vger.kernel.org>
References: <32b9ed800903260725g4022cc74ke98f6b0dc9611516@mail.gmail.com>
In-Reply-To: <32b9ed800903260725g4022cc74ke98f6b0dc9611516@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

D'Inverno Jeremy wrote:
> Hy all,
>  
> I try to use LM-sensors at my Fedora Core 9 64bit installed on a Asus
> P6T motherboard, But i think lm-sensors dont see the integrated sensors:

This board uses the W83667HG chip. If you check the archive, there's
some discussion and patches. If my memory serves, the code is about 99%
done. I've been testing the patches here with my P6T6 WS Revolution and
it's working fine.

-- 
Homeland Stupidity <http://www.homelandstupidity.us/>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
