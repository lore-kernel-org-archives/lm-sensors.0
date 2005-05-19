From: pontus.edvardsson@bredband.net (Pontus Edvardsson)
Date: Thu, 19 May 2005 06:23:36 +0000
Subject: Regarding ticket #955
Message-Id: <20020728090837.QAYT12689.mf2@there>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I've been trying to figure out what makes the difference between your and 
mine configuration, since you were able to compile the p4b_smbus.o

I tried to compile on a 2.4.18 Debian system which failed, I also tried 
compiling on a 2.4.18 Mandrake system, which failed as well.

Could you maybe send me your .config file for me to examine if you think it 
could have anything to do with my problem. If I could compile with yours 
unmodified .config it would be easier to isolate the problem, right? I have a 
PCI Promise TX2-133 IDE controller, for which I must at the moment patch my 
kernel to 2.4.19-rc3 to get working.

Thanks, Pontus
