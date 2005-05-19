From: hdbtroll@moment.net (DB Troll)
Date: Thu, 19 May 2005 06:23:46 +0000
Subject: 2.7.0 Error in make
Message-Id: <3E2C787B.2050606@moment.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <3E2C49C0.705@moment.net>
In-Reply-To: <3E2C49C0.705@moment.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:

>>>bison -p sensors_yy -d lib/conf-parse.y -o lib/conf-parse.c
>>>make: bison: Command not found
>>>make: *** [lib/conf-parse.c] Error 127
>>>      
>>>
>
>You need to install bison. It is packaged for most (if not all)
>distributions. On some distributions, you have to look for yacc instead.
>Just find a package that provides bison, as a binary or as a symbolic
>link to yacc, and you're done.
>
>  
>
Jean,
Ignore last msg I found flex and installed but still come up with an error

> lib/libsensors.so: undefined reference to `sensors_yylex'
> lib/libsensors.so: undefined reference to `sensors_yyin'
> lib/libsensors.so: undefined reference to `sensors_lex_error'
> lib/libsensors.so: undefined reference to `sensors_yylineno'
> collect2: ld returned 1 exit status
> make: *** [prog/sensors/sensors] Error 1
> linux:/home/dbtrol/lm_sensors-2.7.0 #David

David

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 252 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20030120/bb795e5f/attachment.bin
