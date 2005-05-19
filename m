From: DarKRaveR@verfeiert.org (DarKRaveR@verfeiert.org)
Date: Thu, 19 May 2005 06:24:41 +0000
Subject: Follow-UP to ticket 1578 as requested
Message-Id: <348334234.20040216183102@verfeiert.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1076891110.6884.10.camel@dumbo.whgl.uni-frankfurt.de>
In-Reply-To: <1076891110.6884.10.camel@dumbo.whgl.uni-frankfurt.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Jean,

Thanx for your answer. Well, I had soem problems with gentoo kernels
in the past, so I decided to use a vanilla kernel, with xfs patches
and soem other small patches I needed (amongst them i2c).

I will check back on the libs. I was already considering using the
source and compiling it by hand.

Oh, and yes, I picked the patches from your page for the corresponding
vanilla kernel.

Best Regards

-Sven

P.S.: I'll come back to you as soon as I had time to test several
things and check the libs.

Monday, February 16, 2004, 11:14:18 AM, you wrote:

JD> [Please reply to the list, not to me]

JD> Quoting "Sven E." <dark@verfeiert.org>:

>> Driver `it87' (should be inserted):
>>   Detects correctly:
>>   * ISA bus address 0x0290 (Busdriver `i2c-isa')
>>     Chip `ITE IT8705F / IT8712F / SiS 950' (confidence: 8)
>>  
>> Driver `w83627hf' (may not be inserted):
>>   Misdetects:
>>   * ISA bus address 0x0290 (Busdriver `i2c-isa')
>>     Chip `Winbond W83627THF Super IO Sensors' (confidence: 8)

JD> We usually trust Super IO more than ISA. In newer versions of
JD> sensors-detect, Super IO have a confidence of 9, so it would have
JD> suggested w83627hf over it87 in your case.

>> As one can see now the Winbond is recommended as expected. yet, if I
>> use the recommended modules:
>> 
>> sensors
>> w83627thf-isa-0290
>> Adapter: ISA adapter
>> Algorithm: ISA algorithm
>> ERROR: Can't get alarm data!
>> ERROR: Can't get beep data!
>> ERROR: Can't get IN0 data!
>> ERROR: Can't get IN2 data!
>> ERROR: Can't get IN3 data!
>> ERROR: Can't get IN4 data!
>> ERROR: Can't get IN7 data!
>> ERROR: Can't get IN8 data!
>> ERROR: Can't get FAN1 data!
>> ERROR: Can't get FAN2 data!
>> ERROR: Can't get TEMP1 data!
>> ERROR: Can't get TEMP2 data!
>> 
>> Khali supposed the lib might be outdated, but where can I find the
>> lib.

JD> ls -l /usr/lib/libsensors*
JD> ls -l /usr/local/lib/libsensors*

JD> You can also do "$(which sensors)" and "ldd $(which sensors)" to see
JD> which library the sensors binary is linking to. If the library prefix
JD> differs from sensors one, there's something bad.

>> I am using gentoo, I patched the kernel since I need bttv I
>> installed all needed packages etc.

JD> We have a long history of problems with Gentoo. They have kernel patches
JD> that often make lm_sensors fail, although "sensors" alone usually works
JD> (this is "sensors -s" that usually fails).

JD> I'm not sure I understand what you mean with "I patched the kernel". Did
JD> you patch Gentoo kernel sources, or a vanilla kernel?

>> gentoo says I use lm-sensors 2.8.1 as well as i2c 2.8.1

JD> I would recommend that you clearly choose your side, and stick to it.
JD> Either use a Gentoo kernel and stick to their version of i2c and
JD> lm_sensors, or compile a vanilla kernel with my i2c patch, and install
JD> lm_sensors on your own (same version as i2c, preferably). Mixing Gentoo
JD> stuff with our own is likely to cause more trouble than it's worth.




-- 
Best regards,
 DarKRaveR                            mailto:DarKRaveR@verfeiert.org
