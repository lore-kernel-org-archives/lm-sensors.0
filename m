From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 06 Jan 2011 21:01:35 +0000
Subject: Re: [lm-sensors] Erratic value of MCH temp. (0C),
Message-Id: <20110106220135.5a38468c@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1294052867.1860.36.camel@Asus5>
In-Reply-To: <1294052867.1860.36.camel@Asus5>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Luca,

On Wed, 5 Jan 2011 15:08:44 +0100, Luca Tettamanti wrote:
> On Wed, Jan 5, 2011 at 2:45 PM, Joris Creyghton <jorisctn@gmail.com> wrote:
> > The MCH temp. is always 0 en never jumps.
> >
> > Attached you'll find the file /sys/firmware/acpi/tables/DSDT
> 
> Hum, it appears to be a bug in the ACPI code, the method that reads
> the temperature does not know how to read the MCH temperature which
> would be HWT2 (the entry is present in the enumeration though):
> 
> Method (TGET, 1, NotSerialized)
> {
>     If (LEqual (Arg0, Zero))
>     {
>         Return (^^SIOR.HWT1 ())
>     }
> 
>     If (LEqual (Arg0, One))
>     {
>         Return (^^SIOR.HWT0 ())
>     }
> }
> 
> To complicate things the firmware provides both the old and the new
> ATK0110 interfaces, and the driver selects the old one. The new one
> seems to have the code to read all the sensors. I'll see what I can
> do.

Would it make sense to add a module parameter to asus_atk0110 to let
the user force the interface when both are present? So that the user
can test the other one and report easily.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
