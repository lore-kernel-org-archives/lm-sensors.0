From: david.c.hubbard@gmail.com (David Hubbard)
Date: Wed, 21 Mar 2007 16:55:40 +0000
Subject: [lm-sensors] SUCCESS! Re: MSI K9N4 SLI-F sensors-detect says
Message-Id: <4dfa50520703210955w7ca9d864qe353d3ce3795dd61@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4600D064.1020703@curtronics.com>
In-Reply-To: <4600D064.1020703@curtronics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Curt,

On 3/20/07, Curt Blank <Curt.Blank at curtronics.com> wrote:
> Ok, I answered my own question, yes I can backport the w83627ehf driver
> from 2.6.21 to 2.6.16.
>
> If anyone is interested I put the patches here:
>
> http://www.curtronics.com/patches/
>
> Not bad for one nights work.
>
> Below is the living proof. The chip ID reported by the W83627DHG on this
> MB was different then what the 2.6.21 w83627ehf code looked for so now
> it looks for both. There are 4 fans connected to this MB but only 3 are
> showing up, the 4th is a MSI installed fan on the Northbridge chip.
> Maybe I can't see that one, I don't know at this point. I have to
> validate the voltages also, they don't look quite right.
>
> -Curt

Good work. I am not surprised that the driver works in 2.6.16, since
it works in 2.6.17. If your voltages are slightly off, you'll just
need to edit /etc/sensors.conf and change the voltage formulas. (The
voltages are determined by resistors on the motherboard, so it's a
manufacturer and motherboard-specific decision how the voltages are
actually measured.)

David

