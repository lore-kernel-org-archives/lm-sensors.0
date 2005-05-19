From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:25 +0000
Subject: Thanks and setup problem
Message-Id: <20041204015731.GG7903@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <41AE99A2.8050402@swbell.net>
In-Reply-To: <41AE99A2.8050402@swbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Chris:

* Chris Lopeman <lopemanc@swbell.net> [2004-12-01 22:27:14 -0600]:
> First of all I would like to say that I admire the work you are doing.  
> I think lm_sensors is extremely important to Linux.   Thanks for your 
> efforts.

You're welcome.

> Output from sensors.  As you can see w83781d reports an odd looking 
> temperature.  Specifically the +208.0?C.  Actually, I am not sure what 
> temp1 and 2 are for.  I guess I expect the output to look more like the 
> adm1021 module.   I am hoping I can get all readings from the 
> w83781d-isa-0290 section.  I am a bit of a minimalist and I think the 
> adm1021 module may be causing a problem.

Not sure what you mean by that.  The adm1021s are probably reading your
CPUs, one each.  Run a CPU intensive task for a few minutes and see which
temp sensors go up the quickest... those are attached to CPUs.  The others
are probably reading a board temp somewhere.  Your board might not have
anything at all connected to temp3 on the w83781d... so ignore it by 
modifying sensors.conf.  (try 'man sensors.conf')

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
