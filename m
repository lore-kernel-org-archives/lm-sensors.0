From: "Andrew Paprocki" <andrew@ishiboo.com>
Date: Sat, 05 Apr 2008 06:03:42 +0000
Subject: Re: [lm-sensors] Anyone know the SuperI/O found in Dell XPS m1530
Message-Id: <76366b180804042303m351f7b4fu767db8c0e5400e6a@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <76366b180804041813o76abd53bi2c561d0e0eb4d890@mail.gmail.com>
In-Reply-To: <76366b180804041813o76abd53bi2c561d0e0eb4d890@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Nope, there is nothing on the PCI bus. I've been trying to track down
what chip has a ID of 0xfc, but I haven't had any luck. It seems like
it would be similar to the pc87427, which has an ID of 0xf2, given
that all the IDs in the pc87360 driver are all close together. That is
just speculation, though.

-Andrew

On Sat, Apr 5, 2008 at 1:49 AM, Matt Roberds <mattroberds@cox.net> wrote:
> On Fri, 4 Apr 2008, Andrew Paprocki wrote:
>
> > Running sensors-detect finds an unknown National Semiconductor chip
> > with ID 0xfc11 at 0x4e. I haven't been able to find any info on what
> > kind of chip this is by looking through datasheets.
> >
>
>  If you haven't already, you might try running 'lspci -v' (list PCI
>  devices) as root, and looking at the output of dmesg fairly soon after
>  booting (kernel messages), to see if there are any clues.  If either
>  source mentions "National Semiconductor", "NatSemi", "National", or
>  "LMnnnn", that may be a reference to the chip of interest.
>
>  Matt Roberds
>
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
