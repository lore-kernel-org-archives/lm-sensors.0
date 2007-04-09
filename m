From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Mon, 09 Apr 2007 13:45:06 +0000
Subject: [lm-sensors] Taking a closer look at lm-sensors, Makefile brokeness
Message-Id: <461A479F.5000405@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

Because of the integration of the dynamic chip support written by my students, 
I've been taking a (much) closer look at lm-sensors userspace.

The current makefile is broken for use by any serious distribution / any 
distribution will need to patch it.

Why? Well because of the abundant use of ":=" instead of "="

For example the Makefile says:
"PREFIX := /usr/local"

Now when one wants an other prefix, normally in the build script for the distro 
one would invoke make like this:

make PREFIX=/usr

however because of the unnecessary use of :=, this isn;'t work as := will 
overwrite any environment / make commandline settings. This leads to distro's 
using patches to the makefile like the one attached.

Is it ok if I fix this in the 3.0.0 branch?

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
