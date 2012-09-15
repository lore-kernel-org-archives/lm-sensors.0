From: Jonas Vasiliauskas <jonas.vasiliauskas@yahoo.com>
Date: Sat, 15 Sep 2012 20:29:06 +0000
Subject: Re: [lm-sensors] Support for Intel H77
Message-Id: <5054E512.9070002@yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <50542433.6040901@yahoo.com>
In-Reply-To: <50542433.6040901@yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

It was just from MC editor, they are harmless, sorry if this confused 
you. Here is the proper output: http://pastebin.ca/2204537
On 9/15/2012 23:26 PM, Guenter Roeck wrote:
> On Sat, Sep 15, 2012 at 09:53:57PM +0300, Jonas Vasiliauskas wrote:
>> Hi,
>>
>> thanks for the explanation. I got one more problem, now its the
>> module you wrote, I'm getting this when trying to compile:
>>
>> [root@NEUTRINO nct6775]# make
>> make[1]: *** No rule to make target `modules'.  Stop.
>> make: *** [modules] Error 2
>> [root@NEUTRINO nct6775]# make modules
>> make[1]: *** No rule to make target `modules'.  Stop.
>> make: *** [modules] Error 2
>> [root@NEUTRINO nct6775]# make all
>> make[1]: *** No rule to make target `modules'.  Stop.
>> make: *** [modules] Error 2
>>
>>
>> Also, here is my MakeFile http://pastebin.ca/2204518
>>
> Where do the "<------>" strings in the Makefile come from ?
> That is definitely not ok. Is there some tab corruption ?
>
> Guenter
>
>> Can you please tell me what is wrong ? I'm not sure is it either
>> makefile buggy or I'm doing something wrong.
>>
>> Thanks,
>> On 9/15/2012 17:50 PM, Guenter Roeck wrote:
>>> On Sat, Sep 15, 2012 at 09:46:11AM +0300, Jonas Vasiliauskas wrote:
>>>> Hi there,
>>>>
>>>> I hope you are doing well. Is there full support for intel h77 chip
>>>> ? I'm able to read temperatures using coretemp module, but can't
>>>> anyhow read fan speeds, not sure, maybe there is no support on
>>>> sensors for this chip ? Its one of the most decent, but not sure,
>>>> maybe you guys know how to get fan RPMs on console ? ;)
>>>>
>>> First of all, that is not a H77 (PCH) question, but a board question, and
>>> primarily depends on the SuperIO chip used on your board. Also, your board
>>> specification will tell you if the board uses the SuperIO chip or MEI for fan
>>> control.
>>>
>>> You might want to try running the latest version of sensors-detect (from
>>> http://www.lm-sensors.org/wiki/Download). That should tell you which SuperIO
>>> chip is used. Intel often uses Nuvoton NCT6775F. If so, use the driver at
>>> https://github.com/groeck/nct6775 and check if it handles fan control.
>>> If it does, you are lucky. If not, fan control may be handled by MEI (again,
>>> your motherboard specification should tell you that). In that case, you'll
>>> have to wait for someone to write a MEI fan control driver (or write one
>>> yourself ;).
>>>
>>> Thanks,
>>> Guenter
>>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
