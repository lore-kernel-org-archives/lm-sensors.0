From: ovis@thecourtofeden.org (ivo)
Date: Thu, 19 May 2005 06:25:13 +0000
Subject: i801 bus problems
Message-Id: <Pine.LNX.4.58.0409031428360.642@shi>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.58.0409022207200.19686@desitka.sh.cvut.cz>
In-Reply-To: <Pine.LNX.4.58.0409022207200.19686@desitka.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



On Fri, 3 Sep 2004, Jean Delvare wrote:

> > > But does "sensors" then display the corresponding memory information?
> >
> > How to determine, i am a rooky ;)
>
> Just run the "sensors" program. It should display something like:
>
> i2c-0-50:
> Memory Type: xxxxx
> Memory Size: xxxMB

sensors
Can't access procfs/sysfs file
Unable to find i2c bus information;
For 2.6 kernels, make sure you have mounted sysfs and done
'modprobe i2c_sensor'!
For older kernels, make sure you have done 'modprobe i2c-proc'!

sysfs is mounted for sure

modules loaded:

eeprom                  6920  0
lm85                   21380  0
i2c_sensor              4096  2 eeprom,lm85
i2c_i801                9744  0

gr ovis
