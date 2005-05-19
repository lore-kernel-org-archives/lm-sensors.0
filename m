From: obi@saftware.de (Andreas Oberritter)
Date: Thu, 19 May 2005 06:25:40 +0000
Subject: [PATCH] possible bug in i2c-algo-bit's inb function
Message-Id: <1109541347.4948.7.camel@localhost.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
References: <E1D5GN2-0000Bi-KG@localhost.localdomain>
	 <20050227103538.218fa1b0.khali@linux-fr.org>
	 <1109528034.4564.16.camel@localhost.localdomain>
	 <20050227195226.23aa5a51.khali@linux-fr.org>
In-Reply-To: <20050227195226.23aa5a51.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LM Sensors <sensors@stimpy.netroedge.com>, LKML <linux-kernel@vger.kernel.org>
Cc: Greg KH <greg@kroah.com>

On Sun, 2005-02-27 at 19:52 +0100, Jean Delvare wrote:
> > Here's my I2C code:
> > (...)
> 
> Looks sane.
> 
> > The bus master is a so called Pluto2 by SCM (part of a DVB-T card sold
> > by Satelco). If this is a hardware bug, is it possible to add a flag
> > to struct i2c_algo_bit_data to workaround this bug?
> 
> I would try to find out whether the culprit is setscl or getsda
> (assuming I am correct and either of these actually is the problem).
> Once you know which it is, you could modifiy that function to restore
> the SDA line, that should do the trick.
> 
> Hope that helps,

Thank you, using the workaround below makes it possible to use the
bitbanging code without modifications. It tries to detect i2c_inb() and
resets SDA to high after SCL has been set to high and then to low.

static void pluto_setscl(void *data, int state)
{
        struct pluto *pluto = data;

        if (state)
                pluto_rw(pluto, REG_SLCS, SLCS_SCL, SLCS_SCL);
        else
                pluto_rw(pluto, REG_SLCS, SLCS_SCL, 0);

        if ((state) && (pluto->i2cbug = 0)) {
                pluto->i2cbug = 1;
        } else {
                if ((!state) && (pluto->i2cbug = 1))
                        pluto_setsda(pluto, 1);
                pluto->i2cbug = 0;
        }
}

Regards,
Andreas
