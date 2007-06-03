From: "Phil Endecott" <spam_from_lm_sensors@chezphil.org>
Date: Sun, 03 Jun 2007 18:08:09 +0000
Subject: Re: [lm-sensors] Jetway J7F2 with f71805: PWM not working
Message-Id: <1180894089842@dmwebmail.belize.chezphil.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1180813726137@dmwebmail.belize.chezphil.org>
In-Reply-To: <1180813726137@dmwebmail.belize.chezphil.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> On Sat, 02 Jun 2007 20:48:46 +0100, Phil Endecott wrote:
>> So, has anyone else had any experience with this board?  Has PWM been 
>> known to work with other boards with this chip?  Is it common for fan 
>> connectors to not have PWM control?
>
> I have a Jetway K8M8MS motherboard with a Fintek F71805F chip, where
> pwm1 controls fan1. So I am reasonably certain that fan speed control is
> properly implemented by my f71805f driver. However, you are not the
> first one to report about being enable to control the fans using this
> driver. It seems to be common that motherboard manufacturers don't
> bother wiring things properly :(

Thanks Jean.  I have scoped the three outputs and they all seem to be 
outputting the expected PWM waveforms.  Curiously, the PWM1 pin has a 
track that goes somewhere; it's not a fan (unless I have screwed up) so 
what could it be?  I'm a bit concerned that it is used for something 
else that I'm going to break...

Anyway I have constructed a driver circuit based on the example from 
the datasheet and will be trying it out soon.  The most difficult part 
was attaching a wire to the pin; despite a reasonably fine soldering 
iron and a magnifying glass I still managed to bridge it to its 
neighbours.  I have glued the wire down to the board as strain-relief 
for my soldering, and will try it out once the glue is dry.

Regards,

Phil.





_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
