From: Bruce Samhaber <bsamhaber@sympatico.ca>
Date: Thu, 23 Jul 2009 09:54:51 +0000
Subject: [lm-sensors] lm-sensors on IBM T42
Message-Id: <BLU0-SMTP81C7E5C9A311754F6D4AB2D0180@phx.gbl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi, 

I have an IBM T42 and tried to install 'lm-sensors' 
But the detection routine did not find any 'I2C' devices.

My machine is shutting down automatically when I run it at full clock rate. 
The powersave deamon is detecting over temperature (I assume CPU.) So there 
is a method of detecting some temperatures. 

Since, I installed the lm-sensors prior to knowing about the posting, that 
states not to do this:
http://www.lm-sensors.org/browser/lm-sensors/trunk/README.thinkpad?rev30
I did not notice any different behaviour with my machine. I have been able to 
reboot and login several times. I guess someone fixed this problem.

I do not seem to be able to search your website without logining in, but I 
also do not see where to register to login. 

Is there a solution to the 'i2c' driver for lm-sensors on the IBM T42? 

I would like to get lm-sensors working on this laptop.

Thank you,



-- 
Bruce Samhaber
Senior Hardware Design Consultant
Tel:  613-724-5987		112 Kenora St. 
Fax:  613-724-5987		Ottawa, Ontario
Cell: 613-297-6961		K1Y 3L1
mailto: bsamhaber@sympatico.ca	http://www3.sympatico.ca/marypat/

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
