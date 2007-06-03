From: "Phil Endecott" <spam_from_lm_sensors@chezphil.org>
Date: Sun, 03 Jun 2007 20:48:29 +0000
Subject: Re: [lm-sensors] Jetway J7F2 with f71805: PWM not working
Message-Id: <1180903709340@dmwebmail.belize.chezphil.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1180813726137@dmwebmail.belize.chezphil.org>
In-Reply-To: <1180813726137@dmwebmail.belize.chezphil.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Dear All,

My home-made fan driver circuit seems to be working.  Let me know if 
you are interested and I will describe the circuit; it's just an NMOS 
FET and a PNP transistor, as suggested in the Fintek datasheet.

However, the fan tacho input is not correctly measured at low PWM 
values / voltages / speeds.  I believe that this is because the signal 
on the wire from the fan switches between ground and the fan supply 
[*].  The motherboard must have a resistor divider to get the 12V on 
this wire down to the safe input for the chip (again there is a circuit 
for this in the datasheet).  But if the (average??) fan supply voltage 
is too low, the input to the chip sees 0.  Or, the tacho signal is 
modulated by the PWM signal.

I presume that this is a standard problem.  Do other motherboards that 
have PWM fan control have unreliable tachos at low speed, or do they 
have extra components between the fan's tacho wire and the chip to deal 
with this?  Maybe it depends on the PWM frequency?

Google finds an Analogue Devices chip 
(http://www.analog.com/library/analogdialogue/archives/38-02/fan_speed.html) 
where they describe this problem, and suggest that when you want to 
take a tacho reading you should briefly set the PWM output to 100%.  
Presumably this would have to be done within the chip for the 
tacho-tracking automatic mode to work, though it could also be 
implemented by the O.S. for other control mechanisms.

[*] Why they have done it like that I cannot imagine.  It would have 
been much simpler to have the switch in the fan go from ground to 
open-circuit, and to have whatever pullup resistor to whatever voltage 
you need on the motherboard.....


Regards,

Phil.





_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
