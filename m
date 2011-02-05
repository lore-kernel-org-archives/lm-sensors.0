From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 05 Feb 2011 13:37:43 +0000
Subject: Re: [lm-sensors] SUSE, 10.2
Message-Id: <20110205143743.4aeed911@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <AANLkTikLRKrsr7M2C9+qJry6Qn-C5KHuSgv5mXmxOUj8@mail.gmail.com>
In-Reply-To: <AANLkTikLRKrsr7M2C9+qJry6Qn-C5KHuSgv5mXmxOUj8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Please don't top-post.

On Sat, 5 Feb 2011 11:09:06 -0200, Marcelo De Cicco wrote:
> Hi Jean,
> 
> I tryed sensor-detect, after a lot of "YES", and writing rc* file as
> recommended,  I stopped at this point
> 
> 
> "Do you want to generate /etc/sysconfig/lm_sensors? (YES/no): YES
> insserv: script suse.pbs_mom: service pbs_mom already provided!
> insserv: script suse.pbs_sched: service pbs_sched already provided!
> insserv: script pbs_server: service pbs_server already provided!"

I have no idea what these scripts are, but they are not related to
lm-sensors, and these warnings seem harmless.

Now start the lm_sensors service:
# rclm_sensor start

And see if anything is printed by "sensors".

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
