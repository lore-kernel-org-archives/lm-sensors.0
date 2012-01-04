From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 04 Jan 2012 20:42:19 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] drivers/hwmon/lm80.c: fixed checkpatch
Message-Id: <1325709739.2649.19.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1325707133-21063-2-git-send-email-fransmeulenbroeks@gmail.com>
In-Reply-To: <1325707133-21063-2-git-send-email-fransmeulenbroeks@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Frans,

On Wed, 2012-01-04 at 14:58 -0500, Frans Meulenbroeks wrote:
> Fixed all checkpatch messages except
> simple_strto* -> kstr*
> This will be addressed in a separate patch
> 
> Also left one line-too-long message as it was only a
> little bit too long and would become less readable
> 
> compile-tested: no warnings or errors
> 
> Signed-off-by: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
> 
> ---
> 
> Guenter I did not remove the () in
>                  if ((i2c_smbus_read_byte_data(client, i + 0x40) != cur)
>                   || (i2c_smbus_read_byte_data(client, i + 0x80) != cur)
>                   || (i2c_smbus_read_byte_data(client, i + 0xc0) != cur))
> Don't recall if the coding style says something about it, but I know
> lots of people are not too proficient when it comes to order of
> evaluation, so I prefer to keep them especially since they do not
> hurt readability.
> 
It tends to be frowned upon in kernel code reviews.

I would not accept it in new code, but it is ok here since checkpatch
doesn't complain about it and you did not modify existing code.
checkpatch sometimes does complain, for example if you write "return
(x)", but not always.

As for people not knowing if || or != has higher precedence, I can't
help them. Better learn coding ;). There are cases where it makes sense
to keep () - sometimes even the compiler complains - but not here.
Downside with too many ( ) is that it doesn't really prevent errors - I
have seen people using lots of ( ) and still getting it wrong. In that
case the situation is even worse, since the code looks as if the (wrong)
precedence was introduced on purpose, and thus tends to get overlooked
by reviewers.

Anyway, applied.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
