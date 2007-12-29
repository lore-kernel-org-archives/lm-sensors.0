From: Rudolf Marek <r.marek@assembler.cz>
Date: Sat, 29 Dec 2007 20:16:39 +0000
Subject: Re: [lm-sensors] PWM control on Asus P4C800-E Delux dosen't work
Message-Id: <4776AB27.3030907@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <BAY143-W26588A0C37D226CBFA5FECB9560@phx.gbl>
In-Reply-To: <BAY143-W26588A0C37D226CBFA5FECB9560@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

If there is no correlation found, you may try chaning the base PWM frequency. I 
dont recall if the driver supports it (imho w83627th F ?)

But if it is not "deluxe" board, Asus will ommit the PWM transitor and few other 
components. Yes they did it to me too - suckers. I have build my own regulator 
with some linear voltage regulator.

I'm leaving for a holiday so perhaps someone else will answer ;)

Rudolf


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
