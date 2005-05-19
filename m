From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Thu, 19 May 2005 06:23:59 +0000
Subject: Random libsensors redesign toughts
Message-Id: <3EE7D766.5030801@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3EE25772.9010305@penguincomputing.com>
In-Reply-To: <3EE25772.9010305@penguincomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Greg KH wrote:
> On Sat, Jun 07, 2003 at 02:21:54PM -0700, Philip Pokorny wrote:
> 
>>As a follow up to my previous e-mail I thouht I would document some other 
>>thoughts I had recently about the interface between the new sysfs based 
>>drivers and libsensors and user-space applications.
>>
>>Not that any of these are particularly good ideas, I just wanted to get 
>>them out there...
>>
>>1. If the library is to be able to deal with any value in a consistent way, 
>>it needs to know if that value is in milli-degC, mVolts or whole counts.  
>>While saying that all temperatures would now *have* to be reported in 
>>milli-degC makes all temperatures consistent, there is still the problem 
>>that all values are not scaled identically (fan's are in whole RPM's).  If 
>>each reading came with a scaling factor (1 to 1000 or more) it would be 
>>possible to have a generic routine for converting a driver integer to a 
>>user-space floating point value.
>>
>>I see two possibilities...
>>
>>Include the scaling in the same file with the reading:
> 
> 
> Ick, no.
> 
> What's wrong with just using the same units always?

Because not every reading has the same scaling.  RPM's are unit scaled, 
voltages are milli-volt scaled, temperatures will now be milli-degC 
scaled.  But the VRM spec is 10 scaled (8.1, 9.1, 10.0 etc) and auto fan 
control will require time values for some parameters.  milli-seconds for 
all time parameters is not appropriate.  Other values may require 
different scaling as well.

You can't use the same scaling for every reading.

And for the library, it would be nice if the interface to sysfs didn't 
have to worry about what "type" a reading was and make some arbitrary, 
compiled in, decision about what the scaling for that value should be. 
It is *much* more flexible and appropriate for the driver to inform the 
library what the scaling for a given value is.

:v)


-- 
Philip Pokorny, Director of Engineering
Tel: 415-358-2635   Fax: 415-358-2646   Toll Free: 888-PENGUIN
PENGUIN COMPUTING, INC.
www.penguincomputing.com
