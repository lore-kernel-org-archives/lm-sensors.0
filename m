From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Wed, 06 Jun 2007 07:14:26 +0000
Subject: Re: [lm-sensors] Fintek F71882 on MSI mainboard
Message-Id: <46665ED2.1030402@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <18021.51591.422191.587646@gate.local.mgri>
In-Reply-To: <18021.51591.422191.587646@gate.local.mgri>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

patric wrote:
> Hi,
> 
> 
> Well, just about for the different driver.. But i was more thinking
> about something like this in the sensors.conf..
> 
> 
> IF MB "ASUS M2N" "ASUS M2N-E" "ASUS M2N-SLI"
> 
>     "it8716-*"
> 
>         label fan1 "CPUFan"
> 
>         label temp1 "CPUTemp"
> 
>    
> 
>     "adt7463-*"
> 
>        label fan2 "Chassi fan"
> 
>        label temp2 "Some temp"
> 
> FI
> 
>    
> 
> and then at the end of the sensors.conf have the defaults for mainboards
> that follow the rules..... That would make it possible to have simple
> exceptions for lots of mainboards without messing up the defaults in the
> config.
> 
> And yes, i know that you can specify addresses and stuff for the
> different sensors, but i don't think anyone can keep a track of all
> sensors in the config, and with all the mainboards with exceptions i
> think this might be a good route to take.. And it will not require any
> changes to the current config, only enable it to be expanded with
> exceptions per MB type..
> 
> 
> Currently involved in another project so don't know if i'll find the
> time to get anything working on this, but just thought i post a reply on
> a idea i got when i read the first mail...
> 
> 
> And yet again... This is only brainstorming... Don't take anything
> literary. =)
> 

Please read the proposal and design documents on the work already in progress 
on this. Mind dumps like this are anything but usefull atm, since work is 
already well underway, and many decisions on howto handle this have already 
been made, constructive feedback on the wip is very much welcome.

Regards,

Hans (de Goede)


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
