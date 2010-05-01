From: foo bar <abi1789@googlemail.com>
Date: Sat, 01 May 2010 18:16:46 +0000
Subject: Re: [lm-sensors] [Fancontrol] better support for init script error
Message-Id: <4BDC700E.2010301@googlemail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4BDC48C0.9090303@googlemail.com>
In-Reply-To: <4BDC48C0.9090303@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 05/01/2010 06:42 PM, Jean Delvare wrote:
> Hi,
>
> On Sat, 01 May 2010 17:29:04 +0200, PyroPeter wrote:
>    
>> Some months ago, the /etc/fancontrol syntax changed,
>>      
> Please be specific. The syntax never changed, it was extended in
> fully backwards compatible ways, this should never have caused
> fancontrol to fail, unless you downgraded it.
>
>    
At the 28th of February I had to add DEVPATH and DEVNAME settings to my 
config file.
Of cause this is my fault, because I manually wrote the config.
>> and fancontrol
>> exited right after startup, but the init script stated success.
>>
>> Currently there is no reliable way for a init script to check if
>> fancontrol started up properly.
>>      
> Running it using startproc should do the trick. That's what openSUSE
> does.
>
>    
After reading the manpage online, I get the impression that startproc 
just has the advantage of checking for an already running daemon before 
starting it. But I will take a look at a SUSE initscript.

Besides that, I do not get how you should check if fancontrol started up 
properly.
The only way I could imagine is: you run fancontrol, wait some seconds 
and then check for the pid-file. I won't have to tell anyone how dirty 
that is.
>> As fancontrol is a deamon preventing hardware damage, reliability should
>> be of first priority.
>>      
> This is incorrect. fancontrol is a daemon _causing_ hardware damage, if
> anything. The initial state of your system should be safe, so
> fancontrol not starting should never be a safety issue.
>
>    
Not for me. My mainboard has some kind of broken fan control that always 
sets a very low speed, which makes it acoustically indistinguishable 
from fancontrol but fails at high CPU loads. But that is not a 
fancontrol issue at the first point.
>> I would suggest adding a argument to fancontrol that makes it start up,
>> check config syntax and write permissions, and than fork to the
>> background, or return a positive exit code.
>>
>>
>> I wrote a kind of proof of concept that simply uses the existing
>> bash-script and "forks" by reexecuting itself in the background:
>>
>>   >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
>>   >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
>>
>> diff -ru lm_sensors-3.1.2-1/usr/sbin/fancontrol
>> lm_sensors-3.1.2-1_pyropeter/usr/sbin/fancontrol
>> --- lm_sensors-3.1.2-1/usr/sbin/fancontrol    2010-02-03
>> 03:45:15.000000000 +0100
>> +++ lm_sensors-3.1.2-1_pyropeter/usr/sbin/fancontrol    2010-03-07
>> 01:37:09.000000000 +0100
>> @@ -5,7 +5,9 @@
>>    #
>>    # Version 0.70
>>    #
>> -# Usage: fancontrol [CONFIGFILE]
>> +# Usage: fancontrol [-D] [CONFIGFILE]
>> +#
>> +# (-D causes fancontrol to 'fork' to the background after some tests)
>>    #
>>    # Dependencies:
>>    #   bash, egrep, sed, cut, sleep, readlink, lm_sensors :)
>> @@ -43,6 +45,12 @@
>>    #DEBUG=1
>>    MAX%5
>>
>> +DAEMON=0
>> +if [ "$1" = "-D" ]; then
>> +    DAEMON=1
>> +    shift
>> +fi
>> +
>>    declare -i pwmval
>>
>>    function LoadConfig {
>> @@ -303,7 +311,6 @@
>>        echo "File $PIDFILE exists, is fancontrol already running?"
>>        exit 1
>>    fi
>> -echo $$>  "$PIDFILE"
>>
>>    # $1 = pwm file name
>>    function pwmdisable()
>> @@ -475,6 +482,14 @@
>>        let fcvcount=$fcvcount+1
>>    done
>>
>> +if [ "$DAEMON" -gt 0 ]; then
>> +    echo "Forking..."
>> +    $0 $*&>  /dev/null&
>> +    exit 0
>> +fi
>> +
>> +echo $$>  "$PIDFILE"
>> +
>>    echo 'Starting automatic fan control...'
>>
>>    # main loop calling the main function at specified intervals
>>
>>   >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
>>   >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
>>
>> I am not subscribed to this mailing list, so you need to CC me.
>>
>>      
> This means that the checks will be done twice.
There could be a second argument that skips the tests. But I don't think 
parsing a 400B file two time is going to harm.
> And if the checks are
> somehow incomplete, fancontrol may still fail despite the fork being
> successful, so it is unreliable by design.
>
>    
What do you mean by "somehow incomplete"?
I can't imagine a case where the old behavior is more reliable than the 
one I supposed, unless there are bugs in the implementation.

(Btw. I just noticed the fork itself could break in some cases, so it 
needs an additional if-clause :-P)
> If startproc works for you, you should use it.
>
>    


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
