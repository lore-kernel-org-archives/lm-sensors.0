From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 06 Oct 2013 19:47:35 +0000
Subject: Re: [lm-sensors] [PATCH] man pages for eepro* tools & fixing missing i2cset switch
Message-Id: <20131006214735.4020fe0c@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <2130321044.1321494.1380882265184.JavaMail.root@redhat.com>
In-Reply-To: <2130321044.1321494.1380882265184.JavaMail.root@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jaromir,

On Fri, 4 Oct 2013 06:24:25 -0400 (EDT), Jaromir Capik wrote:
> Something tells me I've already submitted this patch,
> but as I'm unsure, it's better to send it twice rather
> than completely omit it.

Yes you did, but it was overlooked, so you did the right thing
resending it.

> Please, check/modify/merge.

This should really have been two patches. Besides, I'm not too happy
with the i2cset man page fix. It's not bad per se but I would prefer to
keep the help text consistent amongst i2c tools. So I've only added the
missing flag for now [1]. If you want to make the help text more
verbose then please send a separate patch doing it for all i2c tools
(i2cdump, i2cdetect, i2cget and i2cset.)

[1] http://www.lm-sensors.org/changeset/6201

The man pages for eeprom, eepromer and eeprog look overall good, but I
would like to mention two things.

Firstly, in the long run, I really would like to get rid of two of
these tools and keep only one. They serve the same purpose, only the
EEPROM chips supported and the way to access them is different.

Secondly, I am really not sure in which category the man pages belong.
"System Administration" seems wrong to me, as the most common use case
for these tools is to flash an EEPROM temporarily connected to the
system (typically over the parallel bus or USB) for it to then be used
on a different system. It's somewhat similar to a cross-compiler, so
it's more about development than system administration. Sure, these
tools can only be used by root, but it is really only because handling
permissions on /dev/i2c* nodes is not so easy.

As a consequence, I don't know if these tools should go to /usr/sbin
(because in practice only root can use them) or in /usr/bin (because
they are not system administration tools proper.) Likewise, I don't
know if they should go to man page section 1 (General commands), or 8
(System administration commands.) Opinion anyone?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
