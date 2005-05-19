From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:35 +0000
Subject: [PATCH 2.6] restore correct vaio handling in eeprom driver
Message-Id: <20040116224058.680d0c23.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040111205346.6182c330.khali@linux-fr.org>
In-Reply-To: <20040111205346.6182c330.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

A few more facts so that you can take the Right Decision (TM):

1* "sensors" time with 1 SPD EEPROM + 1 VAIO EEPROM:
2.4.24 (w/ optimization): 0m1.560s
2.6.1 (w/o optimization): 0m1.039s
2.6.1 (w/ optimization): 0m0.229s

One interesting thing here is that the 2.6 drivers set is already faster
that the 2.4 one, even without the optimization. This is a great mystery
to me, if someone can explain me why... Is the 2.6 i2c subsystem
supposed to be that faster than in 2.4? I expected that the bottleneck
would be the relatively low smbus speed, so that nothing could make
things go faster. I was obviously wrong. This is with i2c-i801 as the
bus driver, if that matters.

Second thing is: yes, the optimization makes sensors damn faster (ratio
4.5).

So on the one hand it seems that optimizing isn't very important
(because it's already fast), and on the other hand the speed improvement
is real, so I'd say it's worth it. I don't find the optimization ugly,
but that's my code so I cannot be objective I guess ;)

2* As of now, libsensors cannot take benefit of the optimization because
it uses fopen+getc to read the eeprom file (buffered so the whole file
is read, whichever byte you try to read). I had to convert it to
open+lseek so that the optimization takes effect. I will of course
commit the change if and only if you accept my driver optimization.

The only other programs I know of that will access the eeprom file are
our (four) Perl eeprom decoding scripts. They are not converted to the
sysfs interface yet, but as they will be, they will take benefit of the
optimization.

Hope that helps,

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
