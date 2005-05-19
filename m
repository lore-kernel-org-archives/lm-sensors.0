From: cgfreita@netsite.com.br (cgfreita)
Date: Thu, 19 May 2005 06:25:06 +0000
Subject: smsc47m1 ported to Linux 2.6
Message-Id: <20040724201239.7bfcb78a.cgfreita@netsite.com.br>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040720225853.6f67122b.khali@linux-fr.org>
In-Reply-To: <20040720225853.6f67122b.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

> After both of you reported that fan1 was working OK but fan2 wasn't,
> I had to admit that there could be a problem in the driver. It is
> theoretically possible that the board maker decides to enable fan1
> and disable fan2 (which is why I didn't react after the first
> report) but two reports by two different testers were too much ;)
> 
> There was actually a bug in the driver, I wasn't watching the
> correct registers when deciding whether to ebable fans or not. Same
> for PWM outputs.

	1) I was reading my mainboard manual and I found that there is a
third fan connector (1 processor fan and 2 chassis fans). I have just
two: 1 processor and 1 chassis). I confirmed at the mainboard and the
third connector is really there. I can't test it for now.
	2)Sorry, I didn't understand about PWM outputs. Sorry. :-|
 
> This is now fixed in patch tagged beta1:
> http://khali.linux-fr.org/devel/i2c/linux-2.6/linux-2.6.8-rc2-i2c-smsc47m1-beta1.diff
> 
> Please test and confirm that both of you now have fan 1 and 2
> working, and two pwm file sets as well (whether they have an actual
> effect on fans is yet another matter).
> 
> (You can revert the first patch using "patch -R" before applying
> this one, so that you won't waste your time getting a fresh new
> tree.)

	I did patch -p1 -R.
	I applied the new one. Applied and compiled fine.
	Please, take a look at probs2.txt attached.
 
> Thanks a lot for testing my code.

	Thanks a lot for coding it. :-)

> Among things that can be done to test the driver more actively:
> 
> 1* Change fan limits in /etc/sensors.conf, run "sensors -s" and
> check that the limits have been set properly. Ditto for divisors.

	As you can see at probs2.txt, I tried some values and there are
diffs between them. (sensors.conf and sensors output)
 
> 2* Change the fan limits through sysfs directly. Testing of corner
> cases is welcome (large values, negative values, zero). Ditto for
> divisors.

	I tried to put values in fan1_min.
	It didn't accepted values less than 1299 and treated it as 1300.
	I tried negative values and it didn't accept it.
	(if you "cat fan1_min" or use sensors command, the output is the
same: 1300)
	(see probs2.txt also)

> 3* Play with PWM (enable/disable, change speed). Be careful not to
> stop your fans completely, systems usually don't like that much.

	As I said, I am not using PWM (power management?), so I don't know
how to try this. Sorry.
	Oh, I am using gkrellm and I can get fans there too. (both) :-)

	If you need more information, please just tell me.

> Thanks again.

	Thanks again, too. :-)

Cheers,

Freitas
-------------- next part --------------
A non-text attachment was scrubbed...
Name: probs2.txt
Type: application/octet-stream
Size: 3461 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040724/eb616bc5/probs2.obj
