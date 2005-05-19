From: ljubo108@vip.hr (Ljubomir Bozic Jr.)
Date: Thu, 19 May 2005 06:24:15 +0000
Subject: fan2 readout on Chaintech MB
Message-Id: <200309011105.55127.ljubo108@vip.hr>
List-Id: <lm-sensors.vger.kernel.org>
References: <200308310230.14115.ljubo108@vip.hr>
In-Reply-To: <200308310230.14115.ljubo108@vip.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> It's a FAQ. You need to increase fan2_div (typically from 2 to 4) in
> /etc/sensors.conf (it87-* section) and run "sensors -s" again, possibly
> twice. Then "sensors" should report the correct reading. If not, try
> increasing even more (8...).
>

It works now! Thanks! Please forgive me , I did not read FAQ carefully.


> Aha, you're using my driver. Great :) I had no feedback for it yet.
> Could you please provide a sample sensors output, so that I can see how
> it does look? Also, I'd be great if you could verify that limit
> checkings are OK (simply set the limits in a way you know the readings
> will be outside of them, and see is sensors reports alarms correctly.)
> Thanks! If you find anything that would need fixing/tweaking in my
> driver, please let me know and I'll take a look.

I would like to test it a little bit further but it seems that I have some 
problems with my motherboard. It does not refresh sensor. I have tried it 
both in windows and Linux but same thing happens. I dont think that both MBM 
in windows and lm_sensors have same problems so it is motrerboard issue.
I will try to fix it somehow and then I will do some lm90 testing and give you 
all the feedback I can.

Thank you very much for your help.

Best regards, Ljubo
