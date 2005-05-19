From: delvare@ensicaen.ismra.fr (DELVARE Jean)
Date: Thu, 19 May 2005 06:24:33 +0000
Subject: modprobe adm1021 causes abit nf7-s to hang
Message-Id: <20040109081153.M20913@ensicaen.ismra.fr>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I'm sorry that I cannot write you in French. I hope that English will
> suffice. Your website lists you as an active member of the LM Sensors
> project team. I apologize if I should have used an lmsensors ticket. 
> I could resubmit this report there if that is preferable.

Prefered solution is the mailing-list, CC'd.

> On Google I found this:
> http://archives.andrew.net.au/lm-sensors/msg04624.html
> 
> I'm experiencing the exact same problems with a 2.4.23 kernel and
> i2c-2.8.2 + lm_sensors-2.8.2 from source. My distro is Debian sid, 
> but lm_sensors is currently at 2.8.1-2, so I tried source instead before
> reporting a bug.

Strange you have the problem with 2.8.2, since what was believed to cause the
problem is supposed to be fixed since that version.

> I have compiled and installed i2c and lm_sensors. After this I have run
> sensors-detect. It suggests the following drivers:
> 
> # I2C adapter drivers
> i2c-nforce2
> i2c-nforce2
> i2c-isa
> # I2C chip drivers
> adm1021
> eeprom
> w83781d

Does it really list i2c-nforce2 twice? How strange. Maybe we should fix that.

> However, my box hangs after modprobing adm1021. I have tried your
> suggestion in the URL at the top, to use sensors-detect from CVS. There
> are some errors running it:
> 
> [adapter probings]
> ...
>  If you found that the adapter hung after probing a certain address, 
> you can specify that address to remain unprobed. That often includes 
> address 0x69 (clock chip). Error: First argument not a number!
> (...)

The sensors-detect script from CVS currently needs i2cdetect from CVS too. You
may be easier getting a full CVS checkout.

> Can I supply you with additional information to help you help me :) ?

I'd be interested in the following things:

1* A full run of sensors-detect, either 2.8.2 or CVS as long as it works, with
no driver loaded.

2* An i2cdetect run on all your i2c busses after loading i2c-nforce2 (but
before loading *any* chip driver).

My guess is that the adm1021 driver tries to handle a device that is not
adm1021-compatible. The requsted information should confirm or infirm this.

Thanks.

-- 
       /~~       Jean "Khali" Delvare
  -----\_                        mail: delvare@ensicaen.ismra.fr
 --------\                http://www.ensicaen.ismra.fr/~delvare/
---=ISMRA/- ____________________________________________________
