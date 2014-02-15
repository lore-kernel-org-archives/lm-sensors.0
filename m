From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 15 Feb 2014 19:55:35 +0000
Subject: Re: [lm-sensors] CPU temperatures not being showed?
Message-Id: <20140215205535.4f32f916@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <BLU0-SMTP159BE1B809DF98E17A3FC8EE19F0@phx.gbl>
In-Reply-To: <BLU0-SMTP159BE1B809DF98E17A3FC8EE19F0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 16 Feb 2014 00:23:39 +0500, Muhammad Umair wrote:
> Also the reason I am trying to use lm-sensors is that because machines in  
> our lab with the same configuration are experiencing random spontaneous  
> reboots, which may occur with a gap of a few days or may not occur at all.  
> The logs show nothing so I was suspecting a hardware problem. Will the  
> readings from lm-sensors be atleast reliable enough in those regards? to  
> identify if maybe the reboots are somehow temperature related? I was  
> planning on scripting a small cron to log CPU temperatures using  
> lm-sensors periodically, so I could look at them the next time the machine  
> reboots.
> 
> Any thoughts on that?

Yes, it is a good idea to use lm-sensors for that. You could use
sensord to log the values, for example. You may want to decrease the
logging interval to say 1 minute, instead of the default 5 minutes, to
increase your chances to catch the problematic conditions (if that's
really what your problem is.)

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
