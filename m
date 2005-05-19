From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Thu, 19 May 2005 06:24:57 +0000
Subject: sensors.conf: explain how to enable/disable beeps
Message-Id: <40A2934D.7040203@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040509222513.GA20557@pc.aurel32.lan>
In-Reply-To: <20040509222513.GA20557@pc.aurel32.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Greg KH wrote:

>On Wed, May 12, 2004 at 02:46:44PM +0200, Jean Delvare wrote:
>  
>
>>Method #1: Pros: Fewer files, scripts can easily know if there is any
>>alarm set for a channel (non-zero value). Cons: The user-space needs to
>>know the meaning of the bits. The bits have to be wisely chosen once and
>>for all, covering all possibilities (at lest of all chips we know of as
>>of today).
>>
>>Method #2: Pros: No preliminary knowledge necessary, the interface is
>>self explaining. Can be easily implemented and extended. Cons: almost
>>doubles the number of files in the sysfs interface.
>>
>>I have no string preference (yet). Insight welcome.
>>    
>>
>
>I prefer method 2.  It also allows languages that can't handle bit
>operations easily to access the values (like bash...)
>  
>
bash can handle bit operations just fine.

bash$ echo $(( 7 & 2 ))
2
bash$ echo $(( 8 & 2 ))
0

So that shouldn't be a concern.

I'd like to make another suggestion.  Put meaningful text strings as the 
contents of the _status file:

   LOW  (for low alarm)
   HIGH  (for high alarm)
   FAIL  (for diode failure)
   ALARM  (for generic alarm)
   HIGH, FAIL  (for multiple alarms)
   ""  (null string for no alarm)

Then the sensors library and other tools/languages can just "cat" the 
contents to get the status and test for non-null string to see if there 
is an active alarm or not.

:v)

-- 
Philip Pokorny, Director of Engineering
Tel: 415-954-2823   Fax: 415-954-2899   Toll Free: 888-PENGUIN
PENGUIN COMPUTING, INC.
www.penguincomputing.com

