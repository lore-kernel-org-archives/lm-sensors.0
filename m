From: Daniel Lucio <dlucio@utk.edu>
Date: Fri, 02 May 2008 19:05:01 +0000
Subject: [lm-sensors] How to adjust sensors.conf for a Super Micro X7DA8
Message-Id: <24825AE3-0B15-4A0D-8AD5-36EE7815F8F4@utk.edu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I ran a tool called Super Doctor II on a Super Micro X7DA8  
motherboard, and i noticed that some of values where different for  
the following measurements returned by lm-sensors:

w83793-i2c-0-2e
Adapter: SMBus I801 adapter at 1100
-12V:       -11.38 V	- compute in3 (((@/8)*18500)/256)-16, (((@+16) 
*256)/18500)*8
+5V:         +5.12 V	-No scaling
5VSB:        +5.12 V	-No scaling

SuperDoctorII returned for the same measurements:
-12V:  -12.21
+5V:     4.97
+5Vsb:   4.97

My question is, how should I scale the values read by lm-sensors to  
return the correct value?

Also, I noticed that SuperDoctorII displayed other information like:

Chassis Intrusion                                      Bad  Warning!
Power Supply Failure                                  Good

How can I find out which sensor read by lm-sensors maps to these two  
readings?

Thank you!

Daniel.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
