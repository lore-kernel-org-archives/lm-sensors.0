From: rainer.lay@informatik.uni-erlangen.de (Rainer Lay)
Date: Thu, 19 May 2005 06:24:06 +0000
Subject: solved ticket 1344
Message-Id: <3F1C12F2.3080402@informatik.uni-erlangen.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

finally I found the answer to my question at
http://www2.lm-sensors.nu/~lm78/readticket.cgi?ticket44 .
I switched module compilation of, since I already compiled them with the
kernel. Your Makefile is not creating sensors.h, since it is not included in
the SRCDIRS variable.

After switching on kernel module compilation, the header file is 
created. This
solution is not really nice, since it would overwrite the already created
modules.

kind regards,

Rainer
