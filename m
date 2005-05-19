From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Thu, 19 May 2005 06:24:41 +0000
Subject: sysfs names
Message-Id: <402911BA.2040507@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040126230447.09700886.khali@linux-fr.org>
In-Reply-To: <20040126230447.09700886.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> I propose to divide the changes in three distinct steps:
> 
> 1* Change the base scheme (temp_min1 -> temp1_min). This is the more
> important change.
> 
> 2* Change the hysteresis names (temp1_hyst -> temp1_max_hyst). Only some
> drivers are impacted. Changes required to the library as well.
> 
> 3* Add the splitted alarm files. This doesn't break the interface, but
> on the other hand needs that we think about it a bit more so that out
> choices are extendable and correct for all known drivers.

Some temperature sensors have two types of alarms.  An over-limit 
(max_alarm) alarm and a sensors failed alarm.

We could do this a couple of different ways:

1. Name the alarm file for a sensor: temp1_alarm and have it take one of 
several values:  "" (null string), "ALARM", "FAIL"

2. Come up with another name for the other alarm: temp1_input_failed? 
temp1_fail_alarm?

3. Some other idea I haven't thought of?

FYI,
:v)

-- 
Philip Pokorny, Director of Engineering
Tel: 415-358-2635   Fax: 415-358-2646   Toll Free: 888-PENGUIN
PENGUIN COMPUTING, INC.
www.penguincomputing.com
