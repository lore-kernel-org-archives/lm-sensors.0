From: singumal <qdmd-pu1o@dea.spamcon.org>
Date: Thu, 12 Sep 2013 08:56:30 +0000
Subject: Re: [lm-sensors] Cannot compile w83627ehf standalone driver
Message-Id: <ka03391bb1cahe5ifc6dio7jco1l4g3ekl@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4gtj299ua16tgbppavpscp3ljolbrs8o8r@4ax.com>
In-Reply-To: <4gtj299ua16tgbppavpscp3ljolbrs8o8r@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Phil Perry <phil@elrepo.org> wrote:

>On 11/09/13 16:22, Guenter Roeck wrote:
>> On Wed, Sep 11, 2013 at 03:23:30PM +0100, Phil Perry wrote:
>>> On 11/09/13 06:44, singumal wrote:
>>>> Phil Perry <phil@elrepo.org> wrote:
>>>>
>>>>> On 06/09/13 21:22, Jean Delvare wrote:
>>>>>> On Fri, 06 Sep 2013 08:37:43 -0700, singumal wrote:
>>>>>>> I have an ASRock IMB-170 Mini-ITX board; 3.3.4's sensors-detect shows:
>>>>>>>
>>>>>>>     Found `Winbond W83627UHG/NCT6627UD Super IO Sensors'        Success!
>>>>>>>         (address 0x290, driver `w83627ehf')
>>>>>>>
>>>>>>> I'm on an older kernel, and I can't seem to compile the driver
>>>>>>> from:
>>>>>>>
>>>>>>>      http://khali.linux-fr.org/devel/lm-sensors/drivers/w83627ehf/
>>>>>>>
>>>>>>>
>>>>>>> [root@plain1 driver]# uname -a
>>>>>>> Linux plain1 2.6.18-274.el5 #1 SMP Fri Jul 22 04:43:29 EDT 2011 x86_64 x86_64 x86_64 GNU/Linux
>>>>>>> [root@plain1 driver]# make
>>>>>>>     CC [M]  /root/driver/w83627ehf.o
>>>>>>> /root/driver/w83627ehf.c: In function `in_from_reg':
>>>>>>> /root/driver/w83627ehf.c:416: error: implicit declaration of function `DIV_ROUND_CLOSEST'
>>>>>>> ... [many more errors and warnings]
>>>>>>
>>>>>> This driver was never tested for kernels older than 2.6.32. More
>>>>>> compatibility work would be needed to get it to build and work on
>>>>>> kernel 2.6.18.
>>>>>>
>>>>>> I'm wondering if maybe Redhat can provide a backported version as a
>>>>>> separate package? You're probably not the only one asking for this, as
>>>>>> this is a popular driver.
>>>>>>
>>>>>
>>>>> I've already done a backport of the w83627ehf for RHEL5 and RHEL6, and
>>>>> it is packaged as a kABI-tracking kmod RPM package (kmod-w83627ehf) in
>>>>> the elrepo repository.
>>>>>
>>>>> http://elrepo.org/tiki/kmod-w83627ehf
>>>>>
>>>>> This driver is backported from the longterm kernel-3.2.50.
>>>>>
>>>>> Once you have set up the elrepo repository:
>>>>>
>>>>> yum install kmod-w83627ehf
>>>>>
>>>>> will pull in the updated driver.
>>>>>
>>>>> Further, because it's a kABI-tracking package the driver will seamlessly
>>>>> work with new kernels so you will not need to recompile the driver
>>>>> against each new kernel update (an advantage of Red Hat's stable kernel
>>>>> ABI).
>>>>>
>>>>> Regards,
>>>>>
>>>>> Phil
>>>>>
>>>>
>>>> Thank you very much, Phil.
>>>>
>>>> Unfortunately, it doesn't seem to quite like my system,
>>>>
>>>> The RPM installed fine, but "sensors" only shows coretemp, not the chip.
>>>> Finally I checked the module - something isn't right:
>>>>
>>>> [root@tm3 etc]# modprobe w83627ehf
>>>> FATAL: Error inserting w83627ehf (/lib/modules/2.6.18-274.el5/weak-updates/w83627ehf/w83627ehf.ko): No such device
>>>>
>>>>
>>>
>>> Hi,
>>>
>>> I'm not sure what the problem is. One thing I note is that you are
>>> running an older RHEL 5.7 kernel. Would it be possible to try
>>> booting the latest/current RHEL kernel to at least eliminate that as
>>> the possible cause (i.e, a RHEL 5.9 kernel;
>>> kernel-2.6.18-348.16.1.el5 is the latest).
>>>
>> Maybe the chip in question is not supported by the backported version
>> of the driver.
>>
>> Guenter
>>
>
>Hi Guenter,
>
>It should be (unless maybe it's being mis-detected by sensors-detect?). 
>The backport is from kernel-3.2.48 LT branch which contains the patch to 
>add support for the W83627UHG chip, as reported by sensors-detect above.
>
>Phil

Trying it under CentOS 5.9, it still doesn't work:

[root@x59 ~]# cp /media/MULTIBOOT/Work/kmod-w83627ehf-0.0-8.el5.elrepo.x86_64.rpm .
[root@x59 ~]# rpm -Uvh kmod-w83627ehf-0.0-8.el5.elrepo.x86_64.rpm
warning: kmod-w83627ehf-0.0-8.el5.elrepo.x86_64.rpm: Header V3 DSA signature: NOKEY, key ID baadae52
Preparing...                ########################################### [100%]
   1:kmod-w83627ehf         ########################################### [100%]
Working. This may take some time ...
Done.
[root@x59 ~]# modprobe w83627ehf
FATAL: Error inserting w83627ehf (/lib/modules/2.6.18-348.el5/weak-updates/w83627ehf/w83627ehf.ko): No such device
[root@x59 ~]# uname -a
Linux x59 2.6.18-348.el5 #1 SMP Tue Jan 8 17:53:53 EST 2013 x86_64 x86_64 x86_64 GNU/Linux



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
