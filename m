From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 14 Apr 2012 20:07:48 +0000
Subject: Re: [lm-sensors] make lm-sensors 3.3.2 ERROR /usr/bin/ld.bfd.real: cannot find -liconv
Message-Id: <20120414220748.1ff6532b@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAGqf2iKA7akhpz9oP7GOkdJp7xBT67Q8ZHQjh75edcA5ZQFSBA@mail.gmail.com>
In-Reply-To: <CAGqf2iKA7akhpz9oP7GOkdJp7xBT67Q8ZHQjh75edcA5ZQFSBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Martin,

On Sat, 14 Apr 2012 20:09:22 +0100, Martin Suchanek wrote:
> When I tried to compile lm-sensors from source code I have got by make
> commad error:
> 
> /usr/bin/ld.bfd.real: cannot find -liconv
> collect2: ld returned 1 exit status
> make: *** [prog/sensors/sensors] Error 1
> 
> 
> Could you please help me to solve this problem. (I have compiled it half
> year ago without problem)

What system are you building on? Are you building for the local host or
for a different system?

The makefile is supposed to figure out automatically if -liconv must be
passed or not. In your case it thinks it should be passed but your
linker disagrees.

What does the following command return?

$ /sbin/ldconfig -p | grep libiconv\\.so

Do you have any package named libiconv installed? If not, does any
installed package include libiconv.so, and if yes, where is it located?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
