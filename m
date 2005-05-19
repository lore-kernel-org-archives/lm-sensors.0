From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:19 +0000
Subject: [feedback] Asus CUV4X correct settings
Message-Id: <20041016092748.641ff0e4.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <41703183.1040000@noiraude.net>
In-Reply-To: <41703183.1040000@noiraude.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Hello,

Salut Lea ;)

> Here is a feedback regarding proper setting for an Asus CUV4X
> motherboard.
> 
> chip "as99127f-*"
> 
> # If you know other boards where they are swapped, let us know and
> # we'll update the list.
> 
> Here it is :)
> 
> # Some working settings for Asus CUV4X VIAPro P3 CPU, kernel 2.6.8.1
> # lm_sensors 2.8.7
> 
> # Single power plane (A7V133, A7M266)
>     label in0 "VCore"
>     ignore in1
> 
> # However, some A7N8X boards (Deluxe rev.2, -X) have them swapped:
>     label temp1 "CPU Temp"
>     label temp2 "M/B Temp"
> 
> You can add CUV4X in this cathegory of single power line and reversed 
> CPI/M/B Temp

Thanks for reporting. I've updated the default configuration file.

> CPU Temp:    +34?C  (high =  +105?C, hyst =    +0?C)
> M/B Temp:  +28.0?C  (high =   +72?C, hyst =   +65?C)
> (...)
> With room temperature around 22?C it makes me very happy with the 
> current setting.
> 
> CPU is a Pentiom III (Coppermine) 733EB with 512Mb 133 DDR/SDRAM.

En effet c'est plus que correct. Mon Athlon 1200 est ? 51?C au repos :(
et le boitier a 35. Par contre j'ai un Pentium III 800EB sur carte ?
ciel ouvert (comprendre: pas de boitier, tous les ?l?ments du sont pos?s
directement sur mon bureau) qui dit ?a:

M/B Temp:    +28 C  (low  =    +0 C, high =   +50 C)   
CPU0 Temp:   +24 C  (low  =    +0 C, high =   +60 C)   

Je trouve que ?a le fait pas mal ;) d'antant que le ventillateur CPU est
un 80mm ? 1300 tours/minute donc tr?s silencieux Je ne sais pas ce que
ca va donner quand je lui aurai trouv? une maison cela dit.

Merci encore pour les infos en tout cas.

-- 
Jean Delvare
http://khali.linux-fr.org/
