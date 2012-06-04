From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 04 Jun 2012 16:53:09 +0000
Subject: Re: [lm-sensors] Mini ITX fully compatible Lm-sensors
Message-Id: <1338828789.478.174.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAKJpqGHvWrDSCz+7G5UvR2p_96gR98MpmHZ6G-kmr5-5OiMhog@mail.gmail.com>
In-Reply-To: <CAKJpqGHvWrDSCz+7G5UvR2p_96gR98MpmHZ6G-kmr5-5OiMhog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 2012-06-04 at 02:21 -0400, clement clem wrote:
> 
> 
> 2012/6/3 Guenter Roeck <guenter.roeck@ericsson.com>
>         On Sun, Jun 03, 2012 at 04:47:54AM -0400, Jean Delvare wrote:
>         > On Sun, 3 Jun 2012 09:12:33 +0200, clement clem wrote:
>         > > The chip-Nuvoton W83677HG i totally works with Kernel
>         2.6.35.32 (Ubuntu
>         > > 10.10)?
>         >
>         > Not out of the box. See
>         http://www.lm-sensors.org/wiki/Devices :
>         > W83677HG support was added in kernel 2.6.39. That being said
>         you can
>         > always use a manually built standalone driver.
>         >
>         
>         Or use Ubuntu 12.04 instead. 10.04 is getting old, and 10.10
>         is no longer supported.
>  
> Hello to all,
>   I work on 14.10 LTS or 10.10 as the current version 14.12 with the
> Gnome Unity is not really productive.
>         
>         > Also note that the fact that the chipset is supported is not
>         a
>         > guarantee that things will work. There is always the
>         possibility that
>         > the vendor did not use the monitoring features, or not all
>         of them, or
>         > that the ACPI BIOS takes control of the chip.
>         >
>         
>         Intel doesn't use ACPI. There is a chance, though, that they
>         control
>         the fans through their own chipset and MEI. And we don't have
>         a hwmon driver
>         for MEI. The board's technical specification should tell,
>         though.
>         
>         On the plus side, the Intel boards have the Nuvoton chips well
>         programmed,
>         much better than all the others I have seen.
>  
> Ok,  For control of fan that's no big deal because my project will be
> 100% fanless.
> And at worst a single 120mm fan that will be in the low rotation, if
> the controller shows that the speed is sufficient.
> 
> So this card with the Intel chip DH61DL Nuvoton W83677HG seems good
> for my project.
> 
> The ASRock B75M-ITX also has potential ...
> 
>         
>         > > Do you have information on the chip card mini ITX:
>         > >   ASRock B75M-ITX
>         
>         
>         This one may use ACPI, and also use the GPIO based fan
>         multiplexer.
>  
>  Which chip manufacturer has been installed on this card AsRock ?
> I find anything on the web.
> 
Most likely the same as on the B75 Pro 3 M you had earlier, ie NCT6776F.

Guenter

>         
>         > >   MSI E35-H61I
>         > > Gigabyte GA-H61N
>         >
>         > No we don't.
>         >
>         > > These smart you are monitoring it completely taken over by
>         Lm-Sensors certain
>         > > person we make test?
>         >
>         > I don't understand your question, sorry.
>         >
>         
>         Me not either.
>         
> I ask if any member of the list, use the Mini ITX with Lm-Sensors, if
> so what model ?
> 
> Thank
> Clem



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
