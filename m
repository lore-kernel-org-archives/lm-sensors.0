From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Tue, 24 Jul 2007 21:01:04 +0000
Subject: Re: [lm-sensors] ADT7475 lm_sensors / linux driver
Message-Id: <46A66890.6060900@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <46A6071C.5020809@hhs.nl>
In-Reply-To: <46A6071C.5020809@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Joel McKee Cooper wrote:
> Hans -
> 
> I got sidetracked with, well, Deathly Hallows (among other things) and
> haven't had a chance yet to look into the driver :)  Feel free to have
> the slaves^H^H^H^H^H^H students take a whack at it - sounds like a
> great idea!
> 
> I've got an ASUS M2N-SLI Deluxe Socket AM2 NVIDIA nForce 570 SLI MCP
> ATX AMD Motherboard.  Here's the sensors-detect output:
> 

Thanks for the reply, I'll keep this driver on my list of possible lab 
assignments then, do you happen to know if the non SLI versions of the ASUS M2N 
familiy have the same chip?

Thanks & Regards,

Hans


> On 7/24/07, Hans de Goede <j.w.r.degoede@hhs.nl> wrote:
>> Hi,
>>
>> Short intro: I'm the author of several 2.6 hwmon drivers, and I'm also a
>> teacher in computer science at a Dutch University. Coming September I 
>> will be
>> giving a class in writing Linux device drivers and I want to use some 
>> real
>> world examples as lab exercises.
>>
>> This could include letting the students write a driver for the 
>> ADT7475, which I
>> will then submit to the kernel and maintain, unless the students want 
>> to do
>> this him / her self.
>>
>> Which leads me to the question what the status is of your attempts to 
>> write a
>> driver, I preferably don't want my students to do something that has 
>> already be
>> done. Also what asus motherboard do you have _exactly_, because if my 
>> students
>> are going to take a go at this, I will need to buy a motherboard with 
>> this chip
>> on it for them to develop on.
>>
>> Thanks & Regards,
>>
>> Hans
>>
>>
>>
> 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
