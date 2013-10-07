From: Jaromir Capik <jcapik@redhat.com>
Date: Mon, 07 Oct 2013 14:49:40 +0000
Subject: Re: [lm-sensors] [PATCH] man pages for eepro* tools & fixing missing i2cset switch
Message-Id: <1450579748.2250803.1381157380670.JavaMail.root@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <2130321044.1321494.1380882265184.JavaMail.root@redhat.com>
In-Reply-To: <2130321044.1321494.1380882265184.JavaMail.root@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Hi Jaromir,

Hi Jean.


> > Please, check/modify/merge.
> 
> This should really have been two patches. Besides, I'm not too happy
> with the i2cset man page fix. It's not bad per se but I would prefer to
> keep the help text consistent amongst i2c tools. So I've only added the
> missing flag for now [1]. If you want to make the help text more
> verbose then please send a separate patch doing it for all i2c tools
> (i2cdump, i2cdetect, i2cget and i2cset.)

I didn't want to cause line wrappings on terminals with 80 characters
per line. But if you're ok with that, then I'm too.


> The man pages for eeprom, eepromer and eeprog look overall good, but I
> would like to mention two things.
> 
> Firstly, in the long run, I really would like to get rid of two of
> these tools and keep only one. They serve the same purpose, only the
> EEPROM chips supported and the way to access them is different.

I'm perfectly ok with that. I had to create the man pages to make
our products sane and even if the live expectations of the man pages
are short, I consider it a good idea to merge them upstream for someone
who decides to build the current version in the future (for whatever reason).


> Secondly, I am really not sure in which category the man pages belong.
> "System Administration" seems wrong to me, as the most common use case
> for these tools is to flash an EEPROM temporarily connected to the
> system (typically over the parallel bus or USB) for it to then be used
> on a different system. It's somewhat similar to a cross-compiler, so
> it's more about development than system administration. Sure, these
> tools can only be used by root, but it is really only because handling
> permissions on /dev/i2c* nodes is not so easy.
> 
> As a consequence, I don't know if these tools should go to /usr/sbin
> (because in practice only root can use them) or in /usr/bin (because
> they are not system administration tools proper.) Likewise, I don't
> know if they should go to man page section 1 (General commands), or 8
> (System administration commands.) Opinion anyone?

Life's difficult :]
I believe users do not care about this stuff as long as there's only
one manpage per tool. The same applies to the binary location.
As long as it is reachable via the PATH variable, there's no need for
worries about the location.


> --
> Jean Delvare
 
Regards,
Jaromir.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
