From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:23 +0000
Subject: Some personal updates
Message-Id: <20041120123850.09b91338.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

Just a couple personal updates for those of you who care:

1* My home server is back and up again. I had to put it offline during
the time I had no more permanent connection to Internet, then upgraded
the hardware because the server was a bit slow and too noisy as well.

You can see the server status here:
http://jdelvare.net1.nerim.net/php/sysinfo/

The server is based on the Supermicro DLE370 Philip Edelbrock kindly
forwarded to me. I had to plug an Ethernet NIC because the onboard one
looks dead. The heatsink was borrowed from an old Compaq desktop
computer found in my parent's attic (you don't know how hard it is to
find one who would fit on the old board nowadays), CPU fan is a 80mm
Noiseblocker S2 low speed (2000 RPM) model, power-suply is a silent 300W
Fortron model (120mm fan), all in a case I borrowed to my neighbor
(thanks lad). Last but not least, I used the 160GB Seagate harddisk
drive offered by Wincor-Nixdorf, which is really quiet so all in all the
box can hardly be heard unless the room is absolutely silent.

Too bad the two other computers in the room are soooooo loud.

Power consumption was reduced to 42W (no screen, not even a graphics
adapter) so I can leave it on all the time without too high an impact on
the electricity bill.

2* I experienced a harddisk precrash on my main (development) computer.
I'm currently in the process of copying every data to the server (thank
Wincor-Nixdorf again for the big harddisk driver) and moving all my
development activities to my laptop again.

Thank the SMART technology for letting me know before the disk actually
crashed. Not sure what exactly the problem is, I was able to recover all
my data, only the MBR was hurt as far as I could see, but it could be
restored by lilo.

Whatever, I don't trust the disk anymore, nor the other one (IBM
GXP-DTLA anyone?) which I had to RMA once already, so I really have to
get rid of both as soon as possible.

Expect some delay in my answers to the various questions directed at me
as the result of this. I'm doing my best but the incident took much of
my time for the last 2 days and will probably do so for the next 2 as
well.

-- 
Jean Delvare
http://khali.linux-fr.org/
