From: Laszlo Papp <lpapp@kde.org>
Date: Mon, 16 Dec 2013 15:56:33 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (max6650) Add support for gpiodef
Message-Id: <CAOMwXhPDgw4Cex-_ORh26VVN93L_kxApoNzGe4M+r2Vm6HGB=A@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20131119180007.GB16693@roeck-us.net>
	<CAOMwXhOTRVu1EMSNE_muKKfSYBFQ1XVq1EQEL2d+wCwRJ0tkpw@mail.gmail.com>
	<CAOMwXhN8tZej9=65wyGvsnm64igiLLN6vdsiGaePCozKBs8J7Q@mail.gmail.com>
	<20131121173458.GC10783@roeck-us.net>
	<CAOMwXhNzpsiiK5NzxoXM56ACGmHo1gpm3OT6=kw29XQDFmyPAA@mail.gmail.com>
	<CAOMwXhPUR02fQ1EhV6K9eQW02kNHn55dTEND+R59g1=zC5qDWQ@mail.gmail.com>
	<528F6BB8.8040504@roeck-us.net>
	<CAOMwXhNx0v52BvxSWPrHFsGTvxss7N4tZT3gHMFJ8hz_HmvS5w@mail.gmail.com>
	<20131122160457.GA3951@roeck-us.net>
	<CAOMwXhO525BAJ+ESLaJ-62vkL7mAxLMULuaphE6YVda02beqfg@mail.gmail.com>
	<20131122180501.GA8547@roeck-us.net>
	<CAOMwXhO_D3cR5QfXp3wZGrO+i85X5H=Q0HAr2VCB6=96nLx4yQ@mail.gmail.com>
In-Reply-To: <CAOMwXhO_D3cR5QfXp3wZGrO+i85X5H=Q0HAr2VCB6=96nLx4yQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: Marcus Folkesson <marcus.folkesson@gmail.com>, hjk@hansjkoch.de, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

So, Mr. Roeck, how do you suggest to handle input or output port
configuration? Should it be coming from platform data, or should it be
more dynamic? I would say, it is usually static, but I do not know if
it is common to be dynamic. I am not a hardware designer.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
