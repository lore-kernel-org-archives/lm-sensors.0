From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:31 +0000
Subject: Asus A7V600 - temperature monitoring
Message-Id: <20031229205353.71ac5a35.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3FF07623.6010108@ii.pw.edu.pl>
In-Reply-To: <3FF07623.6010108@ii.pw.edu.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> The Asus A7V600 motherboard uses IT8712F chip for hardware monitoring.
> Similar to Asus A7V8X-X, the A7600 has temperatures inverted, but the 
> CPU Temp needs a different conversion formula:
> 
> label temp1       "CPU Temp"
> label temp2       "M/B Temp"
> compute temp1     (@+128)/3, (3*@-128)

Thanks a lot for the feedback. I've been adding this information to our
default configuration file so that it can benefit other users as well.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
