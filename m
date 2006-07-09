From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Sun, 09 Jul 2006 19:30:54 +0000
Subject: [lm-sensors] it87 driver supports ITE8716 chip on new AM2 boards
Message-Id: <44B1596E.6090804@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060705202045.GA15892@debamd64>
In-Reply-To: <20060705202045.GA15892@debamd64>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Mike,

Please always CC to the list.

> Do you want to scan the ISA bus? (YES/no)
> .........................
> Probing for 	TE IT8712F'
>   Trying address 0x0290... Failed!
> Probing for 	TE IT8716F'
>   Trying address 0x0290... Failed!
> ..........................
> 

Hmmm I did something wrong perhaps?


> Do you want to scan for Super I/O sensors? (YES/no): 
> .........................
> Probing for 	TE 8702F Super IO Sensors'
>   Failed! (0x8716)
> Probing for 	TE 8705F Super IO Sensors'
>   Failed! (0x8716)
> Probing for 	TE 8712F Super IO Sensors'
>   Failed! (0x8716)
> Probing for 	TE IT8716F Super IO Sensors'
>   Success... found at address 0x0290

This works.

Ok so only one problem left in sub ite_isa_detect

Please can you take a look to that routine and find out which return it takes?
(I don't know much perl but I guess you will be able to hack  out some "printf"
there)

moreover please can you provide me a dump of
isadump -f 0x290

Maybe there is some problem with the initial detection.

Thanks,
Regards
Rudolf

