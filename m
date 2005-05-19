From: seth@integratedsolutions.org (Seth Bardash)
Date: Thu, 19 May 2005 06:23:31 +0000
Subject: Ticket 854 - Cancel
Message-Id: <DAEMKKFFGJCEMKANCFOEOEPOCIAA.seth@integratedsolutions.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

To the developers and maintainers,

With the help of Kelsey Hudson from ticket 840 I got this working.

Attached are the files and modifications needed. It was not clear
exactly how to set these up. Once I spoke to Kelsey he got me going
in the right direction and I now have this working. The biggest
mistake was putting spaces after the commas in the options
command in modules.conf. The ticket and my printer had me
going in the wrong direction. (sucks syntax!)

For those of us not on the up to date edge of your wonderful
work, we need a little more explicit instructions.

Attached are the files that need to be added/modified to get
i2c and lm sensors working on the S2466.

Thanks for all the work you put in and for the site. It was
a learning experience. We use your code almost every day and
for new system testing its indispensable!

Sincerely,

Seth Bardash - KI?PE

Integrated Solutions & Systems L.L.C.
http://www.integratedsolutions.org

1510 North Gate Road
Colorado Springs, CO 80921

Phone:   719-495-5866
Fax:     719-495-5870
Cell:    719-460-4368

seth@integratedsolutions.org

Supplier of AMD, Intel and SPARC Servers and Systems
running Windows, Linux, Solaris and VxWorks.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: modules.conf
Type: application/octet-stream
Size: 174 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20020328/8d523c08/modules.obj
-------------- next part --------------
A non-text attachment was scrubbed...
Name: rc.local
Type: application/octet-stream
Size: 497 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20020328/8d523c08/rc.obj
-------------- next part --------------
A non-text attachment was scrubbed...
Name: sensors.conf
Type: application/octet-stream
Size: 3428 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20020328/8d523c08/sensors.obj
