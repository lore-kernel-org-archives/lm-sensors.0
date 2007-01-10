From: salatiel.filho@gmail.com (Salatiel Filho)
Date: Wed, 10 Jan 2007 17:03:36 +0000
Subject: [lm-sensors] HP PAVILLION dv8000
Message-Id: <beb91d720701100903m5a3c1929p9194091d546c8eba@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <beb91d720701061533r15ed4803h42d904ecfb0de1b4@mail.gmail.com>
In-Reply-To: <beb91d720701061533r15ed4803h42d904ecfb0de1b4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 1/10/07, Jean Delvare <khali at linux-fr.org> wrote:
> Hi Salatiel,
>
> On Wed, 10 Jan 2007 09:54:59 -0300, Salatiel Filho wrote:
> > On 1/7/07, Salatiel Filho <salatiel.filho at gmail.com> wrote:
> > > On 1/7/07, Jean Delvare <khali at linux-fr.org> wrote:
> > > > I think the ds1621 is a false positive, and your hardware monitoring
> > > > chip is different. It's an old chip and easily misdetected. I think I
> > > > remember a similar report some times ago, although I can't find it
> > > > again now. You didn't tell us which version of sensors-detect you have
> > > > been trying. Please try the latest version:
> > > > http://www.lm-sensors.org/browser/lm-sensors/trunk/prog/detect/sensors-detect?format=txt
> > > > It might detect your chip better. Please include the complete output of
> > > > the script.
> > >
> > > Hi Jean , i tried the latest version you said, now it changed to :
> > >
> > > modprobe i2c-i801
> > > modprobe eeprom
> > > # Warning: the required module coretemp is not currently installed
> > > # on your system. For status of 2.6 kernel ports check
> > > # http://www.lm-sensors.org/wiki/Devices. If driver is built
> > > # into the kernel, or unavailable, comment out the following line.
> > > modprobe coretemp
> > >
> > >
> > > I can not find coretemp in kernel 2.6.20.rc3 and i didn`t find a patch
> > > to download ...
> >
> > Ok. Found coretemp patch and it is working...
> > But how can i get FAN RPM ?
>
> You could start by providing the information I asked for 3 days ago.
>
> --
> Jean Delvare
>
Sorry, attached now ...

Coretemp detects cpu temperature but i can not get fan rpm


-- 
[]'s
Salatiel

"O maior prazer do inteligente ? bancar o  idiota
   diante de um  idiota que banca o inteligente".
-------------- next part --------------
A non-text attachment was scrubbed...
Name: output
Type: application/octet-stream
Size: 8271 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20070110/64f8069a/attachment.obj 
