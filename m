From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:38 +0000
Subject: adt7463 on asus w1n laptop
Message-Id: <20050220110259.723f883b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200502141545.03330.christophe.dr@free.fr>
In-Reply-To: <200502141545.03330.christophe.dr@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Philip,

> > Device revision 0x6A. ADM1027 is documented as 0x60+, ADT7463 is
> > documented as 0x62+, so I would indeed agree that it must be an
> > ADT7463. Our driver needs to be updated.
>
> Where do you see that in the datasheet?
> 
> The way I read this datasheet:
> 
> http://www.analog.com/UploadedFiles/Data_Sheets/272624927ADT7463_c.pdf
> 
> It says that the only valid values for the REVISION register are 0x62 
> and 0x6A.  (see Table IV on page 32)  It doesn't say that any value 
> larger than 0x62 is an ADT7463.

My conclusion was based on the revision B of the datasheet (thanks for
the pointer to the new one). Revision B didn't mention 0x6A as possible,
only 0x62.

It is very common that datasheets will document the lowest possible
revision/stepping for a chip, leaving it up to us to decide which range
we want to accept. This is what I proposed (and committed), based on
both the ADM1027 (rev.A) and the ADT7463 (rev.B) datasheets.

> I think it might be safer to just add 0x6A as a valid ADT7463 chip. 

How exactly is it safer? I obviously don't know the LM85 and compatibles
family as good as you do, but I don't see what risk we have here. The
worst that could happen would be that we think the chip has feature it
doesn't actually have, right? These features will just not work, and
users will report about it.

And even that is unlikely, IMHO. I think I understand that the ADT7463
has more features than the ADM1027 had, and higher stepping numbers. A
newer chip in that family would certainly follow the same rules: higher
stepping number, additional features. My code admittedly assumes that.

The problem with your method is that it requires a change to the driver
with every new chip revision. With mine we only have to change the code
if the new chip revision has new features. In the meantime the driver
will provide as many features as possible, while with your approach it
will feature the minimal subset.

As a matter of fact, with my code, Christophe's chip would have been
properly detected. With yours it required a driver update.

So unless there is a real risk I am missing, I do believe that the
change I made is an improvement.

Thanks,
-- 
Jean Delvare
