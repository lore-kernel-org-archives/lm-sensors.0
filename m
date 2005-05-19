From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:48 +0000
Subject: sensors.conf hint
Message-Id: <20030219225306.423a0a38.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030219214848.GA1084@debian>
In-Reply-To: <20030219214848.GA1084@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> In the section as99127f-* I've read:
>     # does anyone know a board for which the following is correct?
>     #   compute temp2 (@*30/43)+25, (@-25)*43/30
> 
> Well, with my board (ASUS A7V8X, chipset Via kt400, sensor chip
> ASB100) the row above gives correct values of CPU temperature. The
> default value(obtained using 'compute temp2 @*2.0, @/2.0') is wrong,
> 20C higher than real values.
> 
> I'm using lmsensors 2.7.0 and i2c 2.7.0 (w83781d, i2c-viapro) with
> kernel 2.4.20

Thanks a lot. This is actually the second time we have a report like
that. This formula was wrong for my motherboard, so I changed it. Now
I'll change the config file to list the motherboards that are known to
work with one or the other.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
