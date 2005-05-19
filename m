From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:32 +0000
Subject: adding support for new 2.6 chips in (lib)sensors
Message-Id: <3FF58EEC.9060605@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031230214411.6eb029e7.khali@linux-fr.org>
In-Reply-To: <20031230214411.6eb029e7.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Jean Delvare wrote:

> 
> A few random notes BTW:
> 
> * I think there's a typo at lib/proc.h:438.
> 

?? you mean proc.c?
I assume you fixed it, line numbers moved...


> * What's the reason for doing:
>   if(sscanf(name, "temp%d_ove%c%c", &num, &last, &check) = 2
>      && last ='r')
> instead of
>   if(sscanf(name, "temp%d_over%c", &num, &check) = 1)
> ? I understand that you want to make sure that there's nothing after
> "other" with the &check trick, but I don't see why you would also need
> the &last trick for this. Anything obvious I'm missing?
> 

In your example you can't tell if the "_over" part matched or not, can you?
I know the way I did it is retarded, I just couldn't think of a better way.
Anybody have an elegant way that works, speak up.

> * I'm seeing a strange behavior with the eeprom module for on my Vaio
> (i.e. non-memory) eeprom. Usually sensors will say "Memory type:
> Unavailable" (it's obviously not noticing this isn't a regular memory
> eeprom). But it sometimes will succeed and print the expected,
> vaio-specific data. I didn't investigate any further, but there must be
> a bug hiding somewhere.
> 

We're getting good at finding bugs in the bus drivers with eeprom.
What bus driver? Any more clues?
