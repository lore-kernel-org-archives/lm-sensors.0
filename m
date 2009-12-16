From: marko <marko.smit@quicknet.nl>
Date: Wed, 16 Dec 2009 20:23:45 +0000
Subject: [lm-sensors] I got it working, with some help
Message-Id: <op.u41r9vhq4e0zct@marko-desktop>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi, I mailed you yesterday that I had trouble to get lm-sensors working.
I had some help on a forum and it turned out to be a GRUB setting that  
causes the problems.
I had to replace the line GRUB_CMDLINE_LINUX_DEFAULT="quiet splash" with  
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash acpi_enforce_resources=lax"
in the file /etc/default/grub , and then had to type sudo update-grub in  
the terminal and then restart Ubuntu.
This is a solution in GNU GRUB version 197~beta 4 that gets installed on  
an ext/4 journaling file system.

Now your software is working fine, I hope it will help your program.

I'm sorry that I got angry at lm-sensors, it now turns out to be a missing  
line in GRUB.

Greetings,
                    marko smit


-- 
-CHF-

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
