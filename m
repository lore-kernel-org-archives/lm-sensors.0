From: "G. Vincent Castellano" <gvc@ocsystems.com>
Date: Sun, 14 Mar 2010 20:41:57 +0000
Subject: [lm-sensors] conflicts with ACPI region RUNT?
Message-Id: <4B9D4A15.4010200@ocsystems.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I am installing Ubunto 9.10 on a D945GCLF2 Intel Atom Mini-ITX MB with the 
intent of running it as a server.  I have concerns about temperature because one 
of the hard drives has already complained to me via smartd.

The "sensors" command says:

No sensors found!
Make sure you loaded all the kernel drivers you need.
Try sensors-detect to find out which these are.

This is after smsc47m1 was added to /etc/modules and the system restarted.

At startup, syslog is showing:

/var/log/syslog:Mar 14 12:26:53 m5 kernel: [    6.346129] smsc47m1: Found SMSC 
LPC47M15x/LPC47M192/LPC47M997
/var/log/syslog:Mar 14 12:26:53 m5 kernel: [    6.346201] ACPI: I/O resource 
smsc47m1 [0x680-0x6ff] conflicts with ACPI region RUNT [0x680-0x6ff]

Do I need to get with kernel developers, or just do some more of RTFM?  Or what?

Since I'm just standing up this machine, it's available for any debugging or 
other victimization that might speed resolution.

The RUNT message still appears after I set ACPI=off.

Thanks for any assistance.
--gvc

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
