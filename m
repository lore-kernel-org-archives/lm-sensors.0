From: "Dmitry Bely" <dmitry.bely@gmail.com>
Date: Sun, 27 May 2007 18:55:00 +0000
Subject: [lm-sensors] ICH8 HECI temperature sensors
Message-Id: <90823c940705271155y3199cc48m1f753928f0c501af@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <46404132.9020204@assembler.cz>
In-Reply-To: <46404132.9020204@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I have found in archives the following Rudolf Marek's message:

> Some users asked us about the support for HECI integrated temperature sensors. I
> tried to find some relevant documentation, but I could not find anything I could
> send to HECI to obtain the temperatures, fans etc.
>
> Please can someone point us to the correct docs? I think aim would be to develop
>   kernel hwmon driver, which will read the data through HECI interface.
>
> I can tell more info if you need.

My question is: why to develop a kernel driver if one is already there:

http://www.openamt.org

Can it be integrated with lm-sensors?

- Dmitry Bely

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
