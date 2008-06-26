From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 26 Jun 2008 20:54:29 +0000
Subject: Re: [lm-sensors] Are single- or multi- function functions preferred?
Message-Id: <20080626225429.31063c8f@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <486285AD.4040902@fhmtech.com>
In-Reply-To: <486285AD.4040902@fhmtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Frank,

On Wed, 25 Jun 2008 13:51:41 -0400, Frank Myhr wrote:
> I'm in the process of cleaning up a patch that adds auto pwm mode
> to it87. In the existing it87 driver each sysfs attribute maps to
> exactly one (if read-only) or 2 (if read/write) functions. Whereas
> in the vt1211 driver (for instance) multiple sysfs attributes map
> to a single pair of "show_*" and "set_*" "multi-functions" that
> switch on sensor_attr_2->nr to determine what to do. Is one of
> these styles preferred over the other, and why?

Unless you are looking at a very old version of the it87 driver (I hope
not), it does reuse sysfs callbacks for multiple files. The difference
between both drivers is that the it87 driver reuses callbacks for
similar files only differing by their index number (e.g. temp1_input,
temp2 input and temp3_input) while the vt1211 driver goes one step
further and reuses the same functions for more file types (e.g.
temp1_input and temp1_max).

Whether you do one or the other is essentially a matter of personal
choice. In general, there's no big difference between both approaches,
neither in terms of binary size nor in terms of execution speed. So
it's really up to the driver author, based on what he/she wants the
source code to look like.

One thing that matters though is to be consistent withing a given
driver. Mixing both approaches in the same driver could get confusing.
Therefore I would recommend that you stick to what the it87 driver does
at the moment, unless there really is a big organizational or size win
in doing otherwise (which, as I recall, might as well be the case for
auto pwm mode, those register map is 2-D by nature.)

Hope that helps,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
