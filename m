From: erict@alum.rpi.edu (er0ck)
Date: Thu, 19 May 2005 06:24:55 +0000
Subject: Ticket #: 1659   it87: it8712f module stops working
Message-Id: <1083111806.1346.9.camel@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <1083021688.1553.27.camel@localhost>
In-Reply-To: <1083021688.1553.27.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

it's not after 10 mins afterall...  i've also loaded the hell out of the
system using stress, and it didn't seem to have any immediate effect.  

i've seen it crap while just using the machine (usually below 1% load),
or while i'm not on it, and xscreensaver is running (above 50% load).

i can't get it to stop working by hand by activating xscreensaver, nor
by using stress though.  

i thought i had enabled debug in lm_sensors but i guess it didn't work. 
(silly gentoo).    so i'll get that working, build some small kernel
with nada and no modules and see what happens...

i've also recently seen it crap the bed but still return stuff that's
not 0x08:
such as +4 for the positive in sensors.  
also: 
as you may have noticed i have both an i2c and ISA sensor output, which
i haven't been able to figure out how to turn one off but i don't really
care and figure it's simple....
but what's really strange is that sometimes after the module stops
working those two produce different results??  weird



_____________________________________________
     /\  ()      /\       erOck
    /  \    /\  /  \/\    Eric Thompson
 /\/    \  /  \/      \   www.erict.net
/        \/            \  
--------------------------------------------- 
Ginger snap.
