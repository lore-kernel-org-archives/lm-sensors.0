From: Mario.Holbe@RZ.TU-Ilmenau.DE (Mario 'BitKoenig' Holbe)
Date: Thu, 19 May 2005 06:24:54 +0000
Subject: sensord: rrd database and timeslots
Message-Id: <20040423113240.GC4039@darkside.22.kls.lan>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040421222823.GA14256@pc.aurel32.private>
In-Reply-To: <20040421222823.GA14256@pc.aurel32.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Apr 23, 2004 at 01:20:37PM +0200, Aurelien Jarno wrote:
> is better that have to be sampled as near as possible from the time
> slots to get correct values. However, IMHO the values would be more
> "true" if the sensors are sampled a little to late but corrected than if
> they are sample to late and not corrected.

Well, this depends a lot on the values you get from the sensors
and on the interpretation of them.
For example, I have a machine whose fan is reported with 0 RPM
from time to time, while it normally operates around 4200 RPM.
With interpolation I get something like 70 RPM stored in the
rrd instead of the - real - 0, which shows a very different
view in the rrd than in reality.
The question is more or less: does the spotlight that sensord
points at one moment say something about the values of the
sensors in the past?


Mario
-- 
Independence Day: Fortunately, the alien computer operating system works just
fine with the laptop. This proves an important point which Apple enthusiasts
have known for years. While the evil empire of Microsoft may dominate the
computers of Earth people, more advanced life forms clearly prefer Mac's.
