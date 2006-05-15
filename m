From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Mon, 15 May 2006 21:11:41 +0000
Subject: [lm-sensors] W83627EHF driver enhancements
Message-Id: <4468EE8D.7070802@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <442ED616.4070109@sh.cvut.cz>
In-Reply-To: <442ED616.4070109@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi David,
> 
> Oops! Yes, I forgot to change the number of lines! I got in a hurry,
> and there you go...

hehe

>> David, do you have somewhere the speed cruise mode or we postpone it to later?
>> I went through your patches and they look good to me, I just fixed a codingstyle
>> on some place plus I want to verify some of your changes, I will do that tomorrow.
> 
> Thanks for fixing stuff. I would like to see what you end up with. The
> RPM speed cruise is coming, sorry for taking so long...

NP I have also lot of stuff to do...

> 
>> plan:
>>
>> 1) I will merge yours patches to one bigger (tomorrow)
>> 2) I have fixed the sysfs docs and I post them (tomorrow)
>> 3) I still think that check for fan4 and fan5 is not sufficient.
>>    see page 94 (printed) in datasheet, the pin 119 can be GPIO,
>>    similar for other fan which is shared with serial flash interface,
>>    but it seems the datasheet is not sharing with us the pin control.
>>
>> PI) speed cruise mode patch ?
>> 4) cleanup patch for whole file
>> 5) docs update reflecting the fan control (got some notes about the files)
>>
>> Personally I think we can wait with fanspeed cruise a bit and concentrate to
>> finish our stuff...
> 
> Okay, yes, especially #3 and #4 (and I look forward to reading the
> updates to the docs, you have new information?). When I do get around
> to writing the RPM cruise and the SpeedFan III support, it can just be
> added on, no matter what else is done.
> 

Speed fan III is there ...

In the attachment is our patches merged to one. I need to investigate the 
fan4/fan5 enable, I will write separate email to Dezheng.
#5 is still a skeleton file, but we should publish it same time as the whole patch.

Plan: I will fix the fan4/fan5, please test the stuff and update the docs file 
so we know that the info there is really true, plus you may try to test the 
driver with the help of this file.

If you have spare time, you may prepare the documentation update patch for the 
EHF entry in kernel documentation. For the format see rest of the file or other 
files.

And after this step we can push the stuff to Jean and on the to cleanup + RPM 
cruise or vice-versa depending on existing cleanup patch reuuse ;)

Regards
Rudolf
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: ehf_patch_rc1
Url: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060515/7360cd2e/ehf_patch_rc1.pl
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: docs
Url: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060515/7360cd2e/docs.pl
