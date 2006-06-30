From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Fri, 30 Jun 2006 11:19:54 +0000
Subject: [lm-sensors] A better fan control program
Message-Id: <20060630111954.GC3140@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <44A2556C.7070205@lshift.net>
In-Reply-To: <44A2556C.7070205@lshift.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Paul:

* Paul Crowley <paul at lshift.net> [2006-06-28 13:13:40 +0100]:
> Mark M. Hoffman wrote:
> > I skimmed through the blog entry and the earlier one which it references.
> > In your first attempt you reinvented the 'P' part of a PID control loop.
> > Don't give up! ;)  There's a *ton* of info about PID controllers on the
> > web.  If you're still interested, you could start here:
> > 
> > http://en.wikipedia.org/wiki/PID_controller
> 
> Very interesting stuff, thanks!
> 
> My quick reading of this stuff indicates a possible problem.  On my 
> system at least, I can only read the temperature in whole degrees; 
> lm-sensors returns a number in thousandths of a degree, but sadly the 
> last three digits are always zero.  This means that our differentiation 
> of the temperature will be very crude, which could make it difficult to 
> build a functioning PID controller.

Read under 'Limitations' in the wikipedia article.  One suggestion is
to just skip the differential band altogether (PI controller).

> How can I find out the maximum safe operating temperature of my current 
> CPU?  Since my first priority is something that works on my current 
> system, the only reason for me to pick this up again and explore in more 
> detail is if I can afford to slow the fan even when the system is flat 
> out, which means I need to know how fast I can run it.

You can find this info in processor datasheets, which are available on
Intel/AMD websites.  It shouldn't be too hard to find.  Otherwise, you
could consider 55 C to be a very conservative limit.  Some Intel cpus
are OK up to 85 C, but it really does depend on the model *and* maybe
even the stepping.

Something else to consider: if you do tune your system to keep the CPU
near max temp, make sure that the extra heat is not going to affect
your disk(s).

Regards,

-- 
Mark M. Hoffman
mhoffman at lightlink.com


