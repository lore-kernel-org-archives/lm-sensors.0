From: Frank Myhr <fmyhr@fhmtech.com>
Date: Thu, 02 Oct 2008 18:48:41 +0000
Subject: Re: [lm-sensors] Looking for IT8720 datasheet.
Message-Id: <48E51789.8060107@fhmtech.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <79c9d4530810020825r79de9817g6933f6cab1d414c1@mail.gmail.com>
In-Reply-To: <79c9d4530810020825r79de9817g6933f6cab1d414c1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean-Marc,

That's great that you've modified it87.c to handle your IT8720. Why
don't you go ahead and post your patch to the list, I'll be happy to
have a look at it. My first priority is adding automatic mode support
for the 8718. I'm adding auto mode support for the 8720 and other chips
at the same time. But I'm still not ready to post that work yet. Anyway,
as far as on/off and software pwm modes go, the 8720 is almost exactly
the same as the 8718*, so you can do a simple search through the code
for conditionals on the 8718 and add the 8720 to them. (Sounds like
you've already done that.)

I have nothing to add to Jean's excellent answer regarding the voltage
inputs on it87. And I don't know what's going on with in0 on your board
either.

-Frank

* The one slight difference I'm aware of is that the 8720 uses ec
register 0x0b bits to control pwm4 and pwm5 in software pwm mode (since
it has 5 fans but only 3 pwm channels):

bits	RW  def notes
3-2	RW  11b	pwm5 same as:
		00b	pwm1
		01b	pwm2
		10b	pwm3
		11b	none
1-0	RW  11b	pwm4 same as pwm[1|2|3], codes as above

The 8718 also has 5 fans and only 3 pwm channels, but does not allow
choosing pwm4 and pwm5 control as above.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
