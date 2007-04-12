From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Thu, 12 Apr 2007 07:27:57 +0000
Subject: Re: [lm-sensors] Hardware monitoring subsystem
Message-Id: <461DDF7D.1060101@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070410150227.1bac05b5@hyperion.delvare>	<461BB006.9020308@hhs.nl><4dfa50520704100846s7c031ab0i9da94a9e993cbbfc@mail.gmail.com><461C0E0E.5090008@assembler.cz>	<461CA932.4060108@hhs.nl> <461dca480d7ec@wp.pl>
In-Reply-To: <461dca480d7ec@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Krzysztof Helt <krzysztof.h1@wp.pl>
Cc: "Mark M. Hoffman" <mhoffman@lightlink.com>, LKML <linux-kernel@vger.kernel.org>, LM Sensors <lm-sensors@lm-sensors.org>

Krzysztof Helt wrote:
> This is comments from someone who is newbie to this list.
> 
>> 1a) We need a set of review guidelines / a review checklist.
> Here is a start:
> 
> Maybe these guidelines can be described in more details and with
> links or names of documents with more description.
> 

Yes they should, this was just a quick list. Feel free to help writing a better 
list. And I guess we should put this list in the wiki somewhere.

>> * Must follow kernel coding style guidelines
> 
> Is there any tool to check this? If there is one, a basic
> instruction how to use it would be great.
> 

No tool.

>> * sysfs interface must be in accordance with
> Documentation/hwmon/sysfs
> 
> The documentation is still confusing to me. Can someone of you
> update it to answer these questions directly?
> 
> A. What is meaning of 0 and 1 values in pwmX_enable ?
> B. How to stop the fan (pwmX_enable = 1 and pwmX = 0 was
> suggested to someone on the list)?
> C. How t o handle situation if the pwm register minimum value (0)
> does not stop the fan, but there is a separate bit to do it? (do
> stop emulate with the bit when 0 is written to pwmX?)
> 

I think this is best answered by Jean and/or Mark

>> * proper locking to avoid 2 simultaneous attempts to
> communicate with the
>>    device when for example multiple sysfs files get read at once.
> 
> An example or two common errors would be great help.
> 

Erm, if  someone doesn't know what this means / how to look for this he 
shouldn't be reviewing a driver.

>> * check the code for any obvious programming errors, like:
>>    -not freeing resources (in error paths and in general)
>>    -overrunning an array
>>    -not checking return values of calls to other parts of the
> kernel
>>    -of by one errors / bad loops
>>    -etc.
> 
> List them, so a newbie can check the code against it.
> 

The etc. was because I'm sure there are more but I couldn't come up with any 
right there and then. And again a newbie shouldn't be reviewing, he should 
start reading some book in device drivers writing a driver or two himself get 
those reviewed and then he should no longer be a newbie :)

>> 1b) We need to decide somehow who can do reviews. For now I say
> anyone who
>>    already maintains atleast one hwmon driver. But thats just a
> wild shot better
>>    ideas are welcome.
>>
> 
> There are volunteers already. In order to lessen their work you
> can require to follow the guidelines (if they got described) by
> authors of patches .

Yes ofcourse authors should follow the guidelines, and check they did 
themselves before submitting. Also its great that there are volunteers, but 
reviewing does require a certain level of competence. There are many other ways 
to help out for those without the necessary skills todo the reviewing.

For example you could check out the 3.0.0 branch:
svn checkout http://lm-sensors.org/svn/lm-sensors/branches/lm-sensors-3.0.0

Edit lib/chips.c, goto the long array at the end and comment any entries for 
chips you have. Optionally edit prog/sensors/main.c goto the array near the end 
and again comment entries for chips you have.

Build and install lm-sensors-3.0.0 and let us know how it works, despite the 
commenting it should still recognize your cips and print the same info as usual 
(it can now dynamicly recognize new/unknown chips as long as the kernel 
supports them). When you skipped the optional step run the sensors command as 
'sensors -g', the normal sensors command will be borked if you skipped this step.

Thanks & Regards,

Hans


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
