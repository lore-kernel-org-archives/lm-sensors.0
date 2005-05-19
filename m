From: delvare@ensicaen.ismra.fr (Jean Delvare)
Date: Thu, 19 May 2005 06:23:29 +0000
Subject: eeprom driver
Message-Id: <Pine.GSO.4.40.0202041834060.13875-100000@e3000.ensicaen.ismra.fr>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020201105452.C1871@Stimpy.netroedge.com>
In-Reply-To: <20020201105452.C1871@Stimpy.netroedge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> You know, I thought 57 was a funny address for your DIMM.  My guess is
> that it is something else, as you are thinking.  In the past, Xeon
> processors had a eeprom in them which appeared in addresses high like
> 57.
In case you want to know, the CPU is a Mobile Penium III 866 (with
SpeedStep technology, which make it operate at 500MHz when running on
battery.)  I may give you more information if you want (such as the output
of cat /proc/cpuinfo.)

> But, I'm still curious why only your first slot is detected and
> your second is not.  Anyways, thanks for the detective work thus far!
My pleasure.  I'm rather curious by nature.

-- 
       /~~       Jean "Khali" Delvare
  -----\_                        mail: delvare@ensicaen.ismra.fr
 --------\                http://www.ensicaen.ismra.fr/~delvare/
---=ISMRA/- ____________________________________________________
