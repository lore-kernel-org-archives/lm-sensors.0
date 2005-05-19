From: alex@alexdalton.org (Alexandre d'Alton)
Date: Thu, 19 May 2005 06:24:53 +0000
Subject: ADM1030 Driver
Message-Id: <1082406507.656.20.camel@megapc>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040319224106.79f6cec3.cedric.pradalier@inrialpes.fr>
In-Reply-To: <20040319224106.79f6cec3.cedric.pradalier@inrialpes.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 2004-04-19 at 22:04, Jean Delvare wrote:
> > > > Bit 0 of conf register 2 enables the pwm output, I think that if
> > > > the bit iscleared, the fan will never rotate. Even if in automatic
> > > > mode. But it is not verified yet...
> > > 
> > > Please try and tell me.
> > 
> > Clearing that bit disables PWM output, so the fan doesn't run at all!
> 
> Then you don't want to allow the user to do it. At all.

Off course !

Concerning the auto fan mode, I think that the interface:

auto_temp_off
auto_temp_min
auto_temp_max

is clear, so I'm going to implement that.

Concerning the channel configuration, as

adm1030 can select:
	- ext temp for regulation 
	- max of the 2 channels

adm1031 can select:
	- ext temp1 for fan1, ext temp2 for fan2
	- ext temp1 for fan1 and fan2 
	- ext temp2 for fan1 and fan2 
	- max of 3 channels for fan1 and fan2

it is pretty hard to create a standard interface, so what I suggest, is
to create a file fan_auto_temp_select that would verbosely print the
values it can hold. Example for adm1030:

# cat fan_auto_temp_select
  * 0 => manual mode
    1 => temp2 controls fan1 temp3 controls fan2
    2 => temp2 controls fan1 and fan2
    3 => temp3 controls fan1 and fan2
    4 => max controls fan1 and fan2

The star shows the current config.

Do you like this approach ? Is it possible to write as many bytes in the
buffer given to the show() interface ? Or do you have another idea ?

Alex.

