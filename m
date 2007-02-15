From: riwright@vt.edu (Rick Wright)
Date: Thu, 15 Feb 2007 16:00:46 +0000
Subject: [lm-sensors] Abit AT8 (non-32X) / Winbond 83627EHF
Message-Id: <45D483AE.3070009@vt.edu>
List-Id: <lm-sensors.vger.kernel.org>
References: <45D0A4B2.6030002@vt.edu>
In-Reply-To: <45D0A4B2.6030002@vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hans de Goede wrote:

> Jean Delvare wrote:
>
>> Rick,
>>
>> On Wed, 14 Feb 2007 14:43:09 -0500, Rick Wright wrote:
>>
>>> Thanks for the support  Hans de Goede responded to me off list 
>>> suggesting that, in fact, I probably have a abituguru ver3 chip, not 
>>> a w83627ehf chip afterall.  The problem is that this ver3 abituguru 
>>> chip is not fully supported by sensors, libsensors, etc.  However, 
>>> he did point me to a userspace utility he wrote that I was able to 
>>> use to successfully interrogate my uGuru chip.  All along I knew 
>>> this board probably used a uGuru setup.  I will forward those 
>>> messages back to the list under this thread for others' benefit.
>>>
>>> On the other hand, the problem that lm_sensors still has is that it 
>>> was the sensors-detect script that originally reported that I had a 
>>> w83627ehf chip and ultimately led me down this path.  Hans suggested 
>>> this is not a correct identification job and that sensors-detect 
>>> should be fixed.
>>
>>
>> Hans is probably wrong. The Super-I/O chip detection is very reliable
>> and I would ve very surprised if you do not have a Winbond W83627EHF.
>> As a matter of fact, this hi-res picture of your motherboard:
>>   http://www.techpowerup.com/reviews/Abit/AT8/images/board_fullsize.jpg
>> clearly shows a W83627EHF in the top-left-hand corner.
>>
>> But indeed there's also a uGuru chip on the board. Bad luck.
>>
>
> Ah, so this board has 2 sensors chips. Rick, can you see if the 
> W83627EHF voltage are any good (IOW match the ones given by openguru)?
>
Due to labeling differences, I'm not 100% sure how to match up the 
output values for comparison.  That said, both sensors & oguru give 
"reasonable" values.  The oguru information is much more complete.  With 
sensors: w83627ehf only gives voltage readings; (no valid fan speeds, no 
valid temps), but k8temp seems to give correct temp readings.

Attached is the output from both sensors & oguru run ~2 seconds apart.

I'm happy to continue to help testing, etc.  I'd really like to get this 
board supported as I've deployed 3 into production environments and 
would like to implement automated health monitoring.  Let me know how I 
can help.


Rick
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: sensors.txt
Url: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20070215/1d02bb2b/attachment.txt 
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: oguru.txt
Url: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20070215/1d02bb2b/attachment-0001.txt 
