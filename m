From: ukessler@uni-bonn.de (=?ISO-8859-1?Q?Ulrich_Ke=DFler?=)
Date: Fri, 24 Nov 2006 15:04:59 +0000
Subject: [lm-sensors] CPU temperature(s) of Conroe
Message-Id: <45670A1B.7060308@uni-bonn.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <loom.20061123T125301-366@post.gmane.org>
In-Reply-To: <loom.20061123T125301-366@post.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi, Rudolf,

I have tried to follow your instructions but since I am quite a linux 
novice I have some problems as indicated below.

Rudolf Marek wrote:

> Hello Ulrich,
>
>> I have an ASUS P5B-VM with an E6600 and would like to monitor the CPU
>> temperatures. Sensors-detect only finds an LM78 chip which has only one
>> temparature sensor. The temperature shown by sensors is obviously the
>> Mobo-temperature (same as in BIOS).
>
>
> The LM-78 is a misdetection. Please try latest sensors-detect (check 
> the devices page on our web)
>
> I bet you have W83627DHG, you will need a patch for this chip. Here is 
> preliminary patch:
>
> http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060906/b139bc4d/attachment-0001.obj 
>
>
>
I have downloaded this patch. I understand that this is a C program. But 
I don't know where to put it and what to do with it. Could you please 
give me guidance?

>
>> I have read that Conroes possess integrated
>> read out directly from CPU registers.
>> a) Is this correct?
>
>
> Yes
>
>> b) Is this implemented in lm-sensors?
>
>
> Yes but not yet in kernel. You will need latest SVN snapshot of 
> lm-sensors (make user_install)

I downloaded the last SVN (2006/11/18), extracted, make user, make 
user_install. So far everything worked fine. Then I ran sensors-detect. 
It was revision 1.413 (2006/01/19) which I suspect not being the most 
recent one. It again only found the LM78 (because of the missing patches?).
Do I have to uninstall the previous version of lm-sensors before 
installing the new version?

> and also this set of patches:
> http://lists.lm-sensors.org/pipermail/lm-sensors/2006-October/018100.html
>
> (some of the patch files are posted TWICE, please use the latest 
> version - click on mail thread to check what is latest)
>
I think you mean this patch: 
http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20061017/759c6d1b/attachment-0001.bin

The same problem for me as before: I downloaded the file, recognized it 
as a C program, but don't know how to proceed.

>> c) If yes, what do I have to do to get sensors show the CPU 
>> temperatures of the
>> two cores?
>
>
> CHeck above. You will have more than one sensor ;)
>
>> Thank you for reply. If you need further info, please let me know.
>
>
> Please let me know if it works OK, and David too.
>
> Regards
> Rudolf
>
>
Some information on my system in case it meght help:
ASUS P5B-VM
E6600
2 GB DDR2-667 CL4
SUSE 10.1
Kernel 2.6.16.21-0.25-smp

I appreciate your help. Thank you.

Uli

