From: joelb@lanl.gov (Joel R. Berendzen)
Date: Thu, 19 May 2005 06:25:56 +0000
Subject: new scan script and cgi-bin history plot
Message-Id: <32362.128.165.0.81.1115422400.squirrel@webmail.lanl.gov>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi, Developers,

I have a cluster that tends to get unreliable in the summers, so I wanted
to use lm_sensors to keep tabs on it.  Although there are many packages
out there to provide current conditions, I found only a few that log
conditions so that one can spot trends.  The trends that I'm most worried
about tend to build up over a matter of months as the weather heats up and
the cooling system clogs with dust.

Tellerstats was the closest thing I found, but it wasn't really very
close.  I really wanted the following features:
1. A time history showing the whole history of the node, with more detail for
   more recent history.  A log plot would be perfect.
2. Rather than plotting absolute voltages and temperatures, I really
wanted to
   see how close things are to limits.
3. I wanted a script to send warnings by e-mail or do shutdowns.
4. I wanted to use the configuration work in sensors.conf and not have to
   re-do the information in that file all over again for a script.

So, I wrote a couple of shell scripts.  Since I think they might be
generally useful, I wanted to pass them along.  I'm not subscribed to this
mailing list, and I'm not sure if attachments are stripped out, but I'm
including the scripts and an example of the output as an attachment. 
Please let me know if I need to send things another way.  I would
appreciate it, if you agree these scripts are generally useful,  if you
include these scripts in the downloadable scripts at the lm_sensors web
site.

Cheers,
  Joel Berendzen
-------------- next part --------------
A non-text attachment was scrubbed...
Name: scan_sensors.tgz
Type: application/x-compressed-tar
Size: 25603 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050506/a5293ed0/scan_sensors.bin
