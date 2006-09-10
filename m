From: Marc.Kalberer@programmers.ch (Marc Kalberer)
Date: Sun, 10 Sep 2006 19:47:01 +0000
Subject: [lm-sensors] VT1211-ISA-6000 &  procfs/sysfs
Message-Id: <45046BB5.5040404@programmers.ch>
List-Id: <lm-sensors.vger.kernel.org>
References: <45034A2F.2020701@programmers.ch>
In-Reply-To: <45034A2F.2020701@programmers.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

Seems that using the SVN sources was the solution.
Now I don't get this "procfs/sysfs" message anymore.  I'll look forward 
into the configutaion of the fans to see if everything really work... 
this noise is making me crazy ;-)
Thanks for the answer ... and for your work !!
Marc


> Probably a different problem. pwmconfig and fancontrol are known to be
> broken for platform drivers, which the vt1211 driver is. Anyway, the
> VT1211 does not support manual fan speed control, which is when
> pwmconfig and fancontrol are useful for, so you probably won't miss
> them.
>   
Good to know ;-), I won't look forward it that direction.


-- 
Programmers.ch
Solutions libres et Opensources
Tel: ++41 76 44 888 72
Site: http://www.programmers.ch
Site: http://openprojects.ch


