From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:22 +0000
Subject: Works now (Re: my user-space work ? (3d attempt))
Message-Id: <20031022203726.7a77526c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1065896525.1059.14.camel@dell.roesel.skynet.be>
In-Reply-To: <1065896525.1059.14.camel@dell.roesel.skynet.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> There are obvious problems with what I did in that the
> temperature sensors give strange results - see below.
> (...)
> Sample output :
> (...)
> temp_input1:
>             +370?C  (limit =   +0??C, hysteresis =   +0?C)
> temp_input2:
>           +450.0?C  (limit =   +0??C, hysteresis =   +0?C)
> temp_input3:
>           +2080.0?C  (limit =   +0??C, hysteresis =   +0?C)

These are 37, 45 and 208 degrees. Temperatures are stored in thousandth
of degrees. It had first been suggested that they would be in hundreds
of degrees, that might explain the error.

The 208 degrees has a special meaning, it of course isn't a real
temperature. This is a common output for unused/misconfigured
temperature sensors.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
