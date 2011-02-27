From: Luca Tettamanti <kronos.it@gmail.com>
Date: Sun, 27 Feb 2011 14:58:49 +0000
Subject: Re: [lm-sensors] dme177737: pwm not working
Message-Id: <AANLkTi=5qnWhkiK3NRkLhXoGYg55qAywmRxKUopz0SrF@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1127565282.7281701.1298492327176.JavaMail.fmail@mwmweb086>
In-Reply-To: <1127565282.7281701.1298492327176.JavaMail.fmail@mwmweb086>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Feb 26, 2011 at 3:32 PM, Juergen Bausa <Juergen.Bausa@web.de> wrote:
>>Not sure what to do about that, especially since this suggests that
>>ACPI claims access to the dme1737 registers, and parallel access may
>>cause trouble.
>
> Thanks for the tip, that helped a lot. Searching the web I found some cases, where the
> asus_atk0110 prevented other modules from working correctly. Mostly it was suggested to
> add "acpi_enforce_resources=lax" to the kernel parameters. Allthough some people say this
> may be dangerous (others said it is not) I tried it and now the pwms are there again!
>
> However, next problem was, that after each boot, hwmon1 and hwmon2 (dme1737 and
> asus_atk0110) may change. As a result, I was not able to write fixed adresses for the pwm in
> the configuration file for the fan-controller. After blacklisting the asus_atk0110 this problem was
> also solved. As I dont need any of the outputs of the asus_atk0110 I dont think this is problem.
> Most outputs are also given by the dme1737.
>
> Could anyone please comment on this? Could it be dangerous to add "acpi_enforce_resources=lax"
> to the kernel parameters? If so, what could happen? And, is there any reason to not blacklist the
> asus_atk0110 module?

Using *both* atk0110 and the native driver is almost guaranteed to
cause troubles because the two drivers will compete for access to the
same device without synchronization.
Using the native driver alone may or may not cause troubles, it really
depends on what the firmware is doing with the resources that it
claimed (and this can only be verified by inspecting ACPI code).

L

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
