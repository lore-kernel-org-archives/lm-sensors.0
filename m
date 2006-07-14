From: j.w.r.degoede@hhs.nl (Hans de Goede)
Date: Fri, 14 Jul 2006 19:43:23 +0000
Subject: [lm-sensors] new abituguru driver in mm kernel
Message-Id: <44B7F3DB.8040704@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <ce9ef0d90607041146t6837a584x68d1ab7e528139ea@mail.gmail.com>
In-Reply-To: <ce9ef0d90607041146t6837a584x68d1ab7e528139ea@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Sunil Kumar wrote:
> you mean the hardware itself is not in the right state? Or its in the right
> state but not in the state that you expect to be the right state? I am
> confused I guess because suspending to disk should be like a shutdown to
> the
> hardware. suspend to RAM might be a different beast because of BIOS
> involvement.
> 

The problem is that my driver currently does not take the option of
suspendin (in anyway) into account. When the driver loads it puts the
hardware in the "ready" state and whenever it does something with the
hardware (making it not ready) it puts it back in the ready state when
its done. So the driver expects the hardware to be in the ready state
when it next tries to read from the hardware. However due to the
suspend/resume cycly the hardware is most likely no longer in the ready
state. My driver should be able to recover from this but complains that
things did not go as expected. Hence my question:

>> After suspend/resume does it happen just once/twice, or does it happen
>> regulary after suspend / resume.

Because if it only happens once or twice after a single suspend/restore
then my theory is most likely correct and then I'll try to fix my
driver. If it happens many times after a single suspend/resume it might
very well be something else.

Regards,

Hans

