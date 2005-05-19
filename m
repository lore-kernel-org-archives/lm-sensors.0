From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:30 +0000
Subject: lm_sensors error. Complete output of problem.
Message-Id: <3C6FD641.1AB0D72F@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020217024154.A1328@geolandia.home>
In-Reply-To: <20020217024154.A1328@geolandia.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I don't see w83781d or eeprom in lsmod or dmesg.
Did you modprobe them as sensors-detect recommended?
Also, 2.5.5 is over a year old, we recommend you
get the latest release (2.6.2).

Antonio Gennarini wrote:
> 
> Hi.
> 
> It's days now that I'm trying to get lm_sensors to work on my RH7.1 and Asus motherboard but tere's nothing to do. I read the FAQ very well but nothing. The only chance I have is that you help me out somehow. The sensors detect reveal sensors on my PC but when I run 'sensors' i get 'No sensors found' even with all modules loadeed in memory. I have tried with 2.4.2 kernel (i2c loaded as modules) and 2.4,14 kernel (i2c compiled directly into kernel) In both cases the result is the same, same errror. In the attached file there is all the material and outputs requested by the FAQ so I hope it will help figure out hte problem.
> 
> Bye and thanks.
> --
>                  Antonio Gennarini
>                 Crecchio, CH - ITALY
>         -----------------------------------
> Earth Science student at University "G. D'Annunzio".
>      Join th GNU generation, start from LINUX.
> 
> 
> 
>    lm_sensorsName: lm_sensors
>              Type: Plain Text (text/plain)
