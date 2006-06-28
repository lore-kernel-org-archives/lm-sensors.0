From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Wed, 28 Jun 2006 10:49:01 +0000
Subject: [lm-sensors] A better fan control program
Message-Id: <20060628104901.GB3140@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <44A2556C.7070205@lshift.net>
In-Reply-To: <44A2556C.7070205@lshift.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Paul:

* Paul Crowley <paul at lshift.net> [2006-06-28 11:09:48 +0100]:
> I know there are several programs out there that adjust your fan speed 
> based on temperature readings.  However, I couldn't find one worked well 
> on my system, so I wrote my own.   This program takes a very simple 
> approach: if the system is too hot, the fans run on maximum power, 
> otherwise they run at minimum power.  The reasoning behind this approach 
> is explained at length here:
> 
> http://www.lshift.net/blog/2006/06/26/thermostat-defeat

I skimmed through the blog entry and the earlier one which it references.
In your first attempt you reinvented the 'P' part of a PID control loop.
Don't give up! ;)  There's a *ton* of info about PID controllers on the
web.  If you're still interested, you could start here:

http://en.wikipedia.org/wiki/PID_controller

Regards,

-- 
Mark M. Hoffman
mhoffman at lightlink.com


