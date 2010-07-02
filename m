From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 02 Jul 2010 09:57:34 +0000
Subject: Re: [lm-sensors] Add an ADC with I2C interface on ARM
Message-Id: <20100702115734.3f4faf81@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <SNT129-W61DE5562B64ECD434E5D25B9CE0@phx.gbl>
In-Reply-To: <SNT129-W61DE5562B64ECD434E5D25B9CE0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Salut Tony,

On Fri, 2 Jul 2010 11:39:49 +0200, Tony Mozi wrote:
> Hi all,
> I try to enable the communication between an ADC (ADS7823) and a board with an ARM chip.
> 
> In /dev, I have i2c-0,... i2c-3. So, I suppose that it is not necessary to add another.

To add another what?

> The board has already an internal ADC and I communicate with it without problem.
> When I start my program, there is no activity on SCL and SDA.
> I use a loop when I write on the I2C bus but I see nothing.
> Regarding the electronic part, it's ok, supply enables.
> Have you got ideas?

It's fundamentally an I2C question, so off-topic on this list. Try the
linux-i2c list and you'll stand a better chance to get a useful reply.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
