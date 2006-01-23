From: Ymu@Winbond.com.tw (Ymu@Winbond.com.tw)
Date: Mon, 23 Jan 2006 02:14:42 +0000
Subject: [lm-sensors] w83627ehf fan controll?
Message-Id: <FF9D611BFCDB1E42B37FAA148096BECED826A9@weshml03.winbond.com.tw>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051230143805.GA21201@Apollo>
In-Reply-To: <20051230143805.GA21201@Apollo>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf, Aurelien,
> Sorry for late response. I did some quick review of this code. Maybe
Yuan can find it useful.
> 
> 1) max and min regs are switched
> 2) code does not use sensor_dev_attr and uses old macro system
Yes, that's true.
> 3) it contains some tweaks to force PWM (seems from Aurelian attempts
to get his PWM working :)
> 
I use a voltmeter to measure the output of PWM pins of the chip, I don't
expect they can wire all the pwm pins....
Maybe Aurelien can use the same way?


> I have a question now:
> 
> 1) does anyone else has something to show?
> 2) does anyone has userspace voltage support?
> 
Hmm, As what you see,  I have do some modify in my local CVS, and the
code is send to Sebastian with a user tool to give convenience in
testing, but still no reply yet.
> I cant work much on this next moth (feb) busy with final exams. Well
maybe I will - as brain relax subroutine :)
> 
> Yuan have you this on your own schedule?
I will take a holiday from 1/26/2006 to 2/5/2005, and I'm doing
something else now, maybe I can send my patch out before I leave,then
Aurelien and someone else can test and modify it?


Best Regards
Yuan Mu
 



=============================================The privileged confidential information contained in this email is intended for use only by the addressees as indicated by the original sender of this email. If you are not the addressee indicated in this email or are not responsible for delivery of the email to such  a person, please kindly reply to the sender indicating this fact and delete all copies of it from your computer and network server immediately. Your cooperation is highly appreciated. It is advised that any unauthorized use of confidential information of Winbond is strictly prohibited; and any information in this email irrelevant to the official business of Winbond shall be deemed as neither given nor endorsed by Winbond.

