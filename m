From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:36 +0000
Subject: DMI detection
Message-Id: <3D42D5BD.93DA78CA@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020724162451.F8689@Stimpy.netroedge.com>
In-Reply-To: <20020724162451.F8689@Stimpy.netroedge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Great!
I'm taking the code from drivers/char/i8k.c
(which appears unchanged from at least kernels 2.4.17 through 2.5.28)
starting at line 502 through lines 662.

You should look at that code, and also at Alan's userspace program
dmidecode.c 
http://www.domsch.com/linux/patches/dmi/
and decide which is the best place to start for you.


Jean Delvare wrote:
> 
> > I'm going to work on putting DMI detection in i2c-piix4.
> > Any voluteers for doing the same in perl for sensors-detect? (please!)
> 
> I know Perl rather good, I will help as much as I can. If the only thing
> to do is C-to-Perl translation, I'm on it :)
> 
> --
> Jean "Khali" Delvare
> http://www.ensicaen.ismra.fr/~delvare/
