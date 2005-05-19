From: phil@netroedge.com (Philip Edelbrock)
Date: Thu, 19 May 2005 06:23:53 +0000
Subject: [office@ulisoft.net: 1-Wire Bus]
Message-Id: <3E9D9242.8030403@netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030416112900.GA23985@frodo.local>
In-Reply-To: <20030416112900.GA23985@frodo.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


I've played with the iButtons and have a few still on my keychain.  
Neato, although my Java crypto button died (apparently from a common 
defect in the battery on those).

Anyways, I'm not sure the Dallas iButtons are within the realm of 
Lm_sensors.  There isn't any need for kernel drivers (the ibutton reader 
plugs into a serial, parallel, or usb port), and many of the buttons are 
more than simple sensors (like the Java button).  They are more like 
smart-card devices than simple sensor chips.  Out of the 25+ ibuttons, 
only one is a simple temp sensor and it's probably best served by a 
'sensors'-like app which kicks out it's reading.

For the SDK, you can look here (as you probably already have):

http://db.maxim-ic.com/ibutton/example/

And, here are a couple open-source projects which support the iButtons:

http://freshmeat.net/projects/libow/
http://freshmeat.net/projects/mibfm/

If you think I'm crazy and have a case for rolling some support into 
Lm_sensors, feel free to make it.


Phil


Mark Studebaker wrote:

>there's no development now.
>when you actually start, let us know, and we will add your name to our new drivers list.
>
>Frodo Looijaard wrote:
>  
>
>>----- Forwarded message from Ulrich Moshammer <office@ulisoft.net> -----
>>
>>From: "Ulrich Moshammer" <office@ulisoft.net>
>>To: <frodol@dds.nl>
>>Subject: 1-Wire Bus
>>Importance: Normal
>>
>>Hi,
>>
>>
>>
>>I would like to write a bus driver fort he Dallas 1-wire bus.
>>
>>So my question is: Is there a development running on that bus?
>>
>>My development will start at about July. I do that in my spare time so
>>the development will not be much fast.
>>
>>
>>
>>With best regards
>>
>>
>>
>>__________________________________________________________________
>>Ulrich Moshammer
>>ICQ#: 65902973
>>
>>tech@ulisoft.net
>>
>>__________________________________________________________________
>>
>>
>>
>>----- End forwarded message -----
>>
>>--
>>Frodo Looijaard <frodol@dds.nl>  PGP key and more: http://huizen.dds.nl/~frodol
>>Defenestration n. (formal or joc.):
>>  The act of removing Windows from your computer in disgust, usually followed
>>  by the installation of Linux or some other Unix-like operating system.
>>    
>>
>
>  
>
