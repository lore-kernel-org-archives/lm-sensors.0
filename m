From: phil@edgedesign.us (Philip Edelbrock)
Date: Thu, 19 May 2005 06:24:57 +0000
Subject: linking libsensors
Message-Id: <40A107CD.3060900@edgedesign.us>
List-Id: <lm-sensors.vger.kernel.org>
References: <409FC0E1.7060905@sepaton.com>
In-Reply-To: <409FC0E1.7060905@sepaton.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



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
It might be time to actually find someone who can say "IAAL" to tell 
us.. ;')

There are two issues: linking and distributing the binary (in an 
appliance).  From my understanding, linking to libsensors and 
distributing the result in an appliance (to the public) requires that 
all linked code be released, with the possible exception of the 
lm-sensors code if it has /not/ been modified.

Otherwise, Mark, I think you are right if they aren't releasing the 
result to the public in some way.


Phil
