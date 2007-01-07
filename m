From: salatiel.filho@gmail.com (Salatiel Filho)
Date: Sun, 07 Jan 2007 01:00:49 +0000
Subject: [lm-sensors] HP PAVILLION dv8000
Message-Id: <beb91d720701061700x7fd9a428qf3a133bbecc89f9b@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <beb91d720701061533r15ed4803h42d904ecfb0de1b4@mail.gmail.com>
In-Reply-To: <beb91d720701061533r15ed4803h42d904ecfb0de1b4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 1/6/07, Alexander Syring <noreply at asyring.homeip.net> wrote:
> Am Sonntag, 7. Januar 2007 00:33 schrieb Salatiel Filho:
> > Hi , i have a hp pavillion dv8000.
> >
> > sensors-detect build this file:
> >
> >
> > #----cut here----
> > # I2C adapter drivers
> > # modprobe unknown adapter NVIDIA i2c adapter 0 at 1:00.0
> > # modprobe unknown adapter NVIDIA i2c adapter 1 at 1:00.0
> > # modprobe unknown adapter NVIDIA i2c adapter 2 at 1:00.0
> > modprobe i2c-i801
> > # Chip drivers
> > # Warning: the required module ds1621 is not currently installed
> > # on your system. For status of 2.6 kernel ports check
> > # http://www.lm-sensors.org/wiki/Devices. If driver is built
> > # into the kernel, or unavailable, comment out the following line.
> look there ^^^^^^^^^^^^^^^^^^
> you have to compile the ds1621 kernel modul to load it and then senors find
> your sensor values
>
> > modprobe ds1621
> > # Warning: the required module eeprom is not currently installed
> > # on your system. For status of 2.6 kernel ports check
> > # http://www.lm-sensors.org/wiki/Devices. If driver is built
> > # into the kernel, or unavailable, comment out the following line.
> > modprobe eeprom
> > # sleep 2 # optional
> > /usr/local/bin/sensors -s # recommended
> > #----cut here----
> >
> >
> > but after all modules be SUCCESSFULLY loaded sensors -s still returns :
> >
> > No sensors found!
> > Make sure you loaded all the kernel drivers you need.
> > Try sensors-detect to find out which these are.
> >
> > What is the problem ???
> >
> > Thanks in advice ...
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors at lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>
Ok. sensors-detect now changed to :


#----cut here----
# I2C adapter drivers
# modprobe unknown adapter NVIDIA i2c adapter 0 at 1:00.0
# modprobe unknown adapter NVIDIA i2c adapter 1 at 1:00.0
# modprobe unknown adapter NVIDIA i2c adapter 2 at 1:00.0
modprobe i2c-i801
# Chip drivers
modprobe ds1621
modprobe eeprom
# sleep 2 # optional
/usr/local/bin/sensors -s # recommended

but i still get the same error loading sensors
No sensors found!
Make sure you loaded all the kernel drivers you need.
Try sensors-detect to find out which these are.


One odd thing that i notice is that it doesn`t exist i2c-i801 , it
does exit i2c_i801 so i have to change manually.


any other ideas ?

Thanks ...

-- 
[]'s
Salatiel

"O maior prazer do inteligente ? bancar o  idiota
   diante de um  idiota que banca o inteligente".

