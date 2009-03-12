From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 12 Mar 2009 12:16:20 +0000
Subject: [lm-sensors] Revision of sensors-detect
Message-Id: <20090312131620.29f81395@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Axel,

We often ask our users to test the latest version of sensors-detect.
They typically get it from SVN through the trac interface:
  http://www.lm-sensors.org/browser/lm-sensors/trunk/prog/detect/sensors-detect?format=txt
Unfortunately, trac doesn't honor keyword substitutions, so when the
user reports the output, we get:

# sensors-detect revision $Revision$

Not very useful. The bug (or at least missing feature) has already been
reported upstream 5 years ago, and I've added a comment there yesterday:
  http://trac.edgewall.org/ticket/717#comment:10
I don't expect this ticket to get fixed soon.

An alternative is to use the SVN web interface:
  http://www.lm-sensors.org/svn/lm-sensors/trunk/prog/detect/sensors-detect
Unfortunately there is no keyword substitution there either. Does
anyone know if there is a way to enable it?

If not, it would be nice to have a workaround. I have one, which is a
simple CGI script which fetches the file using the svn command line
client and prints its contents:

#!/bin/sh
echo "Content-type: text/plain"
echo
svn cat http://www.lm-sensors.org/svn/lm-sensors/trunk/prog/detect/sensors-detect

I've tested it locally and it works fine for me. I could run it on my
home server, however I think it is better for the users if they get the
script from lm-sensors.org. They really have no reason to trust my
personal server (which may also disappear someday.)

Axel, is there a chance we could run this CGI script on lm-sensors.org
and point users to it when we want them to test the latest version of
sensors-detect?

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
