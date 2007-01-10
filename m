From: salatiel.filho@gmail.com (Salatiel Filho)
Date: Wed, 10 Jan 2007 12:54:59 +0000
Subject: [lm-sensors] HP PAVILLION dv8000
Message-Id: <beb91d720701100454g4a67e4acub87fdc555b70e421@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <beb91d720701061533r15ed4803h42d904ecfb0de1b4@mail.gmail.com>
In-Reply-To: <beb91d720701061533r15ed4803h42d904ecfb0de1b4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 1/7/07, Salatiel Filho <salatiel.filho at gmail.com> wrote:
> On 1/7/07, Jean Delvare <khali at linux-fr.org> wrote:
> > Hi Salatiel,
> >
> > On Sat, 6 Jan 2007 22:00:49 -0300, Salatiel Filho wrote:
> > > Ok. sensors-detect now changed to :
> > >
> > > #----cut here----
> > > # I2C adapter drivers
> > > # modprobe unknown adapter NVIDIA i2c adapter 0 at 1:00.0
> > > # modprobe unknown adapter NVIDIA i2c adapter 1 at 1:00.0
> > > # modprobe unknown adapter NVIDIA i2c adapter 2 at 1:00.0
> > > modprobe i2c-i801
> > > # Chip drivers
> > > modprobe ds1621
> > > modprobe eeprom
> > > # sleep 2 # optional
> > > /usr/local/bin/sensors -s # recommended
> > >
> > > but i still get the same error loading sensors
> > > No sensors found!
> > > Make sure you loaded all the kernel drivers you need.
> > > Try sensors-detect to find out which these are.
> > >
> > >
> > > One odd thing that i notice is that it doesn`t exist i2c-i801 , it
> > > does exit i2c_i801 so i have to change manually.
> >
> > You don't have to; modprobe handles dashes and underscores as the same
> > character.
> >
> > > any other ideas ?
> >
> > I think the ds1621 is a false positive, and your hardware monitoring
> > chip is different. It's an old chip and easily misdetected. I think I
> > remember a similar report some times ago, although I can't find it
> > again now. You didn't tell us which version of sensors-detect you have
> > been trying. Please try the latest version:
> > http://www.lm-sensors.org/browser/lm-sensors/trunk/prog/detect/sensors-detect?format=txt
> > It might detect your chip better. Please include the complete output of
> > the script.
> >
> > --
> > Jean Delvare
> >
> Hi Jean , i tried the latest version you said, now it changed to :
>
> modprobe i2c-i801
> modprobe eeprom
> # Warning: the required module coretemp is not currently installed
> # on your system. For status of 2.6 kernel ports check
> # http://www.lm-sensors.org/wiki/Devices. If driver is built
> # into the kernel, or unavailable, comment out the following line.
> modprobe coretemp
>
>
> I can not find coretemp in kernel 2.6.20.rc3 and i didn`t find a patch
> to download ...
> --
> []'s
> Salatiel
>
> "O maior prazer do inteligente ? bancar o  idiota
>    diante de um  idiota que banca o inteligente".
>

Ok. Found coretemp patch and it is working...
But how can i get FAN RPM ?


-- 
[]'s
Salatiel

"O maior prazer do inteligente ? bancar o  idiota
   diante de um  idiota que banca o inteligente".

