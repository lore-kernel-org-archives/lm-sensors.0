From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Thu, 19 May 2005 06:24:57 +0000
Subject: sensors.conf: explain how to enable/disable beeps
Message-Id: <40A2C557.3080900@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040509222513.GA20557@pc.aurel32.lan>
In-Reply-To: <20040509222513.GA20557@pc.aurel32.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Greg KH wrote:

>On Wed, May 12, 2004 at 02:12:45PM -0700, Philip Pokorny wrote:
>  
>
>>bash can handle bit operations just fine.
>>
>>bash$ echo $(( 7 & 2 ))
>>2
>>bash$ echo $(( 8 & 2 ))
>>0
>>    
>>
>
>Heh, you can tell I am not a good bash programmer :)
>
>  
>
>>So that shouldn't be a concern.
>>    
>>
>
>Ok, nevermind.
>
>  
>
>>I'd like to make another suggestion.  Put meaningful text strings as the 
>>contents of the _status file:
>>
>>  LOW  (for low alarm)
>>  HIGH  (for high alarm)
>>  FAIL  (for diode failure)
>>  ALARM  (for generic alarm)
>>  HIGH, FAIL  (for multiple alarms)
>>  ""  (null string for no alarm)
>>
>>Then the sensors library and other tools/languages can just "cat" the 
>>contents to get the status and test for non-null string to see if there 
>>is an active alarm or not.
>>    
>>
>
>Ah, I like this even better.  We would never need to display more than
>one status at a time per device, right?
>  
>
I suppose it depends on what you mean.  As I said, there is a case like:

  "ALARM, FAIL"  (for multiple alarms)



Which could be construed as "more than one status" but they are all 
alarms for the same parameter so I see this as a single value.

One other thing to consider is if individual alarms can be masked 
(similar to the way interrupts can be masked) then we might want yet 
another parameter to mask a given alarm.  If "ALARM" is individually 
maskable from "FAIL", then they would need to be split into multiple 
foo_status parameters with matching foo_status_mask values.

For example, the EMC6D100 which is supported by the LM85 driver has 
seperate status bits for diode faults and over limit conditions.  Each 
status is individually maskable, but only the over/under limit status 
can generate an interrupt.  And  you can't tell an over-limit from an 
under-limit condition unless you check the current input, and limits.

   temp0_input
   temp0_alarm_status
   temp0_alarm_status_mask
   temp0_fail_status
   temp0_fail_status_mask
   temp0_min
   temp0_max

But having to read multiple files to get the complete alarm status for a 
given input would be annoying.  Especially if it means having to read 
all of (_min_status, _max_status, _crit_status, _fail_status, etc...)

:v)


-- 
Philip Pokorny, Director of Engineering
Tel: 415-954-2823   Fax: 415-954-2899   Toll Free: 888-PENGUIN
PENGUIN COMPUTING, INC.
www.penguincomputing.com

