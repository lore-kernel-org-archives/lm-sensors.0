From: ivan@cacad.com (Ivan Kalvachev)
Date: Thu, 19 May 2005 06:25:53 +0000
Subject: 2.4.30 kernel panic with bttv and i2c-2.9.1 (try2)
Message-Id: <20050422153145.6f9389e6@me>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050422152915.046eb733@me>
In-Reply-To: <20050422152915.046eb733@me>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

From few days I'm having an bt878 based capture card.
I was able to make it work with bttv driver in the 2.4.30 kernel.
Then I installed latest i2c and lm-sensors (2.9.1) and jumped into
problems- kernel panic.


I have attached archive with:
/proc/ksym copied after the oops, 
the /var/log/ksymoops/ directory,
the original nonprocesses kernel message,
and ksymoops-ed message using modprobe logs as kops1.txt.
 (probably ksym would be  better - attached as kops2.txt)

Best Regards
   Ivan Kalvachev
  iive


Oops, forgot the attachment first time :|
-------------- next part --------------
A non-text attachment was scrubbed...
Name: i2c291oops.tgz
Type: application/octet-stream
Size: 63267 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050422/e54f24c8/i2c291oops.obj
