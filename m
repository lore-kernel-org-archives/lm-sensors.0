From: delvare@ensicaen.ismra.fr (Jean Delvare)
Date: Thu, 19 May 2005 06:23:53 +0000
Subject: IBM Thinkpad issue
Message-Id: <20030415165435.6784164a.delvare@ensicaen.ismra.fr>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030414205658.2451ac9a.delvare@ensicaen.ismra.fr>
In-Reply-To: <20030414205658.2451ac9a.delvare@ensicaen.ismra.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I think you should mention that the issue persists in lmsensors-2.7,
> the readme only ever talks of 2.6.5.

Our docs say "2.6.5 and later releases", which means... well, just what
it says.

> Maybe incorporate the hint about ACPI as well?

Added.

> Also I would refer to the README.thinkpad in the FAQ, which was the
> first place I searched.

Done.

> > How could you write to me at this address whereas the webpage
> > mentioned above specifies another one?
> 
> I am not sure anymore, I think I picked it out of the source
> distribution's file. Sorry if I picked up a wrong email adress by
> mistake, it was not intentional.

Actually, I'd like to know. Not that I am offended or whatever, but I
grep'd the whole sources, and google'd the website, no reference to this
address could be found. So I really wonder...

> Unfortunately the ACPI implementation of the Thinkpads is broken as
> well, but maybe it will work at a later time. I have to try a
> development kernel.

Broken EEPROMS, broken ACPI implementations... And I though IBM was
builing the best, yet expensive, laptops on Earth.


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
