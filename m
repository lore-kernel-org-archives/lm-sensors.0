From: Matt Roberds <mattroberds@cox.net>
Date: Sat, 05 Apr 2008 05:49:53 +0000
Subject: Re: [lm-sensors] Anyone know the SuperI/O found in Dell XPS m1530
Message-Id: <Pine.LNX.4.64.0804050046480.20664@birdbird.example.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <76366b180804041813o76abd53bi2c561d0e0eb4d890@mail.gmail.com>
In-Reply-To: <76366b180804041813o76abd53bi2c561d0e0eb4d890@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 4 Apr 2008, Andrew Paprocki wrote:
> Running sensors-detect finds an unknown National Semiconductor chip
> with ID 0xfc11 at 0x4e. I haven't been able to find any info on what
> kind of chip this is by looking through datasheets.

If you haven't already, you might try running 'lspci -v' (list PCI
devices) as root, and looking at the output of dmesg fairly soon after
booting (kernel messages), to see if there are any clues.  If either
source mentions "National Semiconductor", "NatSemi", "National", or
"LMnnnn", that may be a reference to the chip of interest.

Matt Roberds


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
