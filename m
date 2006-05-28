From: j.w.r.degoede@hhs.nl (Hans de Goede)
Date: Sun, 28 May 2006 19:09:50 +0000
Subject: [lm-sensors] PATCH: abituguru driver
Message-Id: <4479F57E.5070109@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <4470B10F.7070502@hhs.nl>
In-Reply-To: <4470B10F.7070502@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Jean Delvare wrote:
> Quoting myself:
>>> Ok, I'll add a bunch of defines, is 1 define for the total names length 
>>> (including \0) per sensor type acceptable so say (numbers are fiction):
>>> ABITUGURU_IN_NAMES_LENGTH   150
>>> ABITUGURU_TEMP_NAMES_LENGTH 120
>>> ABITUGURU_FAN_NAMES_LENGTH   80
>>> ABITUGURU_PWM_NAMES_LENGTH  100
>>>
>>> And I'll switch to snprintf
>> No, actually I think you should define a maximum length per file name
>> first. Then multiply by the number of files per input, then by the max
>> number of inputs, and finally add everything to get the total array
>> size. It doesn't matter if it makes you define a dozen constants, as
>> long as the final result can be easily verified by the reviewer. Feel
>> free to make the define names a bit shorter if it makes the expressions
>> more readable.
> 
> I might sound a bit extreme here. What I really mean is that values
> need to be explained, not that you must have one define for each number
> taking part in the computation. In other words, I am fine with:
> #define UGURU_IN_NAMES_LENGTH	(18 * 3 + 32 * 3 + 14) 
> As long as there is some comment explaining what 18, 32 and 14 are.
> 
>> Of course, the size parameter you pass to snprintf will need to be
>> expressed in terms of these constants.
> 
> As for this, the only thing you really need to check against the total
> size of the array, for which I guess you'll have a (computed) define.
> 

This is what I had in mind too, done. The attached patch fixes this as
requested and also fixes the requested should fixes, changes:
 - exactly calculate the sysfs_names array length using macro
 - use snprintf when generating names to double check that the
   sysfs_names array does not overflow.
 - use ARRAY_SIZE and / or defines to determine number of loops in for
   loops instead of using hardcoded values.
 - In abituguru_probe(), refactor the error path leaving a single call
   to kfree

Signed-off-by: Hans de Goede <j.w.r.degoede at hhs.nl>


Regards,

Hans
-------------- next part --------------
A non-text attachment was scrubbed...
Name: hwmon-abituguru-fixes.patch
Type: text/x-patch
Size: 15648 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060528/8a747e8c/hwmon-abituguru-fixes-0001.bin
