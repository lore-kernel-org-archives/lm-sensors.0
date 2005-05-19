From: joden@lee.k12.nc.us (James Olin Oden)
Date: Thu, 19 May 2005 06:25:02 +0000
Subject: Return code of i2c transaction ignored in lm87
Message-Id: <Pine.LNX.4.58.0406250822110.16214@malachi.lee.k12.nc.us>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi All,

I was reading through the lm87 code and noted (unless I am missing
something...highly possible) that an error return code from the I2C layer 
seems to be ignored.  First off, am I reading this right, and secondly
is this on purpose (i.e. is there some reason that this is the right thing 
to do that I am not getting)?

Thanks...james
