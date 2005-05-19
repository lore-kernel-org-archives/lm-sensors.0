From: cedric.pradalier@inrialpes.fr (Cedric Pradalier)
Date: Thu, 19 May 2005 06:24:49 +0000
Subject: Adm1030 driver
Message-Id: <20040327195343.048a3abf.cedric.pradalier@inrialpes.fr>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040319224106.79f6cec3.cedric.pradalier@inrialpes.fr>
In-Reply-To: <20040319224106.79f6cec3.cedric.pradalier@inrialpes.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 27 Mar 2004 09:54:43 -0500, 
Mark Studebaker gracefully wrote:
>Note that there are three already-in-kernel drivers/macintosh/therm_*.c
>which suffer from many of the same problems below.
>
>interesting...

I knew that. I've made the remark to one of the macintosh guru. 

From a software engineering point of view, it seems strange to have a
set of device not so different but developped without collaboration.


>
>Mark Studebaker wrote:
>> agreed. This doesn't conform to either our 2.4 or 2.6 driver template
>in > several ways:
>>     - no chip detection
>>     - no bus functionality checking
>>     - no conformance to sysfs guidelines
>>     - uses i2c_master_send rather than i2c_smbus_xxx
>>     - thermal control loop in kernel space

Just as a remark, my driver is not managing thermal control loop, just
exporting the relevant chip registers to control the chip automatic
thermal control behavior.

>>     - Apple-specific and keywest-specific code
>> 
>> mds
>> 

So the work to adapt to the lm-sensor seems quite important. I'm afraid
I won't have time to do it right now. Please feel free to use my modest
development as a basis for a true lm-sensor driver.

Nevertheless, I feel I know quite well the adm1030/1 now. 
So, please don't hesitate to contact me for testing or information.

-- 
Cedric

"[Of course] I'm French! Why do think I have this outrageous 
accent, you silly king-a?!"  Monty Python and the Holy Grail
