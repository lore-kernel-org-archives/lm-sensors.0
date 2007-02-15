From: j.w.r.degoede@hhs.nl (Hans de Goede)
Date: Thu, 15 Feb 2007 07:04:15 +0000
Subject: [lm-sensors] Abit AT8 (non-32X) / Winbond 83627EHF
Message-Id: <45D405EF.4080805@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <45D0A4B2.6030002@vt.edu>
In-Reply-To: <45D0A4B2.6030002@vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Rick,
> 
> On Wed, 14 Feb 2007 14:43:09 -0500, Rick Wright wrote:
>> Thanks for the support  Hans de Goede responded to me off list 
>> suggesting that, in fact, I probably have a abituguru ver3 chip, not a 
>> w83627ehf chip afterall.  The problem is that this ver3 abituguru chip 
>> is not fully supported by sensors, libsensors, etc.  However, he did 
>> point me to a userspace utility he wrote that I was able to use to 
>> successfully interrogate my uGuru chip.  All along I knew this board 
>> probably used a uGuru setup.  I will forward those messages back to the 
>> list under this thread for others' benefit.
>>
>> On the other hand, the problem that lm_sensors still has is that it was 
>> the sensors-detect script that originally reported that I had a 
>> w83627ehf chip and ultimately led me down this path.  Hans suggested 
>> this is not a correct identification job and that sensors-detect should 
>> be fixed.
> 
> Hans is probably wrong. The Super-I/O chip detection is very reliable
> and I would ve very surprised if you do not have a Winbond W83627EHF.
> As a matter of fact, this hi-res picture of your motherboard:
>   http://www.techpowerup.com/reviews/Abit/AT8/images/board_fullsize.jpg
> clearly shows a W83627EHF in the top-left-hand corner.
> 
> But indeed there's also a uGuru chip on the board. Bad luck.
> 

Ah, so this board has 2 sensors chips. Rick, can you see if the 
W83627EHF voltage are any good (IOW match the ones given by openguru)?


Jean, about the bad luck part, the uguru revision 3 actually is a pretty 
nice chip (except for the lack of specs) as Rick writes I've written a 
userspace reading utility for it and it works fine for all people who 
have tested it (about 7 or so). I've also written a new kernel driver 
for this new revision (it uses an entirely different "protocol") which 
I've posted for review some time ago. If when can get some movement on 
that review then users with a newer uguru will no longer have bad luck, 
but instead a support chip.

Regards,

Hans


