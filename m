From: sukhdeep@gmail.com (Sukhdeep Johar)
Date: Mon, 13 Jun 2005 11:17:45 +0000
Subject: [lm-sensors] w83781d.o: Subclient 0 registration at address 0x49
Message-Id: <2ef564dc05061302175b8427fd@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi, 

I am using the chip W83697F chip. 

I am getting this error when loading the w83781d driver.
w83781d.o: Subclient 0 registration at address 0x49 failed

I have tried  modprobe w83781d init=0 force_subclients=0,0x2c,0x4a,0x4b 
without any succes.. 

I am not getting the temp2 and temp3 values correctly, and suspect that the
above error may be the culprit.

Can you please provide some insights.. I have run out of options :( 

regards,
Sukhdeep

