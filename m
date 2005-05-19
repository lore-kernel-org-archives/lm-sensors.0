From: John.Morris@spirentcom.com (Morris, John)
Date: Thu, 19 May 2005 06:24:15 +0000
Subject: Question about chip driver policy
Message-Id: <629E717C12A8694A88FAA6BEF9FFCD440224B3AB@brigadoon.spirentcom.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

In the new-drivers document, under the heading "Write the new driver", it
says:

  "Remember that you want to output the direct measurements done by the
  chip. If these sensor values need scaling, this should be done through
  the configuration file."

However, many of the existing drivers don't do this. For example, lm85.c has
this macro:

#define FAN_FROM_REG(val) ((val)=0?-1:(val)=0xffff?0:5400000/(val))

which the driver uses to convert from register values to rps. There are lots
of similar constructs in other drivers.

Which is the right way for new drivers - the code or the documentation?



