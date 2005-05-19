From: miguelk@konsultex.com.br (Miguel Koren OBrien de Lacy)
Date: Thu, 19 May 2005 06:25:23 +0000
Subject: Intel motherboard support question
Message-Id: <20041121205003.M20087@konsultex.com.br>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041116003713.M51520@konsultex.com.br>
In-Reply-To: <20041116003713.M51520@konsultex.com.br>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean;

Thank you for the insight. I plan on using kernel 2.6 mostly because of SATA support.
My other possibility is an ASUS PC DL Deluxe board where I feel lm_sensors would have
no problems. But since the Intel board "seems" to have better SATA chips, meaning less
problems with a standard installation, I had set my heart on that one. So, it looks
like a difficult choice. As I told another person that had some suggestions similar to
yours, I'll let you know how it works out. If you have some pointers about the ASUS
board, I would like to hear them also.

Miguel

--
Konsultex Informatica (http://www.konsultex.com.br)

---------- Original Message -----------
From: Jean Delvare <khali@linux-fr.org>
To: Miguel Koren OBrien de Lacy <miguelk@konsultex.com.br>
Cc: LM Sensors <sensors@stimpy.netroedge.com>
Sent: Sun, 21 Nov 2004 19:10:43 +0100
Subject: Re: Intel motherboard support question

> Hi Miguel,
> 
> > I'm thinking of using the Intel SE7320SP2 board
> > (http://www.intel.com/design/servers/boards/se7320sp2/index.htm) which
> > has the Intel E7320 chipsetand. I haven't been able to find out if it
> > will work with lm_sensors. Would it work?
> 
> The E7320 includes an ICH-5R component, for which we have a driver. This
> gives you access to the board SMBus (on which hardware monitoring chips
> usually live).
> 
> The technical documentation of the board says that it uses a National
> Semiconductor LM93 chip for hardware monitoring. It also mentions mBMC
> and IPMI, which makes me wonder if the LM93 is directly accessible over
> the SMBus or not.
> 
> There is a LM93 driver available for Linux 2.4, written by Mark M.
> Hoffman. The driver was not ported to 2.6 yet, but maybe Mark or someone
> else will do at some point in the future.
> 
> We also have some support for BMC/IPMI but only for Linux 2.4 and it is
> somewhat experimental as I understand it.
> 
> The board also has a Super-I/O chip which may hold hardware monitoring
> functions. The datasheet isn't very clear whether this is a PC87417 or
> PC87427. The latter has hardware monitoring capabilities, but this
> sounds somewhat redundant with the aforementioned LM93.
> 
> Put in short, the board is pretty new and support for it is just being
> added or missing at the moment, depending on the exact design, which I
> cannot guess. You should not pick this one it you want hardware
> monitoring to work right out of the box, because it most likely won't,
> especially if you intend to use Linux 2.6 kernels. However, the board
> seems to have a very good potential for hardware monitoring, and all the
> chips used are fairly well documented, so whatever support is missing
> can be added later (but with no timeline).
> 
> > Is there a list to tell which motheborads work with lm_sensors?
> 
> No, we don't have such a list. As written in our FAQ, we support chips,
> not boards. Tracking all boards out there is too broad a task, and
> hardly interesting since our drivers are aimed at chips, not boards,
> anyway.
> 
> Lists of supported chips:
> http://secure.netroedge.com/~lm78/supported.html
> http://secure.netroedge.com/~lm78/newdrivers.html
> http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/doc/chips/SUMMARY
> 
> Chip/board list from the MBM project (discontinued):
> http://mbm.livewiredev.com/mobolist.html
> 
> -- 
> Jean Delvare
> http://khali.linux-fr.org/
> 
> -- 
> Esta mensagem foi verificada pelo sistema de antiv?rus e
>  acredita-se estar livre de perigo.
------- End of Original Message -------


-- 
Esta mensagem foi verificada pelo sistema de antiv?rus e
 acredita-se estar livre de perigo.
