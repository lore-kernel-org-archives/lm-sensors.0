From: singumal <qdmd-pu1o@dea.spamcon.org>
Date: Sun, 29 Dec 2013 04:52:26 +0000
Subject: Re: [lm-sensors] trying to free nonexistent resource [was: ASRock IMB-170 configuration help]
Message-Id: <siavb9d0inqfc6gfq0ko28nelcemujtn68@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <523F4C0A.1050800@roeck-us.net>
In-Reply-To: <523F4C0A.1050800@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Guenter Roeck <linux@roeck-us.net> wrote:

>On 09/22/2013 11:41 AM, singumal wrote:
>> singumal <qdmd-pu1o@dea.spamcon.org> wrote:
>>
>[ ... ]
>>
>> Noticed an error message on physical console when restarting
>> lm_sensors, look in syslog, here are all the messages:
>>
>> Sep 19 08:38:49 localhost kernel: Trying to free nonexistent resource
>> <0000000000000295-0000000000000296>
>> Sep 19 08:38:49 localhost kernel: coretemp coretemp.0: TjMax is 105 C.
>> Sep 19 08:38:49 localhost kernel: coretemp coretemp.1: TjMax is 105 C.
>> Sep 19 08:38:49 localhost kernel: coretemp coretemp.2: TjMax is 105 C.
>> Sep 19 08:38:49 localhost kernel: coretemp coretemp.3: TjMax is 105 C.
>> Sep 19 08:38:49 localhost kernel: w83627ehf: Found W83627UHG chip at 0x290
>>
>>
>> Does that resource message indicate misconfiguration, or some other problem?
>>
>AFAIK this problem has been solved in a later kernel version, though I may be wrong.
>What is your kernel version ? I don't think you ever mentioned it.
>
>Thanks,
>Guenter

Sorry for the delay in replying; kernel is as shipped with CentOS 5.7:

# uname -a
Linux q57-1 2.6.18-274.el5 #1 SMP Fri Jul 22 04:43:29 EDT 2011 x86_64 x86_64 x86_64
GNU/Linux



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
