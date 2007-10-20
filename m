From: Krzysztof Helt <krzysztof.h1@wp.pl>
Date: Sat, 20 Oct 2007 19:35:09 +0000
Subject: [lm-sensors] sensors3 and pwm properties
Message-Id: <20071020213509.cc414874.krzysztof.h1@wp.pl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I ask here because I was asked few times.

The sensors3 command does not display pwmX values. It is confusing
for drivers which have pwmX properties for controlling fans but
have not fanX properties (no fan feedback). The thmc50 driver is one example.

The output from sensor3 command looks like there is no fan attached.

Is it design decision, omission or feature not implemented yet?

Regards,
Krzysztof

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
