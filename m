From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:30 +0000
Subject: Feedback Epox 8KHA+ w83781d
Message-Id: <3C7C5432.9ADCA8AE@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020226003211.GA9656@t-online.de>
In-Reply-To: <20020226003211.GA9656@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

let us know how the 697hf support is working.
'sensors' (not 'sensors -u') should work if
you are using CVS version and updated /etc/sensors.conf.
mds

Tim Krieglstein wrote:
> 
> Hi
> 
> I just wanted to give you some feedback:
> 
> I've got an Epox 8KHA+ (Via KT266) with an winbond W83697HF.
> After tampering around with your latest tarball i found
> no support for that chipset. So i wrote a short c programm attached
> to the mail. Then after thinking about integrating these findings
> into the module, i stumbled over the fact that the chip is supported
> in cvs. After fiddling around with the FAQ i finally got the module
> working. I confused i2c-isa and i2c-viapro (wich seems to work also)
> an it took me twice as long to get the module running than writing
> the small c programm...
> (The sensors-detect detects the chip correct but doesn't know that
> it is already supported!)
> 
> I 'll probably trim the values according to the bios
> values. If you are interested on these values or if you want me to
> test something just drop me a line.
> 
> Thank you
> 
> Cheers
> Tim
> --
> It's a damn poor mind that can only think of one way to spell a word. - Andrew Jackson
> 
> 
>                   Name: sensor.c
>    sensor.c       Type: text/x-csrc
>            Description: sensor.c
> 
>                      Name: sensors.out
>    sensors.out       Type: Plain Text (text/plain)
>               Description: output of c programm
> 
>                   Name: sensorsu
>    sensorsu       Type: Plain Text (text/plain)
>               Encoding: quoted-printable
>            Description: sensors -u (output)
