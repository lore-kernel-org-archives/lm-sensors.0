From: sgaddama@sepaton.com (Subba)
Date: Thu, 19 May 2005 06:24:57 +0000
Subject: linking libsensors
Message-Id: <40A0D2C8.1010209@sepaton.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <409FC0E1.7060905@sepaton.com>
In-Reply-To: <409FC0E1.7060905@sepaton.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

All I want to know is whether it is ok to link my application (which 
will be installed
on an appliance we ship to our clients) with lm-sensors.
I don't want to commit any changes to lm-sensors code.



Mark M. Hoffman wrote:

>Hello:
>
>* Philip Edelbrock <phil@edgedesign.us> [2004-05-10 12:56:54 -0700]:
>  
>
>>If there are license incompatibilities that can only be solved by 
>>changing the license of lm-sensors, then the answer is almost certainly 
>>'No'.  IANAL, but even if we went forward with making an exception for 
>>you, we would need to track down all the copyright holders that have 
>>touched lm-sensors and get explicit permission to change the license for 
>>this exception.
>>(snip the rest)
>>    
>>
>
>(IANAL)
>
>Remember that the GPL only restricts release/redistribution (source and/or
>binaries).  If you do not redistribute the results, you can link GPL'ed
>libraries to whatever you want:
>
>http://www.fsf.org/licenses/gpl-faq.html#GPLRequireSourcePostedPublic
>
>  
>
>>Subba wrote:
>>
>>    
>>
>>>It is a legal question.
>>>I am asking becuase the README file has the following:
>>>
>>>Note that at this moment, libsensors falls under the GPL, not the LGPL.
>>>In more human language, that means it is FORBIDDEN to link any 
>>>application
>>>to the library, even to the shared version, if the application itself
>>>does not fall under the GPL. This will probably be changed in the future.
>>>In the meantime, you will have to contact us first if you want to do 
>>>this.
>>>      
>>>
>
>Regards,
>
>  
>
