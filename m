From: Doru Petrescu <pdoru@evox.ro>
Date: Mon, 26 Apr 2010 14:27:53 +0000
Subject: Re: [lm-sensors] asus_atk0110 not detecting anything on P5LD2EB-DHS
Message-Id: <1272292073.21942.607.camel@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <k2r68676e01004260718y3c0c397bpcf1892a7ae30b9f5@mail.gmail.com>
In-Reply-To: <k2r68676e01004260718y3c0c397bpcf1892a7ae30b9f5@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

atk0110 doesn't add anything in /sys/class/hwmon
the only thing there (hwmon0) is provided by eeepc_laptop module.

I will try a newer kernel.

thx
D>



On Mon, 2010-04-26 at 17:18, Luca Tettamanti wrote:
> Please keep the list in CC
> 
> On Sun, Apr 25, 2010 at 11:33 PM, Doru Petrescu <pdoru@evox.ro> wrote:
> > I have an ASSUS EEE PC (mini desktop) B202, dmidecode say "P5LD2EB-DHS"
> > for motherboard. it used to work with w83627ehf.
> 
> CPI: I/O resource w83627ehf [0x295-0x296] conflicts with ACPI region
> HWRE [0x290-0x299]
> ACPI: If an ACPI driver is available for this device, you should use
> it instead of the native driver
> 
> This is expected.
> 
> > now I tried asus_atk0110 and it doesn't detect anything, it doesn't
> > complain of anything. completly silent.
> 
> The driver used to be silent if everything went well (and debug was disabled).
> Is there anything under /sys/class/hwmon?
> 
> > i'm sending you the DSDT tables and dmidecode. maybe you can figure it
> > out.
> 
> The interface is there; you should try a newer kernel: I've fixed a
> few detection bugs since .31.
> If possible enable HWMON_DEBUG_CHIP
> 
> Luca


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
