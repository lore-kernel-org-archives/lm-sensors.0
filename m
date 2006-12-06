From: flabbergasted@gmx.de (flabbergasted at gmx.de)
Date: Wed, 06 Dec 2006 16:42:28 +0000
Subject: [lm-sensors] fancontrol with IT8705F
Message-Id: <4576F2F4.9050200@gmx.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I installed lm-sensors on Ubuntu Edgy today. I have an Asus A7V8X-X mobo 
wich has an IT8712F/IT8705F chip (that's what speedfan tells me in Windows).

I was able to set up lm-sensors to get the correct values for the CPU 
fan and the temperatures. However I have problems getting fancontrol to 
run.

pwm2 controls the CPU fan but only for values between 0-10. So for the 
value 10 it already runs at 100%. I can regulate it by setting it 
manually between 0-10 but this is problematic with fancontrol which 
expects to regulate between 0-255. I think I remember that the autor of 
speedfan also had problems with this and then fixed it somehow. So if 
this is of any help I could contact him and ask him to provide information.

I searched for this problem on the mailing list but there I only found 
old and not very helpful entries. Can you tell me what I could do about 
this? I'd really like to get this to work since it is one of the main 
reasons I still don't use Linux at home on a regular basis.

Btw... I am quite good with understanding things but I'm still 
relatively new to Linux so if you try to give me some information don't 
expect too much background knowledge on my side. I'm eager to learn, 
though. :)

I really hope you can help. Thanks so much in advance!

Tobias Fritz

