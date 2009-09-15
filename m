From: Luca Tettamanti <kronos.it@gmail.com>
Date: Tue, 15 Sep 2009 18:46:51 +0000
Subject: Re: [lm-sensors] Asus ATK0110 ACPI driver and Asus P6T Deluxe
Message-Id: <68676e00909151146o5c387c89o789d2dd553ca2c40@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200903101417.01449.clive@vacuumtube.org.uk>
In-Reply-To: <200903101417.01449.clive@vacuumtube.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Sep 15, 2009 at 8:11 PM, Tim Ryan <tryan@linux.com> wrote:
> Should this driver work on the ASUS P6T SE?

Well, a tester confirmed that it works on the P6T Deluxe. To give a
definite answer I must take a look at the DSDT of your board.

> I load the module with no problem,

Look at the output of dmesg; the driver is verbose when loading.

> but sunning sensors only shows the output from
> coretemp-isa-0000, all the cores. When I load the w83627ehf module
> sensors reports all the temps, voltages and fans, but I have to use
> acpi_enforce_resources=lax because of conflicts. I'd prefer the Asus
> ATK0110 if I can get it to work.

Send me a copy of your DSDT:

cat /sys/firmware/acpi/tables/DSDT | bzip2 > /tmp/dsdt.bz2

or - for older kernels:
cat /proc/acpi/dsdt | bzip2 > /tmp/dsdt.bz2

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
