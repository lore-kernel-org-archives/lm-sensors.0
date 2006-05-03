From: devik@cdi.cz (Martin Devera)
Date: Wed, 03 May 2006 17:55:29 +0000
Subject: [lm-sensors] PC87427
Message-Id: <4458EE91.806@cdi.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

David Liontooth wrote:
> Hi Devik,
> 
> I was very interested to see you managed to get the Winbond PC87427
> work. I have the same chip on an Intel Server Board SE7525GP2. 
> According to http://secure.netroedge.com/~lm78/newdrivers.html, there
> are no plans to support this chip, as the full datasheet is missing --
> have you told them about your work? It would be nice if at least some
> preliminary support could be added to lm-sensors.
> 
> David

Hi,

on my mobo there is other sensor chip from AD, I use it via smbus master 
in HT1000 chipset. Thus only watchdog is working for me in PC87427, it 
is all I need. But from quick look you might use PC87417 DS - however 
problem is that they use ServerPathIO in 27 part which will be different 
and I found no info how the interface might work  :-(
devik

