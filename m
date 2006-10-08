From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 08 Oct 2006 13:46:43 +0000
Subject: [lm-sensors] Supermicro X6DH8-G2+ / sensors not working
Message-Id: <20061008154643.0528be4b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <451FF905.60001@hal.saar.de>
In-Reply-To: <451FF905.60001@hal.saar.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Jean Delvare wrote:
> > Given that every distribution is different, and different versions of
> > rpm support a different set of features, I fail to see the point in
> > shipping .spec files at all. They are better maintained by each
> > distribution. 
>
> That sounds logical.
>
> > So I propose that we simply delete this RPM directory
> > from both our i2c and lm-sensors trees. Objections anyone?
> 
> maybe you can keep it somehow as a contrib element, I think that adds
> quite some value to every tar ball. :)

Well, is is already kept as a contrib element. But I fail to see the
added value as it is not maintained and certainly won't work with any
recent distribution. Yourself, you finally started from the CentOS spec
file rather than ours.

My "Objections anyone?" was essentially an "Is someone volunteering to
maintain these spec files?" And if nobody shows up, the files are gone
soon.

> -----8<-----8<-----8<-----SNIP-----8<-----8<-----8<-----
> [root at matrix ~]# sensors
> pc87427-isa-0840
> Adapter: ISA adapter
> fan1:     3678 RPM  (min =  712 RPM)
> fan2:     3391 RPM  (min =  712 RPM)
> fan3:     3400 RPM  (min =  712 RPM)
> fan4:     3366 RPM  (min =  712 RPM)
> fan5:        0 RPM  (min =  712 RPM)          FAULT
> fan6:     2896 RPM  (min =  712 RPM)
> fan7:        0 RPM  (min =  712 RPM)          FAULT
> fan8:     2812 RPM  (min =  712 RPM)
> 
> -----8<-----8<-----8<-----SNIP-----8<-----8<-----8<-----

Nice! So it finally works :)

Now you can write a sensors.conf file for this board. You should be
able to find the labels by comparing with what the BIOS is displaying.
As for the low limit values, the choice is up to you. 712 RPM looks a
bit too low IMHO.

> Question: Shouldn't the libs as defined in lm_sensors Makefile go to
> something more architecture specific?
> I changed my local copy of the Makefile from the snapshot to the
> following in order to comply with rpm's strict architecture handling.
> That allowed me too build the x86_64 package.

I see what you mean. I'm surprised that all 64-bit distributions went
for "lib64" for 64-bit libraries. 32-bit distributions were using
"lib", not "lib32", so it would have been much more logical (IMHO) to
keep "lib" for the native libraries, and to use "lib32" for the 32-bit
compatibility ones. In a decade I guess everyone will have given up the
32-bit compatibility, and we'll either be stuck with a meaningless
"lib64", or we'll change it back to just "lib" and it'll be a mess :(

Anyway, things are what they are today, so we should probably do what
you propose and install into lib64 on x86_64, to make users and
distibutions happier. I'll apply your patch to our repository unless
someone objects.

Thanks,
-- 
Jean Delvare

