From: Luca Tettamanti <kronos.it@gmail.com>
Date: Wed, 06 Jul 2011 08:45:56 +0000
Subject: Re: [lm-sensors] Where are all the sensors?
Message-Id: <CAKPcRGpX5vdTN=sEcCG=XDDUUhpUHvE3Zw=bSDv-v+vjVzTANA@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4E0B52A6.1070402@yahoo.co.uk>
In-Reply-To: <4E0B52A6.1070402@yahoo.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Jul 5, 2011 at 10:54 PM, DB <Freddog_de@yahoo.co.uk> wrote:
> I tried cat /sys/firmware/acpi/tables/DSDT & got a lot of characters all
> over the page, nothing really readable....

Yes, it's a binary file ;)
Create a copy, e.g:
cp /sys/firmware/acpi/tables/DSDT /tmp/DSDT
and attach the file.

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
