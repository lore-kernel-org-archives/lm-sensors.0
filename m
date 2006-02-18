From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 18 Feb 2006 18:12:37 +0000
Subject: [lm-sensors] MSI KT4V - Strange sensors output.
Message-Id: <20060218191237.7460c9f7.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <ec3d44da0602161608r43dc6653mcc94099d41e3a3e@mail.gmail.com>
In-Reply-To: <ec3d44da0602161608r43dc6653mcc94099d41e3a3e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I'll paste in what my motherboard reports for the readings with alarm status.
> 
> On 2/18/06, Jean Delvare <khali at linux-fr.org> wrote:
> > >       -5V:       -5.35 V  (min =  -5.25 V, max =  -4.75 V)       ALARM
> -5.0V:  -5.327V

Pretty much the same, so it's OK. Just use 10% tolerance when setting
limits and you're done.

> > >       V5SB:      +5.56 V  (min =  +4.76 V, max =  +5.24 V)       ALARM
> +5V SB: 5.042V

Aha, so the compute formula in sensors.conf must not be correct for
your board. That's odd since this means you would have different
resistors used for +5V and 5VSB. Or maybe the input order differs. Are
the voltage values displayed in the same order in the BIOS and by
"sensors"?

If the order is the same in BIOS and "sensors", you may try the
following compute line, which should give yo roughly the same 5VSB
value your BIOS does. Whether this matches physical reality or not, I
don't know.

    compute in7 ((5/10)+1)*@ ,  @/((5/10)+1)

-- 
Jean Delvare

