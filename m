From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:05 +0000
Subject: LM87 support in LK2.6
Message-Id: <20040707220108.5d14829f.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <406C6981.6060306@mascorp.com>
In-Reply-To: <406C6981.6060306@mascorp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> What does sensors mean when it says:-
> 
> flex scanner jammed

Typically this means that the sensors.conf file has something sensors
doesn't like or recognize. It happens when one uses a new configuration
with an old version of libsensors, for example.

> I gen this when running sensors -s to try to set the values
> from /etc/sensors.conf.

Try starting from the default configuration file again. If you hit the
problem again, try locating the line which causes it. Debugging that
kind of things isn't easy. You may appreciate the help of strace.

> Also when I try setting the values by hand (for example the temp1
> maximum) using the /sys files, it has no effect.

It's probably something different. I'd suspect that the driver isn't
doing its job properly. Maybe the feature is simply not implemented for
now? I'd need to see the code to tell you more.

-- 
Jean Delvare
http://khali.linux-fr.org/
