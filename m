From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 22 Jul 2007 08:33:46 +0000
Subject: Re: [lm-sensors] Fujitsu-Siemens Scylla (fscscy)
Message-Id: <20070722103346.0bec0a16@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <46933578.3010701@miloi.de>
In-Reply-To: <46933578.3010701@miloi.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Titus,

On Tue, 10 Jul 2007 09:30:00 +0200, Titus wrote:
> I'm new to this mailing list and I have some questions to the fscscy 
> module. I have searchted the archives and this subject does not seem to 
> have been posted already, so I hope I don't bother you with issues 
> already discussed.
> 
> - I did not manage to load the fscscy kernel module into kernel 2.6.18 
> (Debian Etch) and 2.6.21 (current kernel from kernel.org). Although all 
> seems to be compiled correctly, this kernel module was not built. Is 
> there any way to fix that?

The fscscy driver was not ported to Linux 2.6 yet. There was a first
request one year and a half ago:
http://lists.lm-sensors.org/pipermail/lm-sensors/2006-February/015319.html
http://lists.lm-sensors.org/pipermail/lm-sensors/2006-March/015489.html

Nobody volunteered yet to do the work. I've added your request on our
wiki/Devices page, but don't hold your breath. The FSC Scylla is an old
and rare chip, it's unlikely that anyone will volunteer to port it for
free.

> - Does the lm-sensors fscscy support monitoring the status of two 
> redundant power supplies (I have read the docs carefully but there seems 
> to be only temperatures and fan rpms, no PSU status support)? If not, is 
> it planned for the near future to support this?

The Scylla chip (as all other hardware monitoring chips) has a number
of sensor inputs (voltages, temperatures and fans). It has no idea what
these signals correspond to nor where they do come from. This really
depends on how the manufacturer wired the chip on the motherboard. So
the general answer is that no hwmon driver specifically handles
redundant PSUs because they don't have to.

> - Is there any way to port lm-sensors to freebsd or is there an 
> affiliate *BSD project where the fscscy module can be adapted to with 
> not too much effort?

lm-sensors is heavily based on procfs on Linux 2.4 and sysfs on Linux
2.6. As BSDs don't have anything like that as far as I know, there
really isn't anything to port. I seem to remember that one of the BSDs
has support for a limited number of popular hardware monitoring chips,
but the implementation is completely different. Anyway, this is really
a question you want to ask on a BSD list if you want a more accurate
answer.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
