From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:32 +0000
Subject: lib/proc.c update pending kernel patch?
Message-Id: <20040105000918.GG30841@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi:

In the comments of lib/proc.c are these two lines:

	temp%d_over -> temp_max%d (to be changed after kernel patch)
	temp%d_hyst -> temp_min%d ("")

Would anyone object if I change this code to... ?

	temp%d_over -> temp_over%d
	temp%d_hyst -> temp_hyst%d

With Linux 2.6.1-rc1 out, that was the intention, right?

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
