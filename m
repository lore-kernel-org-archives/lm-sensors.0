From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 17 Feb 2014 23:17:09 +0000
Subject: Re: [lm-sensors] sensors command now hangs [update 2]
Message-Id: <53029875.5040907@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <53027C66.60608@gmail.com>
In-Reply-To: <53027C66.60608@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 02/17/2014 01:17 PM, David Anderson wrote:
> Well, even without ipmi sensors hangs up
> at (hand typing this) after just 6 hours:
>
> ...
> w83795adg-i2c-0-27
> Adapter: SMBus I801 at 0400
>
>
>
> Google search shows someone using redhat has a hanging
> sensors command too :
>
> https://bugzilla.redhat.com/show_bug.cgi?id51274
>
> Note there the apparent workaround of nouveau.runrpm=0
> on the kernel command line.
> I'm using Nvidia driver  319.60 for the GTX 760
>

Hi David,

That looks like a different problem, though, unless you
access the nouveau sensor after all. Is it instantiated
in your system ?

To be sure to exclude this, you could try the command line
workaround. Note, though, that it is nouveau.runpm,
not nouveau.runrpm.

Overall I am quite puzzled, as you mentioned earlier that
you also see the hang with the w83627hf driver loaded.
I can not really imagine why (and how) either of those
drivers can end up in a 'hang' condition.

I think I already asked this - in your original e-mail,
you mentioned that the sensors command 'now hangs', and that
only started happening some time ago. What did you change -
if anything - in your system before this started to happen ?

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
