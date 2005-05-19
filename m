From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:43 +0000
Subject: [PATCH 2.6] it87 Part2(reset option)
Message-Id: <1077714758.403c9f47002b5@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040225111219.1c117787.komoriya@paken.org>
In-Reply-To: <20040225111219.1c117787.komoriya@paken.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Takeru,

> My second proposal for it87 is adding 'reset' option and do not
> reset the registers unless users really want to do. It's the same
> behavior as it87 of kernel 2.4.
> If 'smart guardian' was enabled by BIOS, resetting registers makes
> all fans go to full power, very noisy.

We have been having reports (not to say complaints) about that.

> Resetting registers is, I think, not required for normal use.

I fully agree, not only for the it87 but for all other chips too.

> +/* Reset the registers on init */
> +static int reset = 0;

Do not initialize it explicitely to 0. It's done for you (if I'm not
mistaking).

> +	if ( reset ) {

No spaces inside the parentheses please (I know that the 2.4 driver do
have spaces, I'll fix that).

>  	it87_write_value(client, IT87_REG_VIN_MIN(0),
>  			 IN_TO_REG(IT87_INIT_IN_MIN_0));

While we're at it, I'd suggest that you remove all limit
initializations. They are already gone in the 2.4 driver, and almost
all 2.6 drivers. The prefered way of setting these is from user-space
(sensors -s). Don't forget to remove the associated comment (I'll do it
in 2.4).

Also, now that the reset is optional, the rest of the init (enable all
voltages, all temperatures and all fans) should depend on it. If you do
not reset the registers, the values are supposed to be already correct.
In the 2.4 driver, these initialisations are even completely gone. We
should take a look at the datasheets. Maybe the value we are writing
are the default (post-reset) values anyway, so writing them again is
useless?

The only thing that should be kept (and has been in 2.4) is the
monitoring start, of course (with or without reset). That said, I think
that the 0xb7 mask is wrong and should be 0x36 (that too should be
verified with the datasheets).

Please provide a new version of your patch doing all this. It will of
course be a bit longer than your initial attempt.

Aligato.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
