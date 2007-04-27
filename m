From: Magnus Ekhall <koma@lysator.liu.se>
Date: Fri, 27 Apr 2007 19:01:04 +0000
Subject: Re: [lm-sensors] No pwm with abituguru driver?
Message-Id: <46324870.9070603@lysator.liu.se>
List-Id: <lm-sensors.vger.kernel.org>
References: <4632306A.5010904@lysator.liu.se>
In-Reply-To: <4632306A.5010904@lysator.liu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hans de Goede wrote:
> 
> Most likely your pwm is already in auto mode and things are working just
> fine, as this uguru feature will work fine without any driver at all.
> 

You are right, changing values in BIOS seems to work!


> 
> Another reason you're getting permission denied might be because you're
> doing something like this:
> sudo echo "2" > /sys/devices/platform/abituguru.224/pwm1_enable
> 
> Notice that that won't work as the redirect will be done as the normal
> user, you must really _be_ root for this to work.
> 


That was it. I was sudoing! Becoming root made it possible to write to
pwm1_enable, and it seems to be controlling the CPU fan only.


Thanks a lot for the fast and verbatim answer!

If I can help the project with info from my AN8 Fatal1ty I would be
happy to. Just let me know.

Cheers,
Magnus E

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
