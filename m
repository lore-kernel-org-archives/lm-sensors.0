From: jroland@linux-migration.net (Jon Roland)
Date: Tue, 23 Aug 2005 06:27:12 +0000
Subject: [lm-sensors] Fw: Processes causing CPU to overheat
Message-Id: <430A5F69.10808@linux-migration.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <430A5153.2040604@linux-migration.net>
In-Reply-To: <430A5153.2040604@linux-migration.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Thanks for your response. No, it's not dust. Problem hasn't recurred, so I can't 
open the case to see if the fan has stopped or slowed when the temp begins to 
rise, but that is an obvious next move if it does.

Of course, mechanical problems would not correlate with CPU load, processes, and 
disk load, stopping the CPU fan (or increasing power to the CPU) when the nice 
usage (not system or user) pegs at 100%, and dropping back to normal when the 
first perl process is killed, which also causes all the other perl processes to 
end, and the nice usage to drop to zero. Nothing else causes the CPU temp to rise. 
I have done this process kill twice now, so it is not a coincidence.

I don't know why my log file is truncated at 80 columns to reveal more information 
about those perl processes.

Phil Edelbrock wrote:
> 
> Weird.  Something I would check is to make sure that dust hasn't  caused 
> the CPU fan to slow (or stop).  I had problems with a server  this 
> summer which had lots of dust, and a slightly mis-installed CPU  
> heatsink.  The result was rapidly rising temps (and hangs) when the  
> computer was loaded.
> 
> I think you need to look inside the server to see just what is going  on 
> there at the heatsink and CPU.  Are things installed right?  Is  there 
> dust or something causing the heatsink/fan to not work  properly?  Is 
> the environment the server is in OK (temp and humidity  should be low).  
> Heatsinks sometimes have a piece of plastic which  needs to be peeled 
> off the heatsink compound before installation.
> 
> BTW- I hope you know what's causing the strange loading (those Perl  
> processes?).  If that's unusual, then you could have some nasty  spammer 
> or somebody using your box to do evil things.  BBTW- Your top  output 
> doesn't show much becuase that it's cut off on the right side  where 
> things are just get interesting. Oh, and I have no idea why  sensor 
> values disappear unless the driver or something is being  unloaded(?).
> 
> 
> Phil

-- 

----------------------------------------------------------------
Linux Migration Network   7793 Burnet Road #37, Austin, TX 78757
512/374-9585 www.linux-migration.net jroland@linux-migration.net
----------------------------------------------------------------
