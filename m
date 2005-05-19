From: phil@edgedesign.us (Philip Edelbrock)
Date: Thu, 19 May 2005 06:24:57 +0000
Subject: linking libsensors
Message-Id: <409FDE86.6060206@edgedesign.us>
List-Id: <lm-sensors.vger.kernel.org>
References: <409FC0E1.7060905@sepaton.com>
In-Reply-To: <409FC0E1.7060905@sepaton.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

If there are license incompatibilities that can only be solved by 
changing the license of lm-sensors, then the answer is almost certainly 
'No'.  IANAL, but even if we went forward with making an exception for 
you, we would need to track down all the copyright holders that have 
touched lm-sensors and get explicit permission to change the license for 
this exception.  That would be a huge task that is simply not much of a 
reality anymore.  In most cases, it isn't advantageous to change our 
license anyway, since it goes against the ideals of most of the 
contributors who helped make Lm-sensors what it is.

What license is your project written under?  Are you sure it isn't 
compatible?

PS- We should probably change the README to eliminate the last two 
sentences and perhaps alter the first to remove "at this moment".  I 
made the argument a few years ago to switch to LGPL, but my motivations 
were probably flawed and I can't see it being a simple task to even do 
it legally/correctly at this point with so many drivers and contributors 
in the package.


Phil

Subba wrote:

> It is a legal question.
> I am asking becuase the README file has the following:
>
> Note that at this moment, libsensors falls under the GPL, not the LGPL.
> In more human language, that means it is FORBIDDEN to link any 
> application
> to the library, even to the shared version, if the application itself
> does not fall under the GPL. This will probably be changed in the future.
> In the meantime, you will have to contact us first if you want to do 
> this.
>
>
> Jean Delvare wrote:
>
>>> We would like to know if it is possible to link libsensors with our 
>>> application which is monitoring the intel motherboard in our
>>> storage device.
>>>   
>>
>>
>> Is this a legal or technical question?
>>
>> At any rate, please provide actual information if you want to be able to
>> answer.
>>
>>  
>>
>
