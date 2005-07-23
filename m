From: jcromie@divsol.com (Jim Cromie)
Date: Sat, 23 Jul 2005 01:31:16 +0000
Subject: [lm-sensors] [patch]  KERNELVERSION=2.6.12-something make
Message-Id: <42E181B2.2000908@divsol.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <42E04664.3020001@divsol.com>
In-Reply-To: <42E04664.3020001@divsol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:

>Hi Jim,
>
>  
>
>>FWIW:  I just tried to stuff this into Makefile, to automate the
>>clue-stick you poked me with:
>>
>>ifneq (,$(findstring 2.6 , $(KERNELVERSION)))
>>    ifneq (,$(findstring 'user', $(MAKECMDGOALS)))
>>        $(error 'only user* targets needed/supported for 2.6 builds')
>>    endif
>>endif
>>
>>obviously, it didnt work, or Id have sent a patch.
>>Can you fit it in the proper place, or advize where it belongs ?
>>    
>>
>
>The following, derived from yours, works for me:
>
>ifeq (,$(findstring /2.4., $(MODPREF)))
>    ifeq (, $(MAKECMDGOALS))
>        $(error For 2.6 kernels and later, use "make user")
>    endif
>    ifeq (install, $(MAKECMDGOALS))
>        $(error For 2.6 kernels and later, use "make user_install")
>    endif
>endif
>
>I've added it right after the line which computes $(MODPREF). Please
>give it a try and tell me what you think. I might commit it to CVS if
>nobody objects. I might also add something similar to the i2c package.
>
>  
>
[jimc@harpo lm_sensors2]$ make
Makefile:91: *** For 2.6 kernels and later, use "make user".  Stop.
[jimc@harpo lm_sensors2]$ make install
Makefile:94: *** For 2.6 kernels and later, use "make user_install".  Stop.

ie, works for me. 
At first I didnt like the extra noise/Stop, but changed my mind.
It has better chance of standing out in a gentoo-like full system build.
Someday, someone will ask that the makefile just does what the user
should have asked for ;-)

So, patch attached, which adds a # comment, so that when clueful users
look at the line in the makefile, they'll know why its an error.
Also replaced leading spaces with tabs, to keep emacs makefile mode
from interrogating me on saves (not needed for making, but saves annoyance).

>BTW, Jim, I'd like to add that I very much enjoy your attitude of
>sending patches to help us fix things rather that just complaining that
>things don't work. Even if the patches end up not being needed or
>correct, don't stop! :) This is always a good base to start with.
>
>  
>
heh.  My pleasure.
For what Im paying you, you shouldn't have to listen to me bitch.
Bad patches may contain good ideas, Im glad you are willing to separate
the wheat from the chaff, its certainly meaningful encouragement.
Get *great* mileage on bad gas !
Honey attracts bears better than a skunk does.
Curiously, so does a rotting carcass.
(ok, enough slogans, before I get silly).


In the half-baked ideas dept ( while youre still enjoying my attitude) ..

I was poking around to see if could grok the sysfs api support
that would allow replacing the long lists of
                device_create_file(&new_client->dev, &dev_attr_inX_input);

with something like:
    for(i=0; i<vpoints_max; i++) {
                device_create_file(&new_client->dev, &dev_attr_in[i].in);
                device_create_file(&new_client->dev, &dev_attr_in[i].max);
                device_create_file(&new_client->dev, &dev_attr_in[i].min);
    }

looking at it again now, it appears to hinge upon doing something
clever with DEVICE_ATTR, and unwinding some of the large-ish macros.
... and a bunch of stuff I havent yet understood.

..I did say half-baked ;-)

This should have been in another thread, feel free to change the subject
if you want .. (sending) no wait, too late..
