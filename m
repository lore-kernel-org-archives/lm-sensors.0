From: ivan@cacad.com (Ivan Kalvachev)
Date: Thu, 19 May 2005 06:25:53 +0000
Subject: 2.4.30 kernel panic with bttv and i2c-2.9.1
Message-Id: <20050422152915.046eb733@me>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

From few days I'm having an bt878 based capture card.
I was able to make it work with bttv driver in the 2.4.30 kernel.
Then I installed latest i2c and lm-sensors (2.9.1) and jumped into
problems.

I have attached /proc/ksym copied after the oops, 
the /var/log/ksymoops/ directory,
the original nonprocesses kernel message,
and ksymoops-ed message using modprobe logs as kops1.txt.
 (probably ksym would be  better - attached as kops2.txt)

Best Regards
   Ivan Kalvachev
  iive
