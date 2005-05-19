From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:02 +0000
Subject: lm_sensors2/prog/detect sensors-detect
Message-Id: <20030625144538.4ba2d656.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20021107235845.0037e195.khali@linux-fr.org>
In-Reply-To: <20021107235845.0037e195.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Sorry for the delay, I got busy with some other work...

Same here as you can see.

> Ok they are different I attach both files... but here are the juicy
> bits...
> 
> With UTF on..
> Probing for `ITE IT8705F / IT8712F / SiS 950'
>   Trying address 0x0290...
> ite_isa_detect called with chip = 0 and addr = 656
> val = 144
> val = 88
> calling outb with addr = 661 and val = 167
> In the if block
> Failed!
> 
> With UTF off...
> Probing for `ITE IT8705F / IT8712F / SiS 950'
>   Trying address 0x0290...
> ite_isa_detect called with chip = 0 and addr = 656
> val = 255
> val = 79
> calling outb with addr = 661 and val = 176
> after return #1
> after return #2
> Success!
>     (confidence 8, driver `it87')

All right. I think that everyone will now agree that the problem is
*not* in outb but in *inb*.

Time to try another set of prints. Please grab the new sensors-detect
at:
  http://www.ensicaen.ismra.fr/~delvare/sensors-detect-k2
and give it a try. As usual, all the interest is to compare the output
between a UTF and a non-UTF locale.

It will probably generate more noise than the previous one did. I expect
to see that on your system, ord($X) and unpack("C", $X) give different
results (while I think both functions should return the same value in
all cases, on all systems).

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
