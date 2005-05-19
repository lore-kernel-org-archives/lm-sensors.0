From: tgriggs@keyww.com (Travis Griggs)
Date: Thu, 19 May 2005 06:23:41 +0000
Subject: help please
Message-Id: <3DB43964.7030303@keyww.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Sigh. I apologize for bugging who's ever at the other end of this. I 
have tried to do due diligence in reading and trying all kinds of stuff, 
and I think I know what the problem is I'm having, but I'm just green 
enough with this kind of low level stuff to not be for sure. I did 
follow the flowchart thing.

Anyway, I've got this 1U Intel board with a 1.7 P4 on it. To do burn in 
testing the hardware guys want to be able to do temperature sensing. 
They're all tickled that some app in XP can do it. And I just am not 
having any luck getting it to work under Linux on this machine.

I have Libranet 2.7 installed (kernel 2.4.19). I have the lm-sensors 
debian package installed. When I do a sensors-detect, it probes 
i2c-i801, but modprobe can't locate it. Where would I get this? Can I 
get it as a binary? Maybe I need to load the i2c-source package and look 
to compile it from there.

The Intel board rep sent us this info about the temperature controller:

"The Intel(R) S845WD1-E server board uses a Heceta 6 management 
controller to monitor thermal zones, fan speeds and voltages. The Heceta 
6 management controller is a separate controller mounted on the server 
board."

I've looked all over the lm-sensors web site, but it is not clear to me 
whether there is support for the Heceta 6.

Any help/hints/tips/suggestions would be very much appreciated. TIA.

-- 
Travis Griggs
Key Technology

"Oh, Say can you see
By the pawn's early plight
What so loudly we wailed
At the trials' past scheming.

Whose blue screen and oft starts
Through the endless blight
O'er the networks we watched
Wwere so total en-slaving.

And the public's ensnare
The bugs always in there
Gave truth to the might
That Bill's flag was still there.

Oh say does that Steve Screamin Ballmer yet wave
To the land of the free
But he wants us to pay."
