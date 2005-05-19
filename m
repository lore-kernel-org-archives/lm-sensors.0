From: jeff@jdfiles.org (Jeff Sacksteder)
Date: Thu, 19 May 2005 06:24:22 +0000
Subject: i2c for Alpha
Message-Id: <200310261650.12581.jeff@jdfiles.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200310121707.56799.jeff@jdfiles.org>
In-Reply-To: <200310121707.56799.jeff@jdfiles.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Two things I'd try:
> 1* Get sensors-detect from CVS and give it a try. It knows much more
> than the one in 2.6.5. Of course it will make reference to drivers that
> you don't have, but just don't care. Feel free to send us the complete
> output of sensors-detect, it might help us helping you.

Still nothing detected. I am currently trying to work this out from the other 
end- finding documentation of what chips are on the mainboard. 

> 2* If the above doesn't give any result, please run "i2cdetect 0" and
> send us the output of that command.

Strike 2. 

www root # i2cdetect 0
  WARNING! This program can confuse your I2C bus, cause data loss and worse!
  I will probe file /dev/i2c-0
  You have five seconds to reconsider and press CTRL-C!

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
50: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX


