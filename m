From: lists@localguru.de (Marcus Schopen)
Date: Thu, 19 May 2005 06:25:08 +0000
Subject: i2c-piix4 problem
Message-Id: <200408050306.11594.lists@localguru.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <200408041637.21472.lists@localguru.de>
In-Reply-To: <200408041637.21472.lists@localguru.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wednesday 04 August 2004 18:22, Jean Delvare wrote:
> > I've problem to get values for my "82371AB PIIX4 ACPI (rev 01)". Could
> > anyone send me a working sensors.conf? I get just parse errors or "No
> > sensors found!".
> >
> > The following kernel modules are loaded:
> >
> > # lsmod:
> > Module                  Size  Used by    Tainted: P
> > i2c-proc                6272   0
> > i2c-dev                 3680   0
> > i2c-piix4               3908   0
> > i2c-core               12160   0  [i2c-proc i2c-dev i2c-piix4]
>
> i2c-piix4 is a bus driver. You need an additional chip driver to get
> temperature readings. Try "sensors-detect" to find out which one you
> need.

That's what sensors-detect found out / loaded.

Cheers,
Marcus
