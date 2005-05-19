From: synaptical@linuxquestions.net (synaptical)
Date: Thu, 19 May 2005 06:24:33 +0000
Subject: no sensors found! with 2.6.0 kernel
Message-Id: <20040109220819.F0E2E3945@sitemail.everyone.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

hello - thank you for the great lm_sensors program. i've been using it with great success until kernel 2.6.0, but now i am having a problem i can't figure out. i don't know whether to file a bug report or what the problem might be, so i figured i would ask here first. 

Driver `w83781d' (may not be inserted):
  Misdetects:
  * ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `Winbond W83627HF' (confidence: 8)

Driver `w83627hf' (should be inserted):
  Detects correctly:
  * ISA bus address 0x0290 (Busdriver `i2c-isa')
    Chip `Winbond W83627HF Super IO Sensors' (confidence: 9)

i think that misdetected Driver (w83781d) must be the problem. it was detected in prior kernels, but now it can't be loaded for some reason. i have an epox nforce2 motherboard, btw. lsmod says:

i2c_sensor              3392  0 
i2c_dev                10944  2 
i2c_nforce2             5952  1 
i2c_core               25992  3 i2c_sensor,i2c_dev,i2c_nforce2

i'm relatively new to linux, and i'm not really sure what other information to provide. is there any advice you can give me on getting my sensors to work? thank you. 

###

_____________________________________________________________
Thank you for choosing LinuxQuestions.
http://www.linuxquestions.org
