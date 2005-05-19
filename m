From: hdbtroll@moment.net (DB Troll)
Date: Thu, 19 May 2005 06:23:46 +0000
Subject: 2.7.0 Error in make
Message-Id: <3E2C8344.3030904@moment.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <3E2C49C0.705@moment.net>
In-Reply-To: <3E2C49C0.705@moment.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Mark M. Hoffman wrote:

>* DB Troll <hdbtroll@moment.net> [2003-01-20 16:30:19 -0600]:
>  
>
>>Jean,
>>Ignore last msg I found flex and installed but still come up with an error
>>
>>    
>>
>>>lib/libsensors.so: undefined reference to `sensors_yylex'
>>>lib/libsensors.so: undefined reference to `sensors_yyin'
>>>lib/libsensors.so: undefined reference to `sensors_lex_error'
>>>lib/libsensors.so: undefined reference to `sensors_yylineno'
>>>collect2: ld returned 1 exit status
>>>make: *** [prog/sensors/sensors] Error 1
>>>linux:/home/dbtrol/lm_sensors-2.7.0 #David
>>>      
>>>
>>David
>>
>>    
>>
>
>After you've installed flex and bison (or equivalent), you
>probably need to "make clean" before you "make" again.
>
>Regards,
>
>  
>
Mark and Jean,
Thank you very much for the info. I now have sensors up and running. 
Still a few problems with a couple of wrong voltages and no voltages 
showing in gkrellm, also do not seem to get it to auto start on boot.
Thanks
David

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 252 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20030120/473546df/attachment.bin
