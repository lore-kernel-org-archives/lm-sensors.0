From: morris@wolfman.com (Jim Morris)
Date: Thu, 19 May 2005 06:24:02 +0000
Subject: lm_sensors2/prog/detect sensors-detect
Message-Id: <200306271346.19491.morris@wolfman.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20021107235845.0037e195.khali@linux-fr.org>
In-Reply-To: <20021107235845.0037e195.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Friday 27 June 2003 12:40 am, you wrote:
>
> I guess there were similar errors (Malformed UTF-8 character) for some
> other chipsets?
>

yes for instance...

Probing for `IPMI BMC KCS'
  Trying address 0x0ca0...
Called inb with port235
After sysseek
After sysread, nrchars=1
Malformed UTF-8 character (unexpected non-continuation byte 0xff, immediately 
after start byte 0xff) in ord at sensors-detect2.pl line 1358.
Read value with ord=0
Returning res%5
Failed!

> Anyway, I'm stumped. I was expecting your system to return UTF-8 chars
> from /dev/ports, and it doesn't seem so (or why would perl say they are
> malformed?) And if it returns regular chars, why are the values
> different from the ones obtained with a non-UTF-8 locale?  I just don't
> understand.

This could be a bug in Perl and their partial UTF8 hack

>
> So from here I only see two possibilities:
>
> 1* Opening /dev/ports in binary mode solves the problem (which I doubt,
> since traditionally, Unix systems don't differenciate text and binary
> modes). Please grab the modified script that does this and tell me if it
> works:
>   http://www.ensicaen.ismra.fr/~delvare/sensors-detect-k3

With UTF8......
Probing for `ITE IT8705F / IT8712F / SiS 950'
  Trying address 0x0290...
Called inb with porte7
After sysseek
After sysread, nrchars=1
Malformed UTF-8 character (unexpected continuation byte 0x90, with no 
preceding start byte) in ord at sensors-detect-k3 line 1358.
Read value with ord=0
Returning res4

Called inb with porte8
After sysseek
After sysread, nrchars=1
Malformed UTF-8 character (unexpected continuation byte 0x90, with no 
preceding start byte) in ord at sensors-detect-k3 line 1358.
Read value with ord=0
Returning res4

Called inb with porte9
After sysseek
After sysread, nrchars=1
Malformed UTF-8 character (unexpected continuation byte 0x90, with no 
preceding start byte) in ord at sensors-detect-k3 line 1358.
Read value with ord=0
Returning res4

Called inb with portf3
After sysseek
After sysread, nrchars=1
Malformed UTF-8 character (unexpected continuation byte 0x90, with no 
preceding start byte) in ord at sensors-detect-k3 line 1358.
Read value with ord=0
Returning res4

Called inb with portf1
After sysseek
After sysread, nrchars=1
Read value with ord52
Returning res!6

Called inb with portf1
After sysseek
After sysread, nrchars=1
Read value with ordf
Returning resf
Failed!
Probing for `IPMI BMC KCS'
  Trying address 0x0ca0...
Called inb with port235
After sysseek
After sysread, nrchars=1
Malformed UTF-8 character (unexpected non-continuation byte 0xff, immediately 
after start byte 0xff) in ord at sensors-detect-k3 line 1358.
Read value with ord=0
Returning res%5
Failed!

================================
Without UTF8

Probing for `ITE IT8705F / IT8712F / SiS 950'
  Trying address 0x0290...
Called inb with porte7
After sysseek
After sysread, nrchars=1
Read value with ord%5
Returning res%5

Called inb with porte8
After sysseek
After sysread, nrchars=1
Read value with ord%5
Returning res%5

Called inb with porte9
After sysseek
After sysread, nrchars=1
Read value with ord%5
Returning res%5

Called inb with portf3
After sysseek
After sysread, nrchars=1
Read value with ord%5
Returning res%5

Called inb with portf1
After sysseek
After sysread, nrchars=1
Read value with ordy
Returning resy

Called inb with portf1
After sysseek
After sysread, nrchars=1
Read value with ord6
Returning res6

Called inb with portf2
After sysseek
After sysread, nrchars=1
Read value with ord
Returning res

Called inb with portf2
After sysseek
After sysread, nrchars=1
Read value with ord4
Returning res4
Success!
    (confidence 8, driver `it87')
Probing for `IPMI BMC KCS'
  Trying address 0x0ca0...
Called inb with port235
After sysseek
After sysread, nrchars=1
Read value with ord%5
Returning res%5
Failed!


-- 
Jim Morris
