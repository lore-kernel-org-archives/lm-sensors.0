From: Luca Tettamanti <kronos.it@gmail.com>
Date: Tue, 06 Dec 2011 15:21:25 +0000
Subject: Re: [lm-sensors] Kernel module asus_atk0110
Message-Id: <CAKPcRGpKwbj_HwEFOc6Ts1YR9nU2R5zGNBgaTKbjsp0+D+M7aw@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4EDA27AA.7030203@catcons.co.uk>
In-Reply-To: <4EDA27AA.7030203@catcons.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Dec 5, 2011 at 5:04 PM, Jean Delvare <khali@linux-fr.org> wrote:
> On Mon, 5 Dec 2011 16:28:19 +0100, Luca Tettamanti wrote:
[cut]
>> Anyway, the board does not expose a monitoring framework :-(
>
> But it exposes a register map (HWRE)... Might this be used to access
> the hardware monitoring chip without interfering with ACPI?

Not directly: other boards had read/write methods with byte
granularity that could be exploited to jury rig a native driver to
access the hardware via ACPI. In this case there are no such methods,
the only option that I see would be injecting new methods into the
DSDT and use those; it can be done but it's a bit... distasteful ;-)
And fragile.
I wonder that ASUS does under Windows...

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
