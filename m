From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:28 +0000
Subject: i2c-ali1535.c:548: warning: initialization from incompatible
Message-Id: <20050103184145.18d68af9.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <41D6E143.8030204@arcor.de>
In-Reply-To: <41D6E143.8030204@arcor.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > Which chip is this?
> 
> via686a-isa-0c00 (according to sensors). The modules I load are
> 
> 	i2c-viapro
> 	i2c-isa
> 	via686a

Note that you don't really need i2c-viapro in this case (and it would
even cause trouble if you were running a 2.6 kernel).


> > Did you run "sensors -s"?
> 
> Yes.

Could you try not to run it after a cold reboot, and see what the
initial value is? This will help us understand whether reading the value
or writing the value is the problem.

> > You might simply need to set the min RPM count through the
> > /etc/sensors.conf file and run "sensors -s" afterwards.
> 
> I have not changed sensors.conf for quite a while and the problems 
> started to appear in 2.9.0. In 2.8.x, everything was fine.

OK, so this is definitely a new bug. This is strange, I can't remember
of anything similar.

> I have checked on another system that had the some compile problems I 
> fixed the same way (copying *.h to /usr/local/include/linux). It has 
> w83627hf-isa-0290 as chip and also some weird values:
> 
> fan1:     5720 RPM  (min = 21093 RPM, div = 2)
> fan2:        0 RPM  (min = 84375 RPM, div = 2)

And that's a different chip. This would suggest that the bug is in
libsensors and not in the drivers.

> What could that be? Maybe I shall erase the sensors.conf and let it 
> re-install it?

You can still try but I doubt it'll help. There is no reason why a
working configuration file would suddenly stop working.

What you could do OTOH is manually delete the latest version of
libsensors (3.0.7) in /usr/local/lib, so that the previous one is used
instead (that would be 3.0.6 if you installed lm_sensors 2.8.8 before).
If the readings are back to normal, then it has to be a library bug.

Thanks,
-- 
Jean Delvare
http://khali.linux-fr.org/
