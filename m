From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:35 +0000
Subject: two patches
Message-Id: <3D322847.28D5DDEA@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020715003408.7c5513a4.khali@linux-fr.org>
In-Reply-To: <20020715003408.7c5513a4.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I checked in the first one. Good catch.
Not really dangerous because the file modes in /proc of course
overrule whatever's in the library.

Let's hold off on the sensors change until after the release.

mds



Jean Delvare wrote:
> 
> Hello
> 
> Here are two patches for lm_sensors2 I wrote in the train two hours ago.
> 
> The first one fixes a (maybe dangerous) bug in libsensors where
> read-only features could be written and write-only features could be
> read.
> 
> The second one simply (re)indents the eeprom section of prog/sensors. I
> plan to make modifications on this part soon, and it was hardly readable
> the way it was before.
> 
> --
> Jean "Khali" Delvare
> http://www.ensicaen.ismra.fr/~delvare/
> 
> 
>                           Name: lm_sensors-and.diff
>    lm_sensors-and.diff    Type: Plain Text (text/plain)
>                       Encoding: base64
> 
>                                     Name: lm_sensors-indent-eeprom.diff
>    lm_sensors-indent-eeprom.diff    Type: Plain Text (text/plain)
>                                 Encoding: base64
