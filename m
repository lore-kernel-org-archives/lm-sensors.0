From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 16 Oct 2013 15:05:42 +0000
Subject: Re: [lm-sensors] [PATCH] man pages for eepro* tools & fixing missing i2cset switch
Message-Id: <20131016170542.1baef7cf@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <2130321044.1321494.1380882265184.JavaMail.root@redhat.com>
In-Reply-To: <2130321044.1321494.1380882265184.JavaMail.root@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 7 Oct 2013 10:49:40 -0400 (EDT), Jaromir Capik wrote:
> > Secondly, I am really not sure in which category the man pages belong.
> > "System Administration" seems wrong to me, as the most common use case
> > for these tools is to flash an EEPROM temporarily connected to the
> > system (typically over the parallel bus or USB) for it to then be used
> > on a different system. It's somewhat similar to a cross-compiler, so
> > it's more about development than system administration. Sure, these
> > tools can only be used by root, but it is really only because handling
> > permissions on /dev/i2c* nodes is not so easy.
> > 
> > As a consequence, I don't know if these tools should go to /usr/sbin
> > (because in practice only root can use them) or in /usr/bin (because
> > they are not system administration tools proper.) Likewise, I don't
> > know if they should go to man page section 1 (General commands), or 8
> > (System administration commands.) Opinion anyone?
> 
> Life's difficult :]
> I believe users do not care about this stuff as long as there's only
> one manpage per tool. The same applies to the binary location.
> As long as it is reachable via the PATH variable, there's no need for
> worries about the location.

Short of a better idea, I left the category name and number as they
were in the patch you provided. Which I just applied with minor edits
BTW:
http://www.lm-sensors.org/changeset/6204

Thanks for your contribution!

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
