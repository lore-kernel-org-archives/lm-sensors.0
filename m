From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 25 Sep 2006 16:08:32 +0000
Subject: [lm-sensors] w83627hf and w83781d fancontrol support
Message-Id: <20060925180832.731e2697.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4517F3B2.3000504@gmail.com>
In-Reply-To: <4517F3B2.3000504@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I see you going well with the development of winbond chips. I tried to 
> make the fancontrol work with this 2 chip since a month without success. 
> Can you tell me now it's changed or not?

No, there were no change in this area recently. The W83781D chip does
not support fan speed control, so I wonder what you have been actually
trying with this one. All it can do is fan on/off, but our (w83781d)
driver doesn't actually implement this, and I am not aware of any
motherboard needing it. These fan switches are the same pins used for
fan monitoring, so using them means that you monitor fewer or no fans -
not really interesting.

The W83627HF chip does support fan speed control (2 PWM channels), and
our (w83627hf) driver does support that. It works OK as far as I know.
It does not (yet) support clock frequency selection though, while the
chip can do it.

Put in short, if you can't control the fans on a specific motherboard,
it's more likely because that motherboard was not properly wired for
fan speed control in the first place, and in that case there's nothing
we can do. If you have a proof that the board is properly wired an our
drivers still won't let you control the fans, please provide all the
information you have so that we can investigate.

> I using the newer kernel and sensors version 2.9.2 with libsensors 
> version 2.9.2 (ubuntu packages).
> BTW there are some problems with your SVN.

If you don't tell us what problems you have with SVN, the probability
that we help you is 0.

-- 
Jean Delvare

