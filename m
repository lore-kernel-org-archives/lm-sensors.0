From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 22 Nov 2009 16:35:51 +0000
Subject: Re: [lm-sensors] pwmconfig can only control fan speed at beginning
Message-Id: <20091122173551.2212c320@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <39eba8470911210719l17f35e2eoeda973ab0724130b@mail.gmail.com>
In-Reply-To: <39eba8470911210719l17f35e2eoeda973ab0724130b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 22 Nov 2009 08:05:07 -0800, Allen Edwards wrote:
> I thought I had the latest version having just done apt-get install so
> I didn't think of this but I should have.
> 
> I now have version 3.1.1 unzipped but can't install it.  I get an
> ERROR 1 exit on make.  See below.
> 
> dad@myth_desktop:~/lm_sensors-3.1.1$ sudo make all
> gcc -Wl,-rpath,/usr/local/lib -o prog/sensors/sensors
> prog/sensors/main.ro prog/sensors/chips.ro  -Llib -lsensors
> lib/libsensors.so: undefined reference to `sensors_yylex'
> lib/libsensors.so: undefined reference to `sensors_lex_error'
> lib/libsensors.so: undefined reference to `sensors_yylineno'
> lib/libsensors.so: undefined reference to `sensors_scanner_exit'
> lib/libsensors.so: undefined reference to `sensors_scanner_init'
> lib/libsensors.so: undefined reference to `sensors_yyfilename'
> collect2: ld returned 1 exit status
> make: *** [prog/sensors/sensors] Error 1
> 
> 
> Not sure what I did wrong...

You forgot to install flex and bison, and our build system isn't
exactly user-friendly. After you do, run "make clean" then "make" again.

That being said... pwmconfig is a shell script, it doesn't need to be
built.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
