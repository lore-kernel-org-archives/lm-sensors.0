From: gnom108@yahoo.com (Gnom Gnom)
Date: Wed, 28 Feb 2007 19:56:34 +0000
Subject: [lm-sensors] Using lmsensors with Winbond w83627ehf
Message-Id: <279611.78053.qm@web53210.mail.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

(if there is better list for "NEWBIEs", please let me know where - thanx)
   
  I am running Centos 4.4 on system using ASUS P5LD2-VM motherboard.  I have upgrade kernel to 2.6.20:
   
  Linux  2.6.20 #1 SMP Fri Feb 16 11:26:35 EST 2007 x86_64 x86_64 x86_64 GNU/Linux
   
  and use lm_sensors-2.10.2. Here is output from sensors command:
  
w83627ehf-isa-0290
Adapter: ISA adapter
in0:       +1.27 V  (min =  +0.00 V, max =  +1.74 V) 
in1:       +1.79 V  (min =  +1.88 V, max =  +1.02 V) ALARM
in2:       +3.25 V  (min =  +0.21 V, max =  +3.82 V) 
in3:       +3.44 V  (min =  +4.03 V, max =  +0.75 V) ALARM
in4:       +2.04 V  (min =  +1.76 V, max =  +1.61 V) ALARM
in5:       +1.62 V  (min =  +1.55 V, max =  +0.96 V) ALARM
in6:       +1.60 V  (min =  +0.68 V, max =  +1.52 V) ALARM
in7:       +3.41 V  (min =  +1.60 V, max =  +2.99 V) ALARM
in8:       +3.97 V  (min =  +3.74 V, max =  +0.99 V) ALARM
in9:       +1.58 V  (min =  +1.50 V, max =  +1.68 V) 
fan1:        0 RPM  (min =  178 RPM, div = 128) ALARM
fan2:     4354 RPM  (min = 3260 RPM, div = 2)
fan3:        0 RPM  (min =   55 RPM, div = 128) ALARM
fan4:        0 RPM  (min = 10546 RPM, div = 128) ALARM
fan5:        0 RPM  (min = 168750 RPM, div = 8) ALARM
temp1:       +40??C  (high =   +27??C, hyst =  -111??C)   ALARM
temp2:     +44.0??C  (high = +80.0??C, hyst = +75.0??C)  
temp3:     +50.5??C  (high = +80.0??C, hyst = +75.0??C)  
   
  I have trouble finding  information what tells how temp1, temp2, and temp3 correspond to CPU temp/motherboard temp value from BIOS. Also for fan1, fan2, etc. 

  Please advise, thank you.
   
  gnom
   

 
---------------------------------
Be a PS3 game guru.
Get your game face on with the latest PS3 news and previews at Yahoo! Games.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20070228/5e9e05f4/attachment.html 
