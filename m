From: Luca Tettamanti <kronos.it@gmail.com>
Date: Thu, 06 May 2010 07:50:33 +0000
Subject: Re: [lm-sensors] fancontrol doesn't work with new Ubuntu 10.06
Message-Id: <q2w68676e01005060050y35d34378u369bbda8d7fc1962@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

On Sat, May 1, 2010 at 12:56 AM, Jerry Fiddler <jfiddler@yahoo.com> wrote:
> I had sensors and fancontrol working fine with ubuntu 9.04.  Both broke
> during my brief sojourn with 9.10.  I've just installed 10.06 and sensors
> seem fine, but fancontrol doesn't work.  Can anybody provide any guidance
> about what I should try to fix this?
> Sensors output is:
>
> atk0110-acpi-0
[...]

asus_atk0110 does not provide direct fan control. It does respected
the Q-Fan mode set by the BIOS.

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
