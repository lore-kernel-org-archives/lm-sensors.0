From: paul@lshift.net (Paul Crowley)
Date: Wed, 28 Jun 2006 12:13:40 +0000
Subject: [lm-sensors] A better fan control program
Message-Id: <44A27274.4020909@lshift.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <44A2556C.7070205@lshift.net>
In-Reply-To: <44A2556C.7070205@lshift.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Mark M. Hoffman wrote:
> I skimmed through the blog entry and the earlier one which it references.
> In your first attempt you reinvented the 'P' part of a PID control loop.
> Don't give up! ;)  There's a *ton* of info about PID controllers on the
> web.  If you're still interested, you could start here:
> 
> http://en.wikipedia.org/wiki/PID_controller

Very interesting stuff, thanks!

My quick reading of this stuff indicates a possible problem.  On my 
system at least, I can only read the temperature in whole degrees; 
lm-sensors returns a number in thousandths of a degree, but sadly the 
last three digits are always zero.  This means that our differentiation 
of the temperature will be very crude, which could make it difficult to 
build a functioning PID controller.

How can I find out the maximum safe operating temperature of my current 
CPU?  Since my first priority is something that works on my current 
system, the only reason for me to pick this up again and explore in more 
detail is if I can afford to slow the fan even when the system is flat 
out, which means I need to know how fast I can run it.

Thanks again!
-- 
   [][][] Paul Crowley
     [][] LShift Ltd
   []  [] www.lshift.net

